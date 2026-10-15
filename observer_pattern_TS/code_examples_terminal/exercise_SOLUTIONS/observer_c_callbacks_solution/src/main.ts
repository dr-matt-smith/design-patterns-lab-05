// The entry point: makes the Subject (a temperature sensor), attaches two listener functions, then reads
// temperatures from the keyboard.
//
// Run it with:  deno run --allow-write=temperature_log.json src/main.ts

import { JsonLog } from "./JsonLog.ts";
import { categorise } from "./TemperatureCategory.ts";
import { TemperatureSensor } from "./TemperatureSensor.ts";

const sensor = new TemperatureSensor();

// Approach C: the Observer is just a function - it is given the new temperature.
sensor.attach((celsius) => console.log(`${celsius}°C is ${categorise(celsius)}`));

// SOLUTION: Observer 2 - an arrow function that calls the JSON log's record() method.
// (Not sensor.attach(jsonLog.record): record() would lose `this`.)
const jsonLog = new JsonLog();
sensor.attach((celsius) => jsonLog.record(celsius));

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
