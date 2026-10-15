<style>
  .figures img { background: #ffffff; display: block; max-width: 100%; }
</style>

<div class="figures">

# Observer Pattern - two ways for an Observer to reach its Subject

When a Subject's state changes, it sends an `update()` message to each of its Observers. Each Observer then usually needs to get the new state **from** the Subject. There are two common ways for the Observer to get hold of the Subject:

| | Approach A - stored Subject reference | Approach B - Subject passed as event source |
|---|---|---|
| How the Observer reaches the Subject | keeps its own `subject` field | the Subject passes itself: `o.update(this)` |
| `update` signature | `update()` | `update(Subject subject)` |
| Observing several Subjects | hard - `update()` doesn't say which one changed | easy - the parameter says which one |
| Type safety | field can be the concrete `Subject1` - no cast | parameter is the abstract `Subject` - needs an abstract `getState()`, or a cast |
| Coupling | Observer is tied to one Subject when it is created | more flexible |
| Attach / detach | natural - it already has the reference | needs a reference from somewhere |
| Where you'll see it | the original Gang of Four (GoF) book | most real libraries: Java Swing & JavaBeans listeners, C# events |

Details and sample code:
- [Approach A - each Observer stores a reference to its Subject](ObserverStoredSubject_java_code.md)
- [Approach B - the Subject passes itself as the event source](ObserverEventSource_java_code.md)

<hr>

## They are often combined

Even when the Subject is passed as a parameter, an Observer will often keep a reference anyway - it needs one to call `subject.attach(this)` (typically in its constructor) and `subject.detach(this)` later.

## Push vs pull

- Approaches A and B are both **pull** models - the Observer asks the Subject for the new state (`getState()`)
- In the **push** model the Subject sends the data itself, e.g. `update(newState)`, or an *event object* holding both the source and the new data (see the end of [Approach B](ObserverEventSource_java_code.md))
- Pull keeps the `update()` interface simple; push saves the Observer a call back, but the Subject has to guess what data every Observer needs

## Suggested teaching order

1. Approach A - the GoF structure
2. Ask: *"what if one Observer watches two Subjects?"* - this motivates Approach B
3. Finish with event objects - how real frameworks generalise Approach B into the push model

<hr>

## A note on Java: the name `notify()`

The GoF book (and our diagrams) name the broadcast method `notify()`. In real Java code this **won't compile** - `Object.notify()` is `final` (it is used for thread synchronisation), so no class can declare its own `notify()`. Use a name such as `notifyObservers()` instead.

<hr>

## Code examples

Every approach has a runnable example (a Java program (JDK only) that serves the page). They all use the same situation: a temperature sensor (the Subject) with two Observers - a JSON log, and a HOT / WARM / COOL / COLD display - plus a button for each temperature from -1°C to 30°C.

- [Approach A - stored Subject reference](code_examples/observer_a_stored_subject/README.md)
- [Approach B - Subject passed as event source](code_examples/observer_b_event_source/README.md)

<hr>

## TypeScript version

This is the Java reference version. The main version, with TypeScript code, is [1_ObserverPatternOverview.md](../1_ObserverPatternOverview.md)


</div>
