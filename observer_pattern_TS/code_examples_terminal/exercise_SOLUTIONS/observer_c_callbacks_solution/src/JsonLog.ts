// SOLUTION - Observer 2's logic: keeps a log of every temperature reading, and saves it to temperature_log.json.
// Approach C: an ordinary class - it does not implement any Observer interface. main.ts attaches an arrow
// function that calls record().

/** Where the log is saved. Writing it needs: deno run --allow-write=temperature_log.json */
export const LOG_FILE = "temperature_log.json";

/** One entry in the log. */
export interface Reading {
  reading: number;
  celsius: number;
}

export class JsonLog {
  private readonly readings: Reading[] = [];

  /** @param file where to save the log (the tests use a temporary file) */
  constructor(private readonly file: string = LOG_FILE) {}

  /** Adds a reading to the log, then saves the whole log. */
  public record(celsius: number): void {
    this.readings.push({ reading: this.readings.length + 1, celsius });
    Deno.writeTextFileSync(this.file, this.toJson()); // save the whole log, every time
  }

  /** The whole log, as JSON. */
  public toJson(): string {
    return JSON.stringify(this.readings, null, 2);
  }
}
