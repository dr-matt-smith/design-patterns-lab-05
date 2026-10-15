// Observer 1: keeps a log of every temperature reading, and shows the whole log as JSON.
// Approach A: it stores a reference to the sensor it observes, and asks it for the temperature in update().

import type { Observer } from "./Observer.ts";
import type { TemperatureSensor } from "./TemperatureSensor.ts";

/** One entry in the log. */
export interface Reading {
  reading: number;
  celsius: number;
}

export class JsonLogObserver implements Observer {
  private readonly readings: Reading[] = [];

  /**
   * @param sensor the Subject to observe - stored, so update() can ask it for the temperature
   * @param show   what to do with the JSON (main.ts puts it on the page; a test can just keep it)
   */
  constructor(private readonly sensor: TemperatureSensor, private readonly show: (json: string) => void) {
    sensor.attach(this);
  }

  public update(): void {
    const celsius = this.sensor.getTemperature(); // pull the new state from the stored Subject
    this.readings.push({ reading: this.readings.length + 1, celsius });
    this.show(this.toJson());
  }

  /** The whole log, as JSON - one reading per line. */
  public toJson(): string {
    if (this.readings.length === 0) {
      return "[]";
    }
    const lines = this.readings.map((reading) => "  " + JSON.stringify(reading));
    return `[\n${lines.join(",\n")}\n]`;
  }
}
