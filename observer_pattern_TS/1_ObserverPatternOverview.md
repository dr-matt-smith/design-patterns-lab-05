<style>
  .figures img { background: #ffffff; display: block; max-width: 100%; }
</style>

<div class="figures">

# Observer Pattern - three ways to connect Observers to a Subject (TypeScript)

When a Subject's state changes, it sends an `update()` message to each of its Observers. Each Observer then usually needs to get the new state **from** the Subject. There are two common ways for the Observer to get hold of the Subject (Approaches A and B). TypeScript also offers a third, more modern option (Approach C): drop the Observer objects altogether and attach plain functions.

| | Approach A - stored Subject reference | Approach B - Subject passed as event source | Approach C - callback functions |
|---|---|---|---|
| How the Observer reaches the Subject | keeps its own `subject` field | the Subject passes itself: `o.update(this)` | doesn't need to - the new state is passed in: `fn(state)` |
| `update` signature | `update(): void` | `update(subject: Subject): void` | no `update()` - the function itself is called: `(state: number) => void` |
| Observing several Subjects | hard - `update()` doesn't say which one changed | easy - the parameter says which one | easy - attach a different function to each Subject |
| Type safety | field can be the concrete `Subject1` - no type assertion | parameter is the abstract `Subject` - needs an abstract `getState()`, or narrowing with `instanceof` | the `Listener` type checks the argument - no assertions |
| Coupling | Observer is tied to one Subject when it is created | more flexible | loosest - *any* function can observe, no interface to implement |
| Attach / detach | natural - it already has the reference | needs a reference from somewhere | `attach()` returns an unsubscribe function |
| Where you'll see it | the original Gang of Four (GoF) book | the browser DOM: `addEventListener()` handlers receive an event whose `currentTarget` is the source | Redux `store.subscribe()`, RxJS `subscribe()`, Node.js `emitter.on()` |

Details and sample code:
- [Approach A - each Observer stores a reference to its Subject](2_ObserverStoredSubject.md)
- [Approach B - the Subject passes itself as the event source](3_ObserverEventSource.md)
- [Approach C - Observers as callback functions](4_ObserverCallbacks.md)

<hr>

## They are often combined

Even when the Subject is passed as a parameter, an Observer will often keep a reference anyway - it needs one to call `subject.attach(this)` (typically in its constructor) and `subject.detach(this)` later.

## Push vs pull

- Approaches A and B are both **pull** models - the Observer asks the Subject for the new state (`getState()`)
- In the **push** model the Subject sends the data itself, e.g. `update(newState)`, or an *event object* holding both the source and the new data
- Pull keeps the `update()` interface simple; push saves the Observer a call back, but the Subject has to guess what data every Observer needs
- Approach C is a **push** model - each listener function is handed the new state
- Much TypeScript / JavaScript code uses push: Node.js `EventEmitter` listeners and RxJS `subscribe()` callbacks are handed the data directly

## Suggested teaching order

1. Approach A - the GoF structure
2. Ask: *"what if one Observer watches two Subjects?"* - this motivates Approach B
3. Event objects - how real frameworks (e.g. the DOM's `Event`) generalise Approach B into the push model
4. Finish with Approach C - an interface with a single `update()` method is really just a function type, so modern TypeScript often attaches plain functions instead

<hr>

## Notes on TypeScript

- **Type assertions are not casts** - `subject as Subject1` only tells the compiler to trust you; nothing is checked at runtime. Prefer narrowing with `instanceof`:

```
public update(subject: Subject): void {
    if (subject instanceof Subject1)
        this.state = subject.getState();   // compiler now knows subject is a Subject1
}
```

- **`notify()` is fine** - unlike Java (where `Object.notify()` is `final`), TypeScript has no built-in `notify()`, so the GoF name can be used as-is
- **structural typing** - any object with an `update(): void` method counts as an `Observer`, whether or not its class says `implements Observer`

<hr>

## Code examples

Every approach has two runnable examples. Both use a temperature sensor (the Subject). The **web** version has two Observers - a JSON log, and a HOT / WARM / COOL / COLD display - plus a button for each temperature from -1°C to 30°C. The **terminal** version has just the category Observer, and reads temperatures from the keyboard - adding the JSON log Observer is an exercise in its README.

**Terminal** versions (simple - run `src/main.ts` with Deno):

- [Approach A - stored Subject reference](code_examples_terminal/observer_a_stored_subject/README.md)
- [Approach B - Subject passed as event source](code_examples_terminal/observer_b_event_source/README.md)
- [Approach C - callback functions](code_examples_terminal/observer_c_callbacks/README.md)

**Web** versions (Celbridge / Deno browser projects):

- [Approach A - stored Subject reference](code_examples_web/observer_a_stored_subject/README.md)
- [Approach B - Subject passed as event source](code_examples_web/observer_b_event_source/README.md)
- [Approach C - callback functions](code_examples_web/observer_c_callbacks/README.md)

<hr>

## Java version

For reference, the Observer pattern overview with Java code: [java_version/ObserverPatternOverview_java_code.md](java_version/ObserverPatternOverview_java_code.md)


</div>
