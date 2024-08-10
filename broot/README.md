# I'm BROOT


## Install

```sh
brew install broot
```


## Config

Add aliases to ~/.zshrc

You can use defaultFlags inside config, I prefer to use aliases, don't judge me.
I've also replaced the default `ls` with broot.

[show sizes, data, permissions ,hidden files, gitinfo ]

```sh
echo "alias br='broot -sdphg'" >> ~/.zshrc
echo "alias ls='broot -sdphg'" >> ~/.zshrc
```

```sh
# copy conf.hjson and verbs.hjson to your ~/.config/broot
```
