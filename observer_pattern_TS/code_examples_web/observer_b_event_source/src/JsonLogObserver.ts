// Observer 1: keeps a log of every temperature reading, and shows the whole log as JSON.
// Approach B: no stored sensor - update() is given the Subject that changed.

import type { Observer } from "./Observer.ts";
import type { Subject } from "./Subject.ts";

/** One entry in the log. */
export interface Reading {
  reading: number;
  celsius: number;
}

export class JsonLogObserver implements Observer {
  private readonly readings: Reading[] = [];

  /** @param show what to do with the JSON (main.ts puts it on the page; a test can just keep it) */
  constructor(private readonly show: (json: string) => void) {}

  public update(subject: Subject): void {
    const celsius = subject.getTemperature(); // the parameter says which Subject changed
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
