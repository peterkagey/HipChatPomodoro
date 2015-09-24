# HipChatPomodoro
Dan's killer app idea.

## Setup
### Generate a HipChat access token
Log into your [HipChat account](https://www.hipchat.com/account/api), select "Send Notification" in the scope and hit "create".

### Set that environment variable
Next save the HipChat token into an environment variable in your `.bash_profile` (or wherever you keep these things):
`export HIPCHAT_AUTH_TOKEN="h1Pch4TAuTHt0k3n"`

## What does it do?
1. Sets your current HipChat status to "do not disturb".
2. Sets your current HipChat status message to tell folks when they can expect you back.
3. Switches everything back to normal once the timer's done.
4. Plays an annoying beep once the timer's done.

## How to use it.
Clone the repo and `cd` into the project root.
Add an alias to your `.bash_profile`:
`alias pomodoro="ruby path/to/HipChatPomodoro/script.rb`
Run, say, `pomodoro 25` to run a 25 minute timer.
(Without an argument, the timer defaults to 5 minutes.)
At the end of the timer the annoying alarm will go off until you kill the process. (`ctrl+c`)

### Contributing
This script probably won't work for you, so let me know if you need me to fix anything. Better yet, fix it yourself and submit a pull request.
