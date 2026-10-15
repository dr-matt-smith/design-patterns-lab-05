// Tests for the exercise solution: the JSON log. It writes a file, so these tests need permission:
//   deno test --allow-read --allow-write
// Each test saves to a new temporary file, so temperature_log.json is never touched.

import { assertEquals } from "@std/assert";
import { JsonLogObserver } from "../src/JsonLogObserver.ts";
import { TemperatureSensor } from "../src/TemperatureSensor.ts";

Deno.test("the JSON log saves every reading, in order", () => {
  const file = Deno.makeTempFileSync({ suffix: ".json" });
  const sensor = new TemperatureSensor();
  new JsonLogObserver(sensor, file); // attaches itself
  sensor.setTemperature(21);
  sensor.setTemperature(27.5);
  assertEquals(JSON.parse(Deno.readTextFileSync(file)), [{ reading: 1, celsius: 21 }, { reading: 2, celsius: 27.5 }]);
  Deno.removeSync(file);
});

Deno.test("a detached JSON log stops saving", () => {
  const file = Deno.makeTempFileSync({ suffix: ".json" });
  const sensor = new TemperatureSensor();
  const jsonLog = new JsonLogObserver(sensor, file);
  sensor.setTemperature(21);
  sensor.detach(jsonLog);
  sensor.setTemperature(22);
  assertEquals(jsonLog.toJson(), Deno.readTextFileSync(file));
  assertEquals(JSON.parse(jsonLog.toJson()).length, 1);
  Deno.removeSync(file);
});
