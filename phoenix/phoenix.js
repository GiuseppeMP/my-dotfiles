// KNOWN ISSUE
// doesn't work on minimized apps
// https://github.com/kasper/phoenix/issues/269

// Presets

const topHalf = {
    left: 0,
    top: 0,
    right: 0,
    bottom: 0.5,
};

const leftHalf = {
    left: 0,
    top: 0,
    right: 0.5,
    bottom: 0,
};

const lowerLeftHalf = {
    left: 0,
    top: 0.5,
    right: 0.5,
    bottom: 0,
};

const rightHalf = {
    left: 0.5,
    top: 0,
    right: 0,
    bottom: 0,
};

const full = {
    left: 0.0,
    top: 0.0,
    right: 0.0,
    bottom: 0.0,
};


// Binds

quakeApp({
    key: "return",
    modifiers: ["cmd", "shift"],
    appName: "kitty",
    position: full,
    followsMouse: true,
    hideOnBlur: false
});

openApp({
    key: "f",
    modifiers: ["cmd", "ctrl"],
    appName: "Firefox"
});

openApp({
    key: "return",
    modifiers: ["cmd", "ctrl"],
    appName: "WezTerm",
});

openApp({
    key: "o",
    modifiers: ["cmd", "ctrl"],
    appName: "Obsidian",
});

openApp({
    key: "1",
    modifiers: ["cmd", "ctrl"],
    appName: "WezTerm",
});

openApp({
    key: "2",
    modifiers: ["cmd", "ctrl"],
    appName: "Firefox"
});

openApp({
    key: "3",
    modifiers: ["cmd", "ctrl"],
    appName: "Obsidian"
});


openApp({
    key: "4",
    modifiers: ["cmd", "ctrl"],
    appName: "Bruno"
});

openApp({
    key: "5",
    modifiers: ["cmd", "ctrl"],
    appName: "zoom.us"
});

openApp({
    key: "6",
    modifiers: ["cmd", "ctrl"],
    appName: "System Settings"
});

openApp({
    key: "7",
    modifiers: ["cmd", "ctrl"],
    appName: "Podcasts"
});

openApp({
    key: "8",
    modifiers: ["cmd", "ctrl"],
    appName: "Spotify"
});

openApp({
    key: "9",
    modifiers: ["cmd", "ctrl"],
    appName: "1Password"
});

openApp({
    key: "0",
    modifiers: ["cmd", "ctrl"],
    appName: "Focus To-Do"
});







// Scripts

/**
 * Error message for invalid display settings
 */
const DISPLAYS_HAVE_SEPARATE_SPACES = `Must set Apple menu > System Preferences > Mission Control > Displays have Separate Spaces`;


/**
 * Create a keyboard event listener which implements a quake app
 * @param {string} key the key which triggers the app
 * @param {string[]} modifiers the modifiers which must be used in combination with the key (["alt", "ctrl"])
 * @param {string} appName the name of the app
 */
function openApp({
    key,
    modifiers,
    appName
}) {
    Key.on(key, modifiers, async function(_, repeat) {
        if (repeat) {
            console.log("repeat" + repeat)
            return;
        }

        let [app, opened] = await startApp(appName, { focus: true });

        console.log("beforeMoveAppToActiveSpace" + app);

        const { moved, space } = moveAppToActiveSpace(app, true);

        console.log("afterMoveAppToActiveSpace" + app);

        if (app !== undefined) {
            if (app.isActive() && !opened) {
                console.log("Hide" + app.hide());
            } else {
                console.log("Focus" + app.focus());
            }
        } else {
            console.log(`app ${appName} undefined`);
        }
    });
}

/**
 * Create a keyboard event listener which implements a quake app
 * @param {string} key the key which triggers the app
 * @param {string[]} modifiers the modifiers which must be used in combination with the key (["alt", "ctrl"])
 * @param {string} appName the name of the app
 * @param {{left: number, top: number, right: number, bottom: number}} relativeFrame the margins to place the application in.
 * @param {followsMouse} boolean whether the app should open in the screen containing the mouse
 * @param {hideOnBlur} boolean whether the window should hide when it loses focus
 */
function quakeApp({
    key,
    modifiers,
    appName,
    position,
    followsMouse,
    hideOnBlur,
    args
}) {
    Key.on(key, modifiers, async function(_, repeat) {
        // ignore keyboard repeats
        if (repeat) {
            return;
        }
        let [app, opened] = await startApp(appName, { focus: false });

        console.log("APP" + app)

        // if the app started
        if (app !== undefined) {
            // move the app to the currently active space
            const { moved, space } = moveAppToActiveSpace(app, followsMouse);

            // set the app position
            setAppPosition(app, position, space);

            // hide the app if it is active and wasn't just opened or moved to
            // a new space
            //if (app.isActive() && !opened && !moved) {
            console.log(`active: ${app.isActive()} opened: ${opened} moved: ${moved}`)
            if (app.isActive() && !opened && !moved) {
                console.log("Hide" + app.hide());
            } else {
                console.log("Focus" + app.focus());
            }

            if (hideOnBlur) {
                const identifier = Event.on("appDidActivate", (activatedApp) => {
                    if (app.name() !== activatedApp.name()) {
                        app.hide();
                        Event.off(identifier);
                    }
                });
            }
        }
    });
}

/**
 * Positions an application using margins which are a percentage of the width and height.
 * left: 0 positions the left side of the app on the left side of the screen.
 * left: .5 positions the left side of the app half the width from the left side of the screen.
 * {left: 0, right: 0, top: 0, bottom: 0} would be full screen
 * {left: .25, right: .25, top: .25, bottom: .25} would be centered with half the screen height
 * {left: 0, right: .5, top: 0, bottom: .5} would be the top left quadrant
 * @param {App} app the application to set the position of
 * @param {{left: number, top: number, right: number, bottom: number}} relativeFrame the margins to place the application in.
 * @param {Space} space the space to position the app in
 */
function setAppPosition(app, relativeFrame, space) {
    const mainWindow = app.mainWindow(); // get app window

    if (space.screens().length > 1) {
        // check one space per screen
        throw new Error(DISPLAYS_HAVE_SEPARATE_SPACES);

    } else if (space.screens().length > 0) {
        // set the position of the app
        const activeScreen = space.screens()[0];
        const screen = activeScreen.flippedVisibleFrame();

        const left = screen.x + relativeFrame.left * screen.width;

        const top = screen.y + relativeFrame.top * screen.height - 1;
        // const right = (screen.x + screen.width - relativeFrame.right * screen.width) - 5;
        const right = screen.x + screen.width - relativeFrame.right * screen.width;
        const bottom = screen.y + screen.height - relativeFrame.bottom * screen.height;

        if (mainWindow.isFullScreen()) {
            mainWindow.setFullScreen(false);
        }

        mainWindow.setTopLeft({
            x: left,
            y: top,
        });
        mainWindow.setSize({
            width: right - left,
            height: bottom - top,
        });
    }
}

/**
 * Move the passed in App to the currently active space
 * Returns whether the app was moved and the space the app is now in.
 * @param {App} app the application to move to the active space
 * @param {boolean} followsMouse whether the app should open in the screen containing the mouse or the key with keyboard focus
 */
function moveAppToActiveSpace(app, followsMouse) {
    let moved = false;
    let activeSpace = undefined

    try {
        activeSpace = followsMouse ? mouseSpace() : Space.active();
        const mainWindow = app.mainWindow(); // get app window

        if (mainWindow.spaces().length > 1) {
            // check one space per screen
            throw new Error(DISPLAYS_HAVE_SEPARATE_SPACES);
        }
        if (activeSpace !== undefined) {
            // check if the main window was moved
            moved = !!!(
                mainWindow.spaces().length > 0 &&
                mainWindow.spaces()[0].isEqual(activeSpace)
            );
            if (moved) {
                // otherwise remove the main window from the spaces it is in
                mainWindow.spaces().forEach((space) => {
                    space.removeWindows([mainWindow]);
                });
                // add window to active space
                activeSpace.addWindows([mainWindow]);
            }
        }
    } catch (e) {
        console.log(e);
    }

    return { moved, space: activeSpace };
}

/**
 * Get or launch the application with the passed in name.
 * Returns the app and a boolean for if the app was opened. app is undefined if the application fails to start.
 * @param {string} appName the name of the application to start
 * @param {{focus: boolean}} options focus determines whether or not to focus the app on launch
 */
async function startApp(appName) {
    // https://github.com/kasper/phoenix/issues/209
    // basically a hack to get around this bug

    // get the app if it is open
    let app = await App.get(appName);
    console.log("startApp" + appName);
    console.log("startApp" + app);

    let opened = false;

    // if app is open
    if (app !== undefined) {
        // make sure it has an open window

        console.log(app.windows());
        console.log(app.windows().length);
        if (app.windows().length === 0) {

            console.log("execute reopen");
            // if not open a new window
            await osascript(
                `tell application "${appName}"
        try
            reopen
        on error
          log "can not reopen the app"
          activate
        end
          end tell
        `);


            opened = true;
        } else {
            console.log("app.windows() !== 0");
        }
    } else {
        console.log("execute activate");
        // if app is not open activate it
        await osascript(`tell application "${appName}"
            activate
          end tell
        `);

        app = await App.get(appName);
        opened = true;
    }

    console.log(`returning app: ${app} opened: ${opened}`);
    return [app, opened];
}

/**
 * Return a promise containing the Task handler used to run the osascript.
 * The promise is resolved or rejected with the handler based on the status.
 * @param {string} script the osascript script to run
 */
function osascript(script) {
    return new Promise((resolve, reject) =>
        Task.run("/usr/bin/osascript", ["-e", script], (handler) => {
            if (handler.status === 0) {
                return resolve(handler);
            } else {
                return reject(handler);
            }
        })
    );
}

/**
 * Get the space which contains the mouse
 */
function mouseSpace() {
    const mouseLocation = Mouse.location();
    const screen = Screen.all().find((s) =>
        screenContainsPoint(s, mouseLocation)
    );
    if (screen !== undefined) {
        return screen.currentSpace();
    }
}

/**
 * Return whether the point is contained in the screen
 * @param {Screen} screen a screen object to check for a point
 * @param {Point} point a point using flipped coordinates (origin upper left)
 */
function screenContainsPoint(screen, point) {
    const frame = screen.flippedFrame();
    return (
        point.x >= frame.x &&
        point.x <= frame.x + frame.width &&
        point.y >= frame.y &&
        point.y <= frame.y + frame.height
    );
}




