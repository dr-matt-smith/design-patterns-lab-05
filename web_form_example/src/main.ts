// The entry point: reads your name from the page, stores it in a Person, and greets you.
// main.ts is the only file that talks to the page (the DOM).

import { Person } from "./Person.ts";

const person1 = new Person();

const form = document.querySelector<HTMLFormElement>("#greet-form");
const nameInput = document.querySelector<HTMLInputElement>("#name");
const output = document.querySelector<HTMLParagraphElement>("#output");

// querySelector gives null if index.html has no matching element - so stop here, with a clear message.
if (form === null || nameInput === null || output === null) {
  throw new Error("index.html needs elements with the ids greet-form, name and output");
}

output.textContent = "Type your name, then click Greet (or press Enter)";

form.addEventListener("submit", (event) => {
  event.preventDefault(); // stop the browser reloading the page
  if (nameInput.value.trim() === "") {
    output.textContent = "No name given";
  } else {
    person1.setName(nameInput.value);
    output.textContent = `Nice to meet you, ${person1.getName()}!`;
  }
});
