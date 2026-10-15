// The concrete Subject: a temperature sensor. It calls notify() whenever its temperature changes.

import { Subject } from "./Subject.ts";

export class TemperatureSensor extends Subject {
  private celsius: number = 20;

  /** The current temperature, in °C. */
  public override getTemperature(): number {
    return this.celsius;
  }

  /** Changes the temperature, then tells every attached Observer. */
  public setTemperature(celsius: number): void {
    this.celsius = celsius;
    this.notify();
  }
}
