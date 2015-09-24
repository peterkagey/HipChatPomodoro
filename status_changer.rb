require 'open-uri'
require 'json'

class HipChatUser

  attr_accessor :show, :status

  def initialize(name, title, show, mention_name, timezone, email, status=nil)
    @name         = name
    @title        = title
    @show         = show
    @status       = status
    @mention_name = mention_name
    @timezone     = timezone
    @email        = email
  end

  def to_json
    {
      "name" => @name,
      "title" => @title,
      "presence" => {
        "status" => @status,
        "show" => @show
      },
      "mention_name" => @mention_name,
      "timezone" => @timezone,
      "email" => @email
    }.to_json
  end

end


class UserChanger

  USER_NAME = "@PeterKagey"
  MESSAGE_URL = "https://api.hipchat.com/v2/user/#{USER_NAME}"
  AUTH_TOKEN  = "?auth_token=" + ENV['HIPCHAT_AUTH_TOKEN']
  ENDPOINT = "#{MESSAGE_URL}#{AUTH_TOKEN}"

end

class UserGetter < UserChanger

  def self.query
    response = open(ENDPOINT).read
    old_status = JSON.parse(response)
    HipChatUser.new(
      old_status["name"],
      old_status["title"],
      old_status["presence"]["show"],
      old_status["mention_name"],
      old_status["timezone"],
      old_status["email"]
    )
  end

end

class UserSetter < UserChanger

  def initialize(new_show, new_status=nil)
    @old_user_status = UserGetter.query
    @new_user_status = @old_user_status
    update_status(new_show, new_status)
    set_new_status
  end

  def update_status(new_show, new_status)
    @new_user_status.show = new_show
    @new_user_status.status = new_status
  end

  def set_new_status
    uri = URI.parse(ENDPOINT)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Put.new(uri.request_uri)
    request.add_field('Content-Type', 'application/json')
    request.body = @new_user_status.to_json
    http.request(request)
  end

end
