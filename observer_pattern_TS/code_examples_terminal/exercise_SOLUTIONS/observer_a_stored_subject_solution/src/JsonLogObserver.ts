// SOLUTION - Observer 2: keeps a log of every temperature reading, and saves it to temperature_log.json.
// Approach A: like CategoryObserver, it stores a reference to the sensor it observes, attaches itself, and asks
// the sensor for the temperature in update().

import type { Observer } from "./Observer.ts";
import type { TemperatureSensor } from "./TemperatureSensor.ts";

/** Where the log is saved. Writing it needs: deno run --allow-write=temperature_log.json */
export const LOG_FILE = "temperature_log.json";

/** One entry in the log. */
export interface Reading {
  reading: number;
  celsius: number;
}

export class JsonLogObserver implements Observer {
  private readonly readings: Reading[] = [];

  /**
   * @param sensor the Subject to observe - stored, so update() can ask it for the temperature
   * @param file   where to save the log (the tests use a temporary file)
   */
  constructor(private readonly sensor: TemperatureSensor, private readonly file: string = LOG_FILE) {
    sensor.attach(this);
  }

  public update(): void {
    const celsius = this.sensor.getTemperature(); // pull the new state from the stored Subject
    this.readings.push({ reading: this.readings.length + 1, celsius });
    Deno.writeTextFileSync(this.file, this.toJson()); // save the whole log, every time
  }

  /** The whole log, as JSON. */
  public toJson(): string {
    return JSON.stringify(this.readings, null, 2);
  }
}
