// Tests for the exercise solution: the JSON log. It writes a file, so these tests need permission:
//   deno test --allow-read --allow-write
// Each test saves to a new temporary file, so temperature_log.json is never touched.

import { assertEquals } from "@std/assert";
import { JsonLogObserver } from "../src/JsonLogObserver.ts";
import { TemperatureSensor } from "../src/TemperatureSensor.ts";

Deno.test("the JSON log saves every reading, in order", () => {
  const file = Deno.makeTempFileSync({ suffix: ".json" });
  const sensor = new TemperatureSensor();
  sensor.attach(new JsonLogObserver(file));
  sensor.setTemperature(21);
  sensor.setTemperature(27.5);
  assertEquals(JSON.parse(Deno.readTextFileSync(file)), [{ reading: 1, celsius: 21 }, { reading: 2, celsius: 27.5 }]);
  Deno.removeSync(file);
});

Deno.test("one JSON log can record two Subjects", () => {
  const file = Deno.makeTempFileSync({ suffix: ".json" });
  const indoor = new TemperatureSensor();
  const outdoor = new TemperatureSensor();
  const jsonLog = new JsonLogObserver(file);
  indoor.attach(jsonLog);
  outdoor.attach(jsonLog);
  outdoor.setTemperature(3);
  indoor.setTemperature(21);
  assertEquals(JSON.parse(Deno.readTextFileSync(file)), [{ reading: 1, celsius: 3 }, { reading: 2, celsius: 21 }]);
  Deno.removeSync(file);
});
