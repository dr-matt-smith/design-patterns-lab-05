// The Subject: keeps a list of Observers, and sends each one an update() message when it changes.
// It knows nothing about temperatures - TemperatureSensor (a concrete Subject) adds those.

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

  /** Sends update() to every attached Observer. A concrete Subject calls this when its state changes. */
  public notify(): void {
    for (const observer of this.observers) {
      observer.update();
    }
  }
}
