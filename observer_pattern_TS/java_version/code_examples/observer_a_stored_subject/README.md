# Observer Pattern - Approach A: Stored Subject (Java)

Approach A: each Observer stores a reference to the sensor it observes, and asks it for the temperature in update().

This is the Java version of the TypeScript example in
[code_examples_web/observer_a_stored_subject](../../../code_examples_web/observer_a_stored_subject/README.md) - same classes, same page.

A temperature sensor (the **Subject**) has two **Observers**:

1. a **JSON log** - records every reading, and shows the whole log as JSON
2. a **category display** - shows HOT (above 25°C), WARM (20-25°C), COOL (15-19°C) or COLD (below 15°C)

Click a temperature button: the page sends the temperature to the Java program, which changes the sensor's
temperature. The sensor then notifies its Observers, and the page shows what each one output.

In this approach `update()` has **no parameters**. Each Observer is given the sensor when it is made, stores it in a
`sensor` field, attaches itself, and calls `sensor.getTemperature()` whenever it receives `update()`.

## Running it

You need Java 17 or later. From this folder (the one with this README in it):

```bash
javac -d out src/*.java
```

```bash
java -cp out Main
```

Then open <http://localhost:8080> in a browser. Press **Ctrl+C** to stop the program.

The web page (`public/`) is served by the JDK's own `com.sun.net.httpserver` - there are no libraries to download.

## Running the tests

```bash
javac -d out src/*.java test/*.java
```

```bash
java -cp out ObserverTests
```

## What to look at

- `src/Subject.java` - the abstract **Subject**: `attach()`, `detach()` and `notifyObservers()`
- `src/Observer.java` - the **Observer** interface: `update()`, with no parameters
- `src/TemperatureSensor.java` - the concrete Subject: `getTemperature()` and `setTemperature()`
- `src/JsonLogObserver.java` and `src/CategoryObserver.java` - the two concrete Observers
- `src/TemperatureCategory.java` - turns a temperature into HOT, WARM, COOL or COLD
- `src/Main.java` - makes the sensor and its Observers, and runs the web server
- `public/` - the web page: `app.js` makes the buttons and shows the Observers' output
- `test/ObserverTests.java` - the tests

The broadcast method is called `notifyObservers()`, not `notify()`: in Java, `Object.notify()` is `final`, so no
class can declare its own `notify()`.

Notes and diagrams for this approach: [ObserverStoredSubject_java_code.md](../../ObserverStoredSubject_java_code.md)
