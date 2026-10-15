// Observer 2: shows whether it is HOT, WARM, COOL or COLD.
// Approach B: no stored sensor - update() is given the Subject that changed.

import type { Observer } from "./Observer.ts";
import type { Subject } from "./Subject.ts";
import { categorise, type TemperatureCategory } from "./TemperatureCategory.ts";

export class CategoryObserver implements Observer {
  /** @param show what to do with the category word (main.ts puts it on the page; a test can just keep it) */
  constructor(private readonly show: (category: TemperatureCategory) => void) {}

  public update(subject: Subject): void {
    this.show(categorise(subject.getTemperature())); // the parameter says which Subject changed
  }
}
