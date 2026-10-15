// Tests for the Subject: does it call the right listener functions?

import { assertEquals } from "@std/assert";
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
