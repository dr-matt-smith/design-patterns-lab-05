// The entry point: asks for your name, stores it in a Person, and greets you.
//
// Run it with:  deno run src/main.ts

import { Person } from "./Person.ts";

const person1 = new Person();

const nameInput = prompt("What is your name?");
if (nameInput === null) {
  console.log("No name given");
} else {
  person1.setName(nameInput);
  console.log(`Nice to meet you, ${person1.getName()}!`);
}