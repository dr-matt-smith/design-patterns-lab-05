// The Observer interface (Approach B): update() is given the Subject that changed.

import type { Subject } from "./Subject.ts";

export interface Observer {
  /** Called by `subject` whenever its state changes. */
  update(subject: Subject): void;
}
