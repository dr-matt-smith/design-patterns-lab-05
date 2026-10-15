// The entry point: makes the Subject (a temperature sensor) and its two Observers, then reads temperatures
// from the keyboard.
//
// Run it with:  deno run --allow-write=temperature_log.json src/main.ts

import { CategoryObserver } from "./CategoryObserver.ts";
import { JsonLogObserver } from "./JsonLogObserver.ts";
import { TemperatureSensor } from "./TemperatureSensor.ts";

const sensor = new TemperatureSensor();

// Approach B: the Observers don't know about the sensor - it is passed to them in every update().
sensor.attach(new CategoryObserver());
sensor.attach(new JsonLogObserver()); // SOLUTION: Observer 2, the JSON log

console.log("Every reading is also saved to temperature_log.json");

// Each temperature you type changes the Subject - the Observers do the rest.
let input = prompt("Temperature in °C (or just press Enter to stop):");
while (input !== null && input.trim() !== "") {
  const celsius = Number(input);
  if (Number.isNaN(celsius)) {
    console.log(`"${input}" is not a number`);
  } else {
    sensor.setTemperature(celsius);
  }
  input = prompt("Temperature in °C (or just press Enter to stop):");
}
