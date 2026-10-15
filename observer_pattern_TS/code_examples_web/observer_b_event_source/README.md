# Observer Pattern - Approach B: Event Source

Approach B: the sensor passes itself to update(subject), so the Observers don't need to store a reference to it.

A temperature sensor (the **Subject**) has two **Observers**:

1. a **JSON log** - records every reading, and shows the whole log as JSON
2. a **category display** - shows HOT (above 25°C), WARM (20-25°C), COOL (15-19°C) or COLD (below 15°C)

Click a temperature button: the button only changes the sensor's temperature. The sensor then notifies
its Observers, and each one updates its own part of the page.

In this approach `notify()` calls `observer.update(this)` - the Subject passes **itself** as the event source. The
Observers have no `sensor` field: they call `subject.getTemperature()` on the Subject they are given. That works
because the abstract `Subject` declares an abstract `getTemperature()`.

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

- `src/Subject.ts` - the abstract **Subject**: `attach()`, `detach()`, `notify()` - and an abstract `getTemperature()`
- `src/Observer.ts` - the **Observer** interface: `update(subject: Subject)`
- `src/TemperatureSensor.ts` - the concrete Subject: `getTemperature()` and `setTemperature()`
- `src/JsonLogObserver.ts` and `src/CategoryObserver.ts` - the two concrete Observers
- `src/TemperatureCategory.ts` - turns a temperature into HOT, WARM, COOL or COLD
- `src/main.ts` - the entry point, and the only file that touches the page
- `tests/` - the tests
- `class_diagram.story` - slides: the project's UML class diagram, then one slide per class (open it in Celbridge)
- `uml_revision.story` - slides: a reference to the UML notation in the class diagram (classes, visibility, interfaces, inheritance, association, dependency, ...)

Notes and diagrams for this approach: [3_ObserverEventSource.md](../../3_ObserverEventSource.md)
