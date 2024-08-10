# Starship 

https://starship.rs/guide/

## Install

```sh
brew install starship
mkdir -p ~/.config && touch ~/.config/starship.toml

# add the following to your ~/.zshrc
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
```

## Config

```toml
# Get editor completions based on the config schema
"$schema" = 'https://starship.rs/config-schema.json'

command_timeout = 3000

# Inserts a blank line between shell prompts
add_newline = true

# Replace the '❯' symbol in the prompt with '➜'
[character] # The name of the module we are configuring is 'character'
success_symbol = '[▊ I ❯](bold green)' # The 'success_symbol' segment is being set to '➜' with the color 'bold green'
vimcmd_symbol = '[▊ N ❯](bold blue)'
error_symbol = '[✗](bold red)'
vimcmd_visual_symbol = '[V](bold purple)'

# You can edit the command in a vim buffer using the key `vv` 

# Disable the package module, hiding it from the prompt completely
[package]
disabled = false

[gcloud]
disabled = true

[aws]
disabled = true
```
