// The Observer: prints whether it is HOT, WARM, COOL or COLD.
// Approach A: it stores a reference to the sensor it observes, and asks it for the temperature in update().

import type { Observer } from "./Observer.ts";
import { categorise } from "./TemperatureCategory.ts";
import type { TemperatureSensor } from "./TemperatureSensor.ts";

export class CategoryObserver implements Observer {
  /** @param sensor the Subject to observe - stored, so update() can ask it for the temperature */
  constructor(private readonly sensor: TemperatureSensor) {
    sensor.attach(this);
  }

  public update(): void {
    const celsius = this.sensor.getTemperature(); // pull the new state from the stored Subject
    console.log(`${celsius}°C is ${categorise(celsius)}`);
  }
}
