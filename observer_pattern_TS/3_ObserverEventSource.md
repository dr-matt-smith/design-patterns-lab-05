<style>
  .figures img { background: #ffffff; display: block; max-width: 100%; }
</style>

<div class="figures">

# Observer Pattern - Approach B: the Subject passes itself as the event source (TypeScript)

In this approach the Subject passes a reference to **itself** with every update message - `o.update(this)`.

- Observers do **not** need to store a reference to a Subject
- one Observer can observe **several** Subjects, and still tell which one changed
- this is the style used by the browser DOM: an event handler receives an `Event` whose `currentTarget` is the object that sent it

The UML is the same as for the Java version.

<hr>

## Class diagram

<img src="images/observer_event_source_class.svg" alt="Class diagram: update(s: Subject) receives the Subject as a parameter; Subject declares an abstract getState()">

Things to notice, compared with [Approach A](2_ObserverStoredSubject.md):
- `update(s: Subject)` now has a parameter
- there is **no** association from the Observers back to a Subject
- the abstract Subject declares an abstract `getState()`, so an Observer can call `s.getState()` on any Subject

## Sequence of messages - one Observer, two Subjects

<img src="images/observer_event_source_sequence.svg" alt="Sequence diagram: Observer1 observes Subject1 and Subject2, receiving update(s1) and update(s2)">

<hr>

## Sample code

```
// Subject - broadcast notify(this) messages to all Observers
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
            o.update(this);         // pass a reference to myself
    }

    public abstract getState(): number; // so Observers can call getState() on ANY Subject
}
```

```
// (Concrete) Subject1 - Subject2 is written the same way
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
// Observer - update() receives the Subject that changed
interface Observer {
    update(subject: Subject): void;
}
```

```
// (Concrete) Observer1 - can observe more than one Subject
class Observer1 implements Observer {
    private state1: number = 0;
    private state2: number = 0;

    public update(subject: Subject): void {
        // the parameter tells us WHICH Subject changed
        if (subject instanceof Subject1)
            this.state1 = subject.getState();
        else if (subject instanceof Subject2)
            this.state2 = subject.getState();
    }
}
```

```
// Client
const s1 = new Subject1();
const s2 = new Subject2();
const o1 = new Observer1();

s1.attach(o1);
s2.attach(o1);    // one Observer, two Subjects

s1.setState(10);  // o1 receives update(s1)
s2.setState(99);  // o1 receives update(s2)
```

<hr>

## What if the abstract Subject has no getState()?

Then the parameter type `Subject` does not have a `getState()` method. In TypeScript there are two ways to reach `Subject1`'s `getState()`:

```
// (Concrete) Observer1 - without an abstract getState() in Subject

// 1. type assertion - NOT checked at runtime
public update(subject: Subject): void {
    const s1 = subject as Subject1;   // "trust me, compiler"
    this.state = s1.getState();       // crashes at runtime if subject isn't really a Subject1
}

// 2. narrowing with instanceof - checked at runtime (preferred)
public update(subject: Subject): void {
    if (subject instanceof Subject1)
        this.state = subject.getState();   // compiler now knows subject is a Subject1
}
```

Unlike a Java cast, `as` generates **no** runtime check - it only tells the compiler to stop complaining. `instanceof` is a real check, and TypeScript *narrows* the type inside the `if`, so no assertion is needed.

<hr>

## Variation: an event object (push model)

Real frameworks usually wrap the source **and** the new data in an *event object*. The Observer then often doesn't need to call back at all - the data is **pushed** to it.

In TypeScript the event object is usually just an **interface** describing a plain object, rather than a class with getters:

```
// Event object - carries the source AND the new data
interface StateChangeEvent {
    source: Subject;
    newState: number;
}
```

```
// Observer - update() now receives an event object
interface Observer {
    update(e: StateChangeEvent): void;
}
```

```
// Subject - notify() now sends an event object
public notify(): void {
    for (const o of this.observers)
        o.update({ source: this, newState: this.getState() });
}
```

```
// (Concrete) Observer1 - the new state arrives inside the event
class Observer1 implements Observer {
    private state: number = 0;

    public update(e: StateChangeEvent): void {
        this.state = e.newState;    // no call back to the Subject needed
        // ... e.source is still available if we need to know who sent it
    }
}
```

Real-world examples of this style:
- Browser DOM: `button.addEventListener("click", (e) => ...)` - `e.currentTarget` is the source
- Node.js: `EventEmitter` - `emitter.on("data", (data) => ...)` pushes the data (without the source)
- RxJS: `subject.subscribe(value => ...)` pushes each new value

<hr>

## Strengths
- one Observer can observe many Subjects, and knows which one sent each update
- Observers don't need a stored Subject reference just to receive updates

## Weaknesses
- the parameter has the **abstract** type `Subject`, so either the abstract Subject must declare `getState()`, or the Observer must narrow with `instanceof` (or use an unchecked `as` assertion)
- the Observer still needs a reference from *somewhere* if it wants to `attach()` / `detach()` itself

For a lighter-weight alternative with no Observer interface at all, see [Approach C - Observers as callback functions](4_ObserverCallbacks.md).

<hr>

## Code example

Runnable versions of this approach:

- **terminal** (simple - one Observer): [code_examples_terminal/observer_b_event_source](code_examples_terminal/observer_b_event_source/README.md)
- **web** (a Celbridge / Deno browser project): [code_examples_web/observer_b_event_source](code_examples_web/observer_b_event_source/README.md)

Both use a temperature sensor (the Subject). The **web** version has two Observers - a JSON log, and a HOT / WARM / COOL / COLD display - plus a button for each temperature from -1°C to 30°C. The **terminal** version has just the category Observer, and reads temperatures from the keyboard - adding the JSON log Observer is an exercise in its README.

<hr>

## Java version

For reference, Approach B with Java code: [java_version/ObserverEventSource_java_code.md](java_version/ObserverEventSource_java_code.md)


</div>
