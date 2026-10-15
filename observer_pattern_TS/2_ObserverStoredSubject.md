<style>
  .figures img { background: #ffffff; display: block; max-width: 100%; }
</style>

<div class="figures">

# Observer Pattern - Approach A: each Observer stores a reference to its Subject (TypeScript)

This is the structure from the original Gang of Four (GoF) book.

- the Subject keeps a list of its Observers
- each Observer keeps a reference to the **one** Subject it is observing
- when the Subject changes, it sends a plain `update()` message (no parameters)
- each Observer then uses its stored `subject` reference to ask for the new state (`subject.getState()`)

The UML is the same as for the Java version - TypeScript has abstract classes, interfaces and `private` members, so each class in the diagram maps directly to a TypeScript class or interface.

<hr>

## Class diagram

<img src="images/observer_stored_subject_class.svg" alt="Class diagram: each Observer holds a reference to Subject1 and update() takes no parameters">

Note the **two** directed associations:
- Subject -> Observers (`observers`, many `*`) - so the Subject can notify them
- Observers -> Subject1 (`subject`, exactly `1`) - so each Observer can call back to get the state

## Sequence of messages when the Subject's state changes

<img src="images/observer_stored_subject_sequence.svg" alt="Sequence diagram: setState triggers notify, each Observer receives update() and calls subject.getState()">

<hr>

## Sample code

```
// Subject - keeps the list of Observers, and broadcasts update() messages to them
abstract class Subject {
    private observers: Observer[] = [];

    public attach(o: Observer): void {
        this.observers.push(o);
    }

    public detach(o: Observer): void {
        this.observers = this.observers.filter(x => x !== o);
    }

    public notify(): void {
        for (const o of this.observers)
            o.update();
    }
}
```

```
// (Concrete) Subject1 - calls notify() whenever its state changes
class Subject1 extends Subject {
    private state: number = 0;

    public getState(): number {
        return this.state;
    }

    public setState(newState: number): void {
        this.state = newState;
        this.notify();
    }
}
```

```
// Observer - update() has NO parameters
interface Observer {
    update(): void;
}
```

```
// (Concrete) Observer1 - stores a reference to the Subject1 it is observing
class Observer1 implements Observer {
    private subject: Subject1;
    private state: number = 0;

    constructor(subject: Subject1) {
        this.subject = subject;
        subject.attach(this);       // register with the Subject
    }

    public update(): void {
        this.state = this.subject.getState(); // use the stored reference to pull the new state
    }
}
```

```
// Client
const s = new Subject1();
const o1 = new Observer1(s);
const o2 = new Observer2(s);

s.setState(42);   // o1 and o2 both receive update(), and each calls s.getState()
```

<hr>

## TypeScript notes (differences from the Java version)

- **`this.` is required** - inside a method, fields and methods must be accessed with `this.` (`this.observers`, `this.notify()`), unlike Java where it is optional
- **`notify()` is fine** - in Java `Object.notify()` is `final`, so the GoF name can't be used; TypeScript has no such method
- **parameter properties** - TypeScript can declare *and* assign a field in one step:

```
// (Concrete) Observer1 - same as above, using a parameter property
class Observer1 implements Observer {
    private state: number = 0;

    constructor(private subject: Subject1) {   // declares AND assigns this.subject
        subject.attach(this);
    }

    public update(): void {
        this.state = this.subject.getState();
    }
}
```

- **structural typing** - any object with an `update(): void` method *is* an `Observer`, even without `implements Observer`. Writing `implements` is still good practice: the compiler then checks the class really matches the interface
- **`private` is compile-time only** - it stops other TypeScript code using the field, but the field is still visible in the generated JavaScript. For true runtime privacy, use a `#` field, e.g. `#observers: Observer[] = [];`

<hr>

## Strengths
- simple `update()` interface
- the Observer's field can have the **concrete** type (`Subject1`), so `getState()` can be called without a type assertion
- the stored reference is also needed anyway to `attach()` / `detach()` the Observer

## Weaknesses
- each Observer is tied to **one** Subject, chosen when it is created
- if an Observer watched two Subjects, a plain `update()` would not say *which* one changed
  - see [Approach B - the Subject passes itself as the event source](3_ObserverEventSource.md)

<hr>

## Code example

Runnable versions of this approach:

- **terminal** (simple - one Observer): [code_examples_terminal/observer_a_stored_subject](code_examples_terminal/observer_a_stored_subject/README.md)
- **web** (a Celbridge / Deno browser project): [code_examples_web/observer_a_stored_subject](code_examples_web/observer_a_stored_subject/README.md)

Both use a temperature sensor (the Subject). The **web** version has two Observers - a JSON log, and a HOT / WARM / COOL / COLD display - plus a button for each temperature from -1°C to 30°C. The **terminal** version has just the category Observer, and reads temperatures from the keyboard - adding the JSON log Observer is an exercise in its README.

<hr>

## Java version

For reference, Approach A with Java code: [java_version/ObserverStoredSubject_java_code.md](java_version/ObserverStoredSubject_java_code.md)


</div>
