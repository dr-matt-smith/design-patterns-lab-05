// The entry point: makes the Subject (a temperature sensor), attaches a listener function, then reads
// temperatures from the keyboard.
//
// Run it with:  deno run src/main.ts

import { categorise } from "./TemperatureCategory.ts";
import { TemperatureSensor } from "./TemperatureSensor.ts";

const sensor = new TemperatureSensor();

// Approach C: the Observer is just a function - it is given the new temperature.
sensor.attach((celsius) => console.log(`${celsius}°C is ${categorise(celsius)}`));

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
