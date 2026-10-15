# Observer Pattern - Approach B: Event Source (terminal version)

Approach B: the sensor passes itself to update(subject), so the Observer doesn't need to store a reference to it.

A temperature sensor (the **Subject**) has one **Observer**, which prints whether the new temperature is HOT (above 25°C),
WARM (20-25°C), COOL (15-19°C) or COLD (below 15°C).

In this approach `notify()` calls `observer.update(this)` - the Subject passes **itself** as the event source. The
Observer has no `sensor` field: it calls `subject.getTemperature()` on the Subject it is given. That works because the
abstract `Subject` declares an abstract `getTemperature()`.

This is the simple, terminal-only version: no web page, no build step. The web version, with buttons and a second
(JSON log) Observer, is in [code_examples_web/observer_b_event_source](../../code_examples_web/observer_b_event_source/README.md).

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

- `src/Subject.ts` - the abstract **Subject**: `attach()`, `detach()`, `notify()` - and an abstract `getTemperature()`
- `src/Observer.ts` - the **Observer** interface: `update(subject: Subject)`
- `src/TemperatureSensor.ts` - the concrete Subject: `getTemperature()` and `setTemperature()`
- `src/CategoryObserver.ts` - the concrete Observer
- `src/TemperatureCategory.ts` - turns a temperature into HOT, WARM, COOL or COLD
- `src/main.ts` - the entry point: makes the sensor and its Observer, then reads temperatures from the keyboard
- `tests/` - the tests
- `class_diagram.story` - slides: the project's UML class diagram, then one slide per class (open it in Celbridge)
- `uml_revision.story` - slides: a reference to the UML notation in the class diagram (classes, visibility, interfaces, inheritance, association, dependency, ...)

## Exercise: add a JSON log Observer

Add a second Observer, `JsonLogObserver`, that keeps a log of every reading and saves it to `temperature_log.json`:

1. Create `src/JsonLogObserver.ts`, with a class that `implements Observer` - use `CategoryObserver` as a model.
2. Give it an array of readings, e.g. `{ reading: 1, celsius: 21 }`.
3. In `update(subject)`, ask `subject` for the temperature, add a reading to the array, and save the whole array:
   `Deno.writeTextFileSync("temperature_log.json", JSON.stringify(this.readings, null, 2));`
4. In `src/main.ts`, attach a new `JsonLogObserver` to the sensor, next to the `CategoryObserver`.

Writing a file needs permission, so run the program with:

```bash
deno run --allow-write=temperature_log.json src/main.ts
```

Notes and diagrams for this approach: [3_ObserverEventSource.md](../../3_ObserverEventSource.md)
