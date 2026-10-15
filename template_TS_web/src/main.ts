// The entry point: reads your name from the page, stores it in a Person, and greets you.
// main.ts is the only file that talks to the page (the DOM).

import { Person } from "./Person.ts";

const person1 = new Person();
person1.setName("Matt");

const outputElement = document.querySelector<HTMLParagraphElement>("#output");

if (outputElement === null) {
  console.log("ERROR - could not find an html element with ID = 'output'");
} else {
    outputElement.textContent = "Nice to meet you, " + person1.getName() + "!";
}