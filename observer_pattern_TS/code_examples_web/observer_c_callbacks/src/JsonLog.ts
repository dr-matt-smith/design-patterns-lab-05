// Observer 1's logic: keeps a log of every temperature reading, and shows the whole log as JSON.
// Approach C: an ordinary class - it does not implement any Observer interface. main.ts attaches an arrow
// function that calls record().

/** One entry in the log. */
export interface Reading {
  reading: number;
  celsius: number;
}

export class JsonLog {
  private readonly readings: Reading[] = [];

  /** @param show what to do with the JSON (main.ts puts it on the page; a test can just keep it) */
  constructor(private readonly show: (json: string) => void) {}

  /** Adds a reading to the log, then shows the whole log. */
  public record(celsius: number): void {
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
