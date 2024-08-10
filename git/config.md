# Git Stuff

## Git Delta

```sh
brew install git-delta
wget https://raw.githubusercontent.com/dandavison/delta/main/themes.gitconfig -P /tmp/delta-themes
mv /tmp/delta-themes/themes.gitconfig ~/.config/
```

## Git Configuration

Run:
```sh
git config --edit --global
```

Then copy the following configuration using the editor.

```ini
[user]
    ; change to your name and email 
	name = GiuseppeMP
	email = giuseppemath@gmail.com

[init]
	defaultBranch = main

[alias]

    lg1 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s    %C(reset) %C(dim yellow)- %an%C(reset)%C(bold red)%d%C(reset)' --all

    lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)    (%ar)%C(reset)%C(bold red)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim yellow)- %an%C(reset)' --all

    lg = !"git lg2"

    st = status

    ls = !"ls -lha"

[core]
	autocrlf = true
	editor = nvim
    pager = delta 

[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default

[include]
    path = ~/.config/themes.gitconfig

[delta "interactive"]
    keep-plus-minus-markers = false

[delta]
    features = villsau
    line-numbers = true
    side-by-side = true
    navigate = true 
    ; features =arctic-fox
    ; features = corvus
    ; features = woolly-mammoth 
    ; features = colibri
    ; features = coracias-caudatus 
    ; features = hoopoe
    ; features =tangara-chilensis 
    ; features = collared-trogo
    ; features = calochortus-lyallii
    ; features = mantis-shrimp
    ; features =mantis-shrimp-lite 
    ; features =zebra-dark
    ; features =chameleon
    ; features = gruvmax-fang
    ; features = discord
    ; features = mellow-barbet
```
