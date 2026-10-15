// Tests for the Person class: does setName() store a name, and getName() give it back?

import { assertEquals } from "@std/assert";
import { Person } from "../src/Person.ts";

Deno.test("getName() returns the name given to setName()", () => {
  const person = new Person();
  person.setName("Ada");
  assertEquals(person.getName(), "Ada");
});

Deno.test("setName() replaces the old name", () => {
  const person = new Person();
  person.setName("Ada");
  person.setName("Grace");
  assertEquals(person.getName(), "Grace");
});

Deno.test("each Person keeps its own name", () => {
  const ada = new Person();
  const grace = new Person();
  ada.setName("Ada");
  grace.setName("Grace");
  assertEquals(ada.getName(), "Ada");
  assertEquals(grace.getName(), "Grace");
});

Deno.test("a name is stored exactly as given - spaces and all", () => {
  const person = new Person();
  person.setName("  Mary Jane  ");
  assertEquals(person.getName(), "  Mary Jane  ");
});
