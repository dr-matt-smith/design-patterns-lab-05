// The entry point: makes the Subject (a temperature sensor) and its two Observers, then reads temperatures
// from the keyboard.
//
// Run it with:  deno run --allow-write=temperature_log.json src/main.ts

import { CategoryObserver } from "./CategoryObserver.ts";
import { JsonLogObserver } from "./JsonLogObserver.ts";
import { TemperatureSensor } from "./TemperatureSensor.ts";

const sensor = new TemperatureSensor();

// Approach A: each Observer is given the sensor, stores it, and attaches itself in its constructor.
new CategoryObserver(sensor);
new JsonLogObserver(sensor); // SOLUTION: Observer 2, the JSON log

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
