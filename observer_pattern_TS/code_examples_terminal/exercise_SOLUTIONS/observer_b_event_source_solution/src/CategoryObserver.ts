// The Observer: prints whether it is HOT, WARM, COOL or COLD.
// Approach B: no stored sensor - update() is given the Subject that changed.

import type { Observer } from "./Observer.ts";
import type { Subject } from "./Subject.ts";
import { categorise } from "./TemperatureCategory.ts";

export class CategoryObserver implements Observer {
  public update(subject: Subject): void {
    const celsius = subject.getTemperature(); // the parameter says which Subject changed
    console.log(`${celsius}°C is ${categorise(celsius)}`);
  }
}
