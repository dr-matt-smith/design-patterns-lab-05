// Tests for the Subject and its two Observers. A `show` function that just keeps what it is given
// stands in for the page, so no browser is needed.

import { assertEquals } from "@std/assert";
import { CategoryObserver } from "../src/CategoryObserver.ts";
import { JsonLogObserver } from "../src/JsonLogObserver.ts";
import type { Observer } from "../src/Observer.ts";
import type { TemperatureCategory } from "../src/TemperatureCategory.ts";
import { TemperatureSensor } from "../src/TemperatureSensor.ts";

/** An Observer that just counts its update() messages. */
class CountingObserver implements Observer {
  public updates = 0;
  public update(): void {
    this.updates++;
  }
}

Deno.test("every attached Observer is sent update() when the temperature changes", () => {
  const sensor = new TemperatureSensor();
  const first = new CountingObserver();
  const second = new CountingObserver();
  sensor.attach(first);
  sensor.attach(second);
  sensor.setTemperature(21);
  assertEquals(first.updates, 1);
  assertEquals(second.updates, 1);
});

Deno.test("a detached Observer is not sent update()", () => {
  const sensor = new TemperatureSensor();
  const observer = new CountingObserver();
  sensor.attach(observer);
  sensor.detach(observer);
  sensor.setTemperature(21);
  assertEquals(observer.updates, 0);
});

Deno.test("the JSON log records every reading, in order", () => {
  const sensor = new TemperatureSensor();
  let shown = "";
  new JsonLogObserver(sensor, (json) => shown = json);
  sensor.setTemperature(21);
  sensor.setTemperature(27);
  assertEquals(JSON.parse(shown), [{ reading: 1, celsius: 21 }, { reading: 2, celsius: 27 }]);
});

Deno.test("the category Observer shows the word for the new temperature", () => {
  const sensor = new TemperatureSensor();
  const shown: TemperatureCategory[] = [];
  new CategoryObserver(sensor, (category) => shown.push(category));
  sensor.setTemperature(30);
  sensor.setTemperature(-1);
  assertEquals(shown, ["HOT", "COLD"]);
});
