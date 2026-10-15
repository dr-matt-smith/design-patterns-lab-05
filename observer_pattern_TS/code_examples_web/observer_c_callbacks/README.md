# Observer Pattern - Approach C: Callback Functions

Approach C: no Observer interface - the sensor calls plain functions, passing them the new temperature.

A temperature sensor (the **Subject**) has two **Observers**:

1. a **JSON log** - records every reading, and shows the whole log as JSON
2. a **category display** - shows HOT (above 25°C), WARM (20-25°C), COOL (15-19°C) or COLD (below 15°C)

Click a temperature button: the button only changes the sensor's temperature. The sensor then notifies
its Observers, and each one updates its own part of the page.

In this approach there is **no Observer interface** and no `update()`. The sensor keeps a list of functions of type
`TemperatureListener = (celsius: number) => void`, and `notify()` calls each one with the new temperature (a **push**
model). Observer 1 is an arrow function that calls a `JsonLog` object's `record()` method; Observer 2 is just an
arrow function. `attach()` returns an **unsubscribe** function.

## Running it

Open the project in Celbridge. The console at the bottom starts by itself, and runs `deno task dev`:

1. **builds** `src/` (TypeScript) and `public/` (HTML, CSS, images) into `dist/`
2. **tests** everything in `tests/`, printing the results in the console (in TAP format) and writing a
   readable report to `test_output/index.html` (and `test_output/summary.md`)
3. **watches** - every time you save a file in `src/`, `public/` or `tests/`, it does it all again

`dist/index.html` opens beside the console. After a rebuild, its preview's **refresh** button lights
up - press it to see your changes. The clipboard icon opens the test report.

The console's buttons: rebuild-and-watch, build once, test once, and lint. To use them while the
watcher is running, press **Ctrl+C** first to stop it.

No server is needed: `dist/` is a plain web page, so you can also open `dist/index.html` in any browser.

## What to look at

- `src/Subject.ts` - the `TemperatureListener` function type, and the abstract **Subject**: `attach()` (which returns an unsubscribe function), `detach()`, `notify()` and an abstract `getTemperature()`
- `src/TemperatureSensor.ts` - the concrete Subject: `getTemperature()` and `setTemperature()`
- `src/JsonLog.ts` - an ordinary class (it implements nothing) whose `record()` method is attached via an arrow function
- `src/TemperatureCategory.ts` - turns a temperature into HOT, WARM, COOL or COLD
- `src/main.ts` - the entry point: attaches the two listener functions, and is the only file that touches the page
- `tests/` - the tests
- `class_diagram.story` - slides: the project's UML class diagram, then one slide per class (open it in Celbridge)
- `uml_revision.story` - slides: a reference to the UML notation in the class diagram (classes, visibility, interfaces, inheritance, association, dependency, ...)

Notes and diagrams for this approach: [4_ObserverCallbacks.md](../../4_ObserverCallbacks.md)
