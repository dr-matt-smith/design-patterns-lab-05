// Tests for the Subject: does it send update() to the right Observers?

import { assertEquals } from "@std/assert";
import type { Observer } from "../src/Observer.ts";
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
