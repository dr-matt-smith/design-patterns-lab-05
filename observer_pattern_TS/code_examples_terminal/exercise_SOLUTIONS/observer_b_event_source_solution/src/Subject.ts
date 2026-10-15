// The Subject: keeps a list of Observers, and sends each one an update(this) message when it changes.
// Approach B: it passes ITSELF to update(), so the Observers don't need to store a reference to it.

import type { Observer } from "./Observer.ts";

export abstract class Subject {
  private observers: Observer[] = [];

  /** Starts sending update() messages to `observer`. */
  public attach(observer: Observer): void {
    this.observers.push(observer);
  }

  /** Stops sending update() messages to `observer`. */
  public detach(observer: Observer): void {
    this.observers = this.observers.filter((o) => o !== observer);
  }

  /** Sends update(this) to every attached Observer. A concrete Subject calls this when its state changes. */
  public notify(): void {
    for (const observer of this.observers) {
      observer.update(this); // pass a reference to myself
    }
  }

  /** Declared here, so an Observer can call getTemperature() on ANY Subject it is given. */
  public abstract getTemperature(): number;
}
