// Tests for the Subject: does it send update(this) to the right Observers?

import { assertEquals, assertStrictEquals } from "@std/assert";
import type { Observer } from "../src/Observer.ts";
import type { Subject } from "../src/Subject.ts";
import { TemperatureSensor } from "../src/TemperatureSensor.ts";

/** An Observer that keeps every Subject it is sent. */
class RecordingObserver implements Observer {
  public readonly senders: Subject[] = [];
  public update(subject: Subject): void {
    this.senders.push(subject);
  }
}

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
