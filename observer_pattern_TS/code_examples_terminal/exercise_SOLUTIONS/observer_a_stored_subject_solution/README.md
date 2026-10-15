# Observer Pattern - Approach A: Stored Subject (terminal version) - EXERCISE SOLUTION

The solution to the exercise in [../../observer_a_stored_subject](../../observer_a_stored_subject/README.md): a second Observer, a **JSON log**, that
saves every temperature reading to `temperature_log.json`.

## What was added

- `src/JsonLogObserver.ts` - the JSON log. `JsonLogObserver` implements `Observer`. Like `CategoryObserver`, its constructor stores the sensor and attaches itself. In `update()` it asks `this.sensor.getTemperature()`, adds a reading, and saves the whole log.
`main.ts` makes one, next to the `CategoryObserver`: `new JsonLogObserver(sensor);`
- `tests/JsonLog.test.ts` - tests for it. Each test saves to a temporary file.

Everything else is the same as the exercise project.

## Running it

Writing a file needs permission, so in a terminal, in this folder:

```bash
deno run --allow-write=temperature_log.json src/main.ts
```

Type a temperature and press **Enter**: the category Observer prints its message, and the JSON log saves the reading.
Press **Enter** on its own to stop, then look at `temperature_log.json`:

```json
[
  {
    "reading": 1,
    "celsius": 21
  },
  {
    "reading": 2,
    "celsius": 27.5
  }
]
```

Without `--allow-write`, Deno stops and asks for permission the first time the log is saved.

## Running the tests

The JSON log tests write (and read back) temporary files, so they need permission too:

```bash
deno test --allow-read --allow-write
```

## What to look at

- `src/JsonLogObserver.ts` - the solution
- `src/main.ts` - look for the `SOLUTION` comments
- `class_diagram.story` - slides: the UML class diagram, including the JSON log, then one slide per class
- `uml_revision.story` - slides: a reference to the UML notation in the class diagram (classes, visibility, interfaces, inheritance, association, dependency, ...)

Notes and diagrams for this approach: [2_ObserverStoredSubject.md](../../../2_ObserverStoredSubject.md)
