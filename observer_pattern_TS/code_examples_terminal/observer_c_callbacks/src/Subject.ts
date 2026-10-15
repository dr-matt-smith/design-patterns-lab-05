// The Subject: keeps a list of listener FUNCTIONS, and calls each one when it changes.
// Approach C: there is no Observer interface - any function with the right signature can observe.

/** The type of function that can observe a temperature Subject: it is given the new temperature. */
export type TemperatureListener = (celsius: number) => void;

export abstract class Subject {
  private listeners: TemperatureListener[] = [];

  /** Starts calling `listener` on every change. Returns a function that detaches it again. */
  public attach(listener: TemperatureListener): () => void {
    this.listeners.push(listener);
    return () => this.detach(listener); // hand back an "unsubscribe" function
  }

  /** Stops calling `listener` - it must be the very same function that was attached. */
  public detach(listener: TemperatureListener): void {
    this.listeners = this.listeners.filter((l) => l !== listener);
  }

  /** Calls every attached listener with the new temperature. A concrete Subject calls this when it changes. */
  public notify(): void {
    for (const listener of this.listeners) {
      listener(this.getTemperature()); // push the new state to each function
    }
  }

  /** The state that is pushed to the listeners. */
  public abstract getTemperature(): number;
}
