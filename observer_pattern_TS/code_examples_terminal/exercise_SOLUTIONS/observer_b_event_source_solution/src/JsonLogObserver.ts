// SOLUTION - Observer 2: keeps a log of every temperature reading, and saves it to temperature_log.json.
// Approach B: no stored sensor - update() is given the Subject that changed.

import type { Observer } from "./Observer.ts";
import type { Subject } from "./Subject.ts";

/** Where the log is saved. Writing it needs: deno run --allow-write=temperature_log.json */
export const LOG_FILE = "temperature_log.json";

/** One entry in the log. */
export interface Reading {
  reading: number;
  celsius: number;
}

export class JsonLogObserver implements Observer {
  private readonly readings: Reading[] = [];

  /** @param file where to save the log (the tests use a temporary file) */
  constructor(private readonly file: string = LOG_FILE) {}

  public update(subject: Subject): void {
    const celsius = subject.getTemperature(); // the parameter says which Subject changed
    this.readings.push({ reading: this.readings.length + 1, celsius });
    Deno.writeTextFileSync(this.file, this.toJson()); // save the whole log, every time
  }

  /** The whole log, as JSON. */
  public toJson(): string {
    return JSON.stringify(this.readings, null, 2);
  }
}
