# Git Stuff


## Git Configuration


```ini
[init]
	defaultBranch = main

[alias]

lg1 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s    %C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all

lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)    (%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all

lg = !"git lg1"

st = status

ls = !st

[core]
	autocrlf = false
	editor = nvim
[user]
	name = GiuseppeMP
	email = giuseppemath@gmail.com

``````
