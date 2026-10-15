// Observer 2: shows whether it is HOT, WARM, COOL or COLD.
// Approach A: it stores a reference to the sensor it observes, and asks it for the temperature in update().

import type { Observer } from "./Observer.ts";
import { categorise, type TemperatureCategory } from "./TemperatureCategory.ts";
import type { TemperatureSensor } from "./TemperatureSensor.ts";

export class CategoryObserver implements Observer {
  /**
   * @param sensor the Subject to observe - stored, so update() can ask it for the temperature
   * @param show   what to do with the category word (main.ts puts it on the page; a test can just keep it)
   */
  constructor(
    private readonly sensor: TemperatureSensor,
    private readonly show: (category: TemperatureCategory) => void,
  ) {
    sensor.attach(this);
  }

  public update(): void {
    this.show(categorise(this.sensor.getTemperature())); // pull the new state from the stored Subject
  }
}
