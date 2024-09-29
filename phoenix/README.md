# Phoenix (MacOS)

I am using Phoenix on macOS as a lightweight replacement for iTerm and Guake Modes.

https://kasper.github.io/phoenix/

## Install

```ssh
brew install --cask phoenix
```


## Config

For more example see the [phoenix.js](./phoenix.js)

To install this configuration, refer to the Makefile located at ./Makefile.

```sh
cd ./phoenix
make
```

```js
// You can use guakeApp or startApp to bind things
// Example:
quakeApp({
    key: "return",
    modifiers: ["cmd", "shift"],
    appName: "kitty",
    position: full, // change position
    followsMouse: true,
    hideOnBlur: false
});

// or

openApp({
    key: "1",
    modifiers: ["cmd", "ctrl"],
    appName: "WezTerm",
});

```
