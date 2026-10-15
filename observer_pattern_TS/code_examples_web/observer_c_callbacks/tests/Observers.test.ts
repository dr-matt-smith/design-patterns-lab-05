// Tests for the Subject, its listener functions, and the JSON log. A `show` function that just keeps what it
// is given stands in for the page, so no browser is needed.

import { assertEquals, assertThrows } from "@std/assert";
import { JsonLog } from "../src/JsonLog.ts";
import { categorise, type TemperatureCategory } from "../src/TemperatureCategory.ts";
import { TemperatureSensor } from "../src/TemperatureSensor.ts";

Deno.test("every attached function is called with the new temperature", () => {
  const sensor = new TemperatureSensor();
  const first: number[] = [];
  const second: number[] = [];
  sensor.attach((celsius) => first.push(celsius));
  sensor.attach((celsius) => second.push(celsius));
  sensor.setTemperature(21);
  assertEquals(first, [21]);
  assertEquals(second, [21]);
});

Deno.test("the function returned by attach() unsubscribes", () => {
  const sensor = new TemperatureSensor();
  const seen: number[] = [];
  const unsubscribe = sensor.attach((celsius) => seen.push(celsius));
  sensor.setTemperature(21);
  unsubscribe();
  sensor.setTemperature(22);
  assertEquals(seen, [21]);
});

Deno.test("detach() needs the very same function - a copy of it is not detached", () => {
  const sensor = new TemperatureSensor();
  const seen: number[] = [];
  sensor.attach((celsius) => seen.push(celsius));
  sensor.detach((celsius) => seen.push(celsius)); // a NEW function, so nothing is detached
  sensor.setTemperature(21);
  assertEquals(seen, [21]);
});

Deno.test("the JSON log records every reading, in order", () => {
  const sensor = new TemperatureSensor();
  let shown = "";
  const jsonLog = new JsonLog((json) => shown = json);
  sensor.attach((celsius) => jsonLog.record(celsius));
  sensor.setTemperature(21);
  sensor.setTemperature(27);
  assertEquals(JSON.parse(shown), [{ reading: 1, celsius: 21 }, { reading: 2, celsius: 27 }]);
});

Deno.test("attaching a method directly loses `this`", () => {
  const sensor = new TemperatureSensor();
  const jsonLog = new JsonLog(() => {});
  sensor.attach(jsonLog.record); // WRONG: record() is called on its own, so `this` is undefined
  assertThrows(() => sensor.setTemperature(21), TypeError);
});

Deno.test("an arrow function can turn each temperature into a category", () => {
  const sensor = new TemperatureSensor();
  const shown: TemperatureCategory[] = [];
  sensor.attach((celsius) => shown.push(categorise(celsius)));
  sensor.setTemperature(30);
  sensor.setTemperature(-1);
  assertEquals(shown, ["HOT", "COLD"]);
});
