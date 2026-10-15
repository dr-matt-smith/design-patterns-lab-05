// Tests for the Subject and its two Observers. A `show` function that just keeps what it is given
// stands in for the page, so no browser is needed.

import { assertEquals, assertStrictEquals } from "@std/assert";
import { CategoryObserver } from "../src/CategoryObserver.ts";
import { JsonLogObserver } from "../src/JsonLogObserver.ts";
import type { Observer } from "../src/Observer.ts";
import type { Subject } from "../src/Subject.ts";
import type { TemperatureCategory } from "../src/TemperatureCategory.ts";
import { TemperatureSensor } from "../src/TemperatureSensor.ts";

/** An Observer that keeps every Subject it is sent. */
class RecordingObserver implements Observer {
  public readonly senders: Subject[] = [];
  public update(subject: Subject): void {
    this.senders.push(subject);
  }
}

Deno.test("every attached Observer is sent update() when the temperature changes", () => {
  const sensor = new TemperatureSensor();
  const first = new RecordingObserver();
  const second = new RecordingObserver();
  sensor.attach(first);
  sensor.attach(second);
  sensor.setTemperature(21);
  assertEquals(first.senders.length, 1);
  assertEquals(second.senders.length, 1);
});

Deno.test("the Subject passes itself to update()", () => {
  const sensor = new TemperatureSensor();
  const observer = new RecordingObserver();
  sensor.attach(observer);
  sensor.setTemperature(21);
  assertStrictEquals(observer.senders[0], sensor);
});

Deno.test("one Observer can tell two Subjects apart", () => {
  const indoor = new TemperatureSensor();
  const outdoor = new TemperatureSensor();
  const observer = new RecordingObserver();
  indoor.attach(observer);
  outdoor.attach(observer);
  outdoor.setTemperature(3);
  indoor.setTemperature(21);
  assertStrictEquals(observer.senders[0], outdoor);
  assertStrictEquals(observer.senders[1], indoor);
});

Deno.test("a detached Observer is not sent update()", () => {
  const sensor = new TemperatureSensor();
  const observer = new RecordingObserver();
  sensor.attach(observer);
  sensor.detach(observer);
  sensor.setTemperature(21);
  assertEquals(observer.senders.length, 0);
});

Deno.test("the JSON log records every reading, in order", () => {
  const sensor = new TemperatureSensor();
  let shown = "";
  sensor.attach(new JsonLogObserver((json) => shown = json));
  sensor.setTemperature(21);
  sensor.setTemperature(27);
  assertEquals(JSON.parse(shown), [{ reading: 1, celsius: 21 }, { reading: 2, celsius: 27 }]);
});

Deno.test("the category Observer shows the word for the new temperature", () => {
  const sensor = new TemperatureSensor();
  const shown: TemperatureCategory[] = [];
  sensor.attach(new CategoryObserver((category) => shown.push(category)));
  sensor.setTemperature(30);
  sensor.setTemperature(-1);
  assertEquals(shown, ["HOT", "COLD"]);
});
