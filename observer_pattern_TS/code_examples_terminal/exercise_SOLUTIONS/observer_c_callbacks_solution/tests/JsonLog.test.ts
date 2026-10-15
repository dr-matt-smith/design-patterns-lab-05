// Tests for the exercise solution: the JSON log. It writes a file, so these tests need permission:
//   deno test --allow-read --allow-write
// Each test saves to a new temporary file, so temperature_log.json is never touched.

import { assertEquals, assertThrows } from "@std/assert";
import { JsonLog } from "../src/JsonLog.ts";
import { TemperatureSensor } from "../src/TemperatureSensor.ts";

Deno.test("the JSON log saves every reading, in order", () => {
  const file = Deno.makeTempFileSync({ suffix: ".json" });
  const sensor = new TemperatureSensor();
  const jsonLog = new JsonLog(file);
  sensor.attach((celsius) => jsonLog.record(celsius));
  sensor.setTemperature(21);
  sensor.setTemperature(27.5);
  assertEquals(JSON.parse(Deno.readTextFileSync(file)), [{ reading: 1, celsius: 21 }, { reading: 2, celsius: 27.5 }]);
  Deno.removeSync(file);
});

Deno.test("attaching record directly loses `this`", () => {
  const sensor = new TemperatureSensor();
  const jsonLog = new JsonLog(Deno.makeTempFileSync({ suffix: ".json" }));
  sensor.attach(jsonLog.record); // WRONG: record() is called on its own, so `this` is undefined
  assertThrows(() => sensor.setTemperature(21), TypeError);
});
