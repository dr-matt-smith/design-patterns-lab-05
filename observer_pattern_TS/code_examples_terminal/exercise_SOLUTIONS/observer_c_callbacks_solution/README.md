# Observer Pattern - Approach C: Callback Functions (terminal version) - EXERCISE SOLUTION

The solution to the exercise in [../../observer_c_callbacks](../../observer_c_callbacks/README.md): a second Observer, a **JSON log**, that
saves every temperature reading to `temperature_log.json`.

## What was added

- `src/JsonLog.ts` - the JSON log. `JsonLog` is an ordinary class - it implements nothing. Its `record(celsius)` method adds a reading and saves the whole log.
`main.ts` makes one and attaches an arrow function that calls it: `sensor.attach((celsius) => jsonLog.record(celsius));`
(`sensor.attach(jsonLog.record)` would not work: `record()` would lose `this`. A test shows this.)
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

- `src/JsonLog.ts` - the solution
- `src/main.ts` - look for the `SOLUTION` comments
- `class_diagram.story` - slides: the UML class diagram, including the JSON log, then one slide per class
- `uml_revision.story` - slides: a reference to the UML notation in the class diagram (classes, visibility, interfaces, inheritance, association, dependency, ...)

Notes and diagrams for this approach: [4_ObserverCallbacks.md](../../../4_ObserverCallbacks.md)
