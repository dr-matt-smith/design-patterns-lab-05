# Observer Pattern - Approach C: Callback Functions (terminal version)

Approach C: no Observer interface - the sensor calls a plain function, passing it the new temperature.

A temperature sensor (the **Subject**) has one **Observer**, which prints whether the new temperature is HOT (above 25°C),
WARM (20-25°C), COOL (15-19°C) or COLD (below 15°C).

In this approach there is **no Observer interface** and no `update()`. The sensor keeps a list of functions of type
`TemperatureListener = (celsius: number) => void`, and `notify()` calls each one with the new temperature (a **push**
model). The Observer is just an arrow function, in `src/main.ts`. `attach()` returns an **unsubscribe** function.

This is the simple, terminal-only version: no web page, no build step. The web version, with buttons and a second
(JSON log) Observer, is in [code_examples_web/observer_c_callbacks](../../code_examples_web/observer_c_callbacks/README.md).

## Running it

In a terminal, in this folder (the one with this README in it):

```bash
deno run src/main.ts
```

Type a temperature and press **Enter** - the sensor changes, and the Observer prints its message. Press **Enter** on its
own to stop. For example:

```text
Temperature in °C (or just press Enter to stop): 21
21°C is WARM
Temperature in °C (or just press Enter to stop): 27.5
27.5°C is HOT
Temperature in °C (or just press Enter to stop):
```

In Celbridge, the console at the bottom runs this for you when the project opens.

## Running the tests

```bash
deno test
```

## What to look at

- `src/Subject.ts` - the `TemperatureListener` function type, and the abstract **Subject**: `attach()` (which returns an unsubscribe function), `detach()`, `notify()` and an abstract `getTemperature()`
- `src/TemperatureSensor.ts` - the concrete Subject: `getTemperature()` and `setTemperature()`
- `src/TemperatureCategory.ts` - turns a temperature into HOT, WARM, COOL or COLD
- `src/main.ts` - the entry point: makes the sensor and its Observer, then reads temperatures from the keyboard
- `tests/` - the tests
- `class_diagram.story` - slides: the project's UML class diagram, then one slide per class (open it in Celbridge)
- `uml_revision.story` - slides: a reference to the UML notation in the class diagram (classes, visibility, interfaces, inheritance, association, dependency, ...)

## Exercise: add a JSON log Observer

Add a second Observer that keeps a log of every reading and saves it to `temperature_log.json`:

1. Create `src/JsonLog.ts`, with an ordinary class `JsonLog` (it doesn't need to implement anything).
2. Give it an array of readings, e.g. `{ reading: 1, celsius: 21 }`, and a method `record(celsius: number)` that adds
   a reading and saves the whole array:
   `Deno.writeTextFileSync("temperature_log.json", JSON.stringify(this.readings, null, 2));`
3. In `src/main.ts`, make a `JsonLog`, and attach an arrow function that calls its `record()` method:
   `sensor.attach((celsius) => jsonLog.record(celsius));`
   (Why not `sensor.attach(jsonLog.record)`? Try it - and see the notes on losing `this`.)

Writing a file needs permission, so run the program with:

```bash
deno run --allow-write=temperature_log.json src/main.ts
```

Notes and diagrams for this approach: [4_ObserverCallbacks.md](../../4_ObserverCallbacks.md)
