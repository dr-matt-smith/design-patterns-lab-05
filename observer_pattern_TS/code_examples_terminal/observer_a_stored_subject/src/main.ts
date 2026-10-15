// The entry point: makes the Subject (a temperature sensor) and its Observer, then reads temperatures
// from the keyboard.
//
// Run it with:  deno run src/main.ts

import { CategoryObserver } from "./CategoryObserver.ts";
import { TemperatureSensor } from "./TemperatureSensor.ts";

const sensor = new TemperatureSensor();

// Approach A: the Observer is given the sensor, stores it, and attaches itself in its constructor.
new CategoryObserver(sensor);

// Each temperature you type changes the Subject - the Observer prints its own message.
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
