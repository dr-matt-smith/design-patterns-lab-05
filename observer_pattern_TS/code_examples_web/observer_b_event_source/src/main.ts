// The entry point: makes the Subject (a temperature sensor) and its two Observers, and adds a button
// for each temperature. main.ts is the only file that talks to the page (the DOM).

import { CategoryObserver } from "./CategoryObserver.ts";
import { JsonLogObserver } from "./JsonLogObserver.ts";
import type { TemperatureCategory } from "./TemperatureCategory.ts";
import { TemperatureSensor } from "./TemperatureSensor.ts";

const LOWEST = -1; // °C
const HIGHEST = 30; // °C

const jsonOutput = document.querySelector<HTMLPreElement>("#json-log");
const categoryOutput = document.querySelector<HTMLElement>("#category");
const buttons = document.querySelector<HTMLElement>("#buttons");

// querySelector gives null if index.html has no matching element - so stop here, with a clear message.
if (jsonOutput === null || categoryOutput === null || buttons === null) {
  throw new Error("index.html needs elements with the ids json-log, category and buttons");
}

/** Puts Observer 1's output (the JSON log) on the page, scrolled to the newest reading. */
const showJson = (json: string): void => {
  jsonOutput.textContent = json;
  jsonOutput.scrollTop = jsonOutput.scrollHeight;
};

/** Puts Observer 2's output (the category word) on the page, coloured to match. */
const showCategory = (category: TemperatureCategory): void => {
  categoryOutput.textContent = category;
  categoryOutput.className = `category ${category.toLowerCase()}`;
};

const sensor = new TemperatureSensor();

// Approach B: the Observers don't know about the sensor - it is passed to them in every update().
sensor.attach(new JsonLogObserver(showJson));
sensor.attach(new CategoryObserver(showCategory));

// One button per temperature. A button only changes the Subject - the Observers update the page themselves.
buttons.replaceChildren();
for (let celsius = LOWEST; celsius <= HIGHEST; celsius++) {
  const button = document.createElement("button");
  button.textContent = `${celsius}°C`;
  button.addEventListener("click", () => sensor.setTemperature(celsius));
  buttons.append(button);
}
