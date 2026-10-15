# Observer Pattern - Approach B: Event Source (Java)

Approach B: the sensor passes itself to update(subject), so the Observers don't need to store a reference to it.

This is the Java version of the TypeScript example in
[code_examples_web/observer_b_event_source](../../../code_examples_web/observer_b_event_source/README.md) - same classes, same page.

A temperature sensor (the **Subject**) has two **Observers**:

1. a **JSON log** - records every reading, and shows the whole log as JSON
2. a **category display** - shows HOT (above 25°C), WARM (20-25°C), COOL (15-19°C) or COLD (below 15°C)

Click a temperature button: the page sends the temperature to the Java program, which changes the sensor's
temperature. The sensor then notifies its Observers, and the page shows what each one output.

In this approach `notifyObservers()` calls `observer.update(this)` - the Subject passes **itself** as the event
source. The Observers have no `sensor` field: they call `subject.getTemperature()` on the Subject they are given. That
works because the abstract `Subject` declares an abstract `getTemperature()`.

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

- `src/Subject.java` - the abstract **Subject**: `attach()`, `detach()`, `notifyObservers()` - and an abstract `getTemperature()`
- `src/Observer.java` - the **Observer** interface: `update(Subject subject)`
- `src/TemperatureSensor.java` - the concrete Subject: `getTemperature()` and `setTemperature()`
- `src/JsonLogObserver.java` and `src/CategoryObserver.java` - the two concrete Observers
- `src/TemperatureCategory.java` - turns a temperature into HOT, WARM, COOL or COLD
- `src/Main.java` - makes the sensor and its Observers, and runs the web server
- `public/` - the web page: `app.js` makes the buttons and shows the Observers' output
- `test/ObserverTests.java` - the tests

The broadcast method is called `notifyObservers()`, not `notify()`: in Java, `Object.notify()` is `final`, so no
class can declare its own `notify()`.

Notes and diagrams for this approach: [ObserverEventSource_java_code.md](../../ObserverEventSource_java_code.md)
