{
  "name": "Class diagram - Observer Pattern Approach C: Callback Functions (terminal)",
  "description": "The classes in this project: a UML overview, then one slide per class",
  "navigation": {
    "show": true,
    "style": "arrows",
    "position": "top-right",
    "showNumber": true
  },
  "sequenceArrows": {
    "show": true,
    "style": "dashed",
    "color": "#ffcc00",
    "alpha": 0.75
  },
  "nodes": [
    {
      "name": "Class diagram",
      "x": 0,
      "y": 0,
      "text": "# Class diagram\n## Observer Pattern - Approach C: Callback Functions\n\nThere is **no Observer interface**: the sensor calls plain **functions**, passing them the new temperature.\n\nThis project (terminal version): a **temperature sensor** (the Subject) with one Observer, which prints **HOT / WARM / COOL / COLD** for each temperature you type.\n\nSlides: overview, then Subject (+ TemperatureListener), TemperatureSensor, Observers as functions, TemperatureCategory, main.ts\n\n<!-- colours: green = abstract Subject, blue = interface, yellow = type, grey = module (a file of functions) -->\n"
    },
    {
      "name": "Overview",
      "x": 240,
      "y": 0,
      "text": "<style scoped>\nsvg[data-nomnoml] { max-height: 400px; }\nsection { font-size: 22px; }\n</style>\n\n# Overview\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<abstract id=Subject>«abstract»;Subject]\n[<type id=Listener>«type»;TemperatureListener]\n[<module id=TC>«module»;TemperatureCategory.ts]\n[Subject] listeners -> * [Listener]\n[Subject] <:- [TemperatureSensor]\n[Listener] <:-- [<note>(celsius) =\\> console.log(...categorise(celsius))]\n[<note>(celsius) =\\> console.log(...categorise(celsius))] --> [TC]\n```\n\nNo Observer classes: the Observers are **arrow functions**, written in `main.ts`, that fit the `TemperatureListener` type.\n"
    },
    {
      "name": "Subject",
      "x": 480,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# Subject and TemperatureListener\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<abstract id=Subject>«abstract»;Subject|- listeners: TemperatureListener\\[\\]|+ attach(listener: TemperatureListener): () =\\> void;+ detach(listener: TemperatureListener): void;+ notify(): void;+ getTemperature(): number «abstract»]\n[<type id=Listener>«type»;TemperatureListener|(celsius: number) =\\> void]\n[TemperatureSensor]\n[Subject] listeners -> * [Listener]\n[Subject] <:- [TemperatureSensor]\n```\n\n- `TemperatureListener` is a **function type**: any function `(celsius: number) => void` can observe\n- The Subject keeps a list of these functions\n- `attach()` returns an **unsubscribe** function - call it to detach\n- `notify()` calls each function with `getTemperature()`: the new state is **pushed**\n"
    },
    {
      "name": "TemperatureSensor",
      "x": 720,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# TemperatureSensor\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<abstract id=Subject>«abstract»;Subject]\n[TemperatureSensor|- celsius: number = 20|+ getTemperature(): number «override»;+ setTemperature(celsius: number): void]\n[Subject] <:- [TemperatureSensor]\n```\n\n- The **concrete Subject**: `extends Subject`\n- Holds the state: `celsius`, which starts at 20\n- `setTemperature()` changes the state, **then calls `notify()`** - that is what sets the Observers off\n- `getTemperature()` is the `override` of the Subject's abstract method\n"
    },
    {
      "name": "Observers as functions",
      "x": 960,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# Observers as functions\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<abstract id=Subject>«abstract»;Subject]\n[<type id=Listener>«type»;TemperatureListener|(celsius: number) =\\> void]\n[<note>(celsius) =\\> console.log(...categorise(celsius))]\n[<module id=TC>«module»;TemperatureCategory.ts]\n[Subject] listeners -> * [Listener]\n[Listener] <:-- [<note>(celsius) =\\> console.log(...categorise(celsius))]\n[<note>(celsius) =\\> console.log(...categorise(celsius))] --> [TC]\n```\n\n- The category Observer is **not a class** - it's an arrow function in `main.ts`\n- Any function `(celsius: number) => void` *is* a `TemperatureListener` - nothing to implement\n- `notify()` calls it with the new temperature (**push**), so it never calls back to the sensor\n- It prints e.g. `21°C is WARM`\n"
    },
    {
      "name": "TemperatureCategory",
      "x": 1200,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# TemperatureCategory.ts\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<module id=TC>«module»;TemperatureCategory.ts|- HOT_ABOVE = 25;- WARM_FROM = 20;- COOL_FROM = 15|+ categorise(celsius: number): TemperatureCategory]\n[<type id=Category>«type»;TemperatureCategory|\"HOT\" \\| \"WARM\" \\| \"COOL\" \\| \"COLD\"]\n[<module id=main>«module»;main.ts]\n[TC] returns --> [Category]\n[main] --> [TC]\n```\n\n- A **module**: a file of constants and one function - not a class\n- `TemperatureCategory` is a **type**: only the four words are allowed\n- `categorise()`: above 25 is HOT, 20-25 WARM, 15-19 COOL, below 15 COLD\n- No DOM, no Observer code - so it is easy to test on its own\n"
    },
    {
      "name": "main.ts",
      "x": 0,
      "y": 140,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# main.ts\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<module id=main>«module»;main.ts|- sensor: TemperatureSensor|reads temperatures with prompt()]\n[TemperatureSensor]\n[main] --> [TemperatureSensor]\n[<type id=Listener>«type»;TemperatureListener]\n[main] --> attaches a function [Listener]\n```\n\n- The entry point: run it with `deno run src/main.ts`\n- Makes the sensor, then **attaches an arrow function** that prints the category\n- Then reads temperatures with `prompt()`: each one calls `sensor.setTemperature()`\n- Pressing Enter on its own stops the program\n"
    },
    {
      "name": "Exercise",
      "x": 240,
      "y": 140,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# Exercise: add a JSON log Observer\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<type id=Listener>«type»;TemperatureListener]\n#.todo: fill=#FFE0E0 dashed title=bold\n[<todo>JsonLog|- readings: Reading\\[\\]|+ record(celsius: number): void]\n[<module id=main>«module»;main.ts]\n[main] attaches (celsius) =\\> jsonLog.record(celsius) --> [Listener]\n[main] --> creates [JsonLog]\n```\n\n- Write an ordinary class `JsonLog`, with a `record(celsius)` method\n- `record()` adds a reading and saves the log: `Deno.writeTextFileSync(...)`\n- In `main.ts`, attach an arrow function that calls `jsonLog.record(celsius)`\n- Run with `deno run --allow-write=temperature_log.json src/main.ts` - see the README\n"
    }
  ]
}
