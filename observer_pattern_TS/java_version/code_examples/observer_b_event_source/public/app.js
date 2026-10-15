// The page's script: makes a button for each temperature. A click sends the temperature to the Java
// program (where the Subject changes), then shows what each Observer output.

const LOWEST = -1; // °C
const HIGHEST = 30; // °C

const jsonOutput = document.querySelector("#json-log");
const categoryOutput = document.querySelector("#category");
const buttons = document.querySelector("#buttons");

/** Puts both Observers' output (sent by the Java program) on the page. */
async function showOutputs(response) {
  const outputs = await response.json();
  jsonOutput.textContent = outputs.json;
  jsonOutput.scrollTop = jsonOutput.scrollHeight;
  categoryOutput.textContent = outputs.category;
  categoryOutput.className = `category ${outputs.category.toLowerCase()}`;
}

buttons.replaceChildren();
for (let celsius = LOWEST; celsius <= HIGHEST; celsius++) {
  const button = document.createElement("button");
  button.textContent = `${celsius}°C`;
  button.addEventListener("click", () => {
    fetch(`/temperature?celsius=${celsius}`, { method: "POST" }).then(showOutputs);
  });
  buttons.append(button);
}

fetch("/outputs").then(showOutputs);
