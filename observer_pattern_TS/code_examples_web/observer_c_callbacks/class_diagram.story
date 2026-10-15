{
  "name": "Class diagram - Observer Pattern Approach C: Callback Functions (web)",
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
      "text": "# Class diagram\n## Observer Pattern - Approach C: Callback Functions\n\nThere is **no Observer interface**: the sensor calls plain **functions**, passing them the new temperature.\n\nThis project (web version): a **temperature sensor** (the Subject) with two Observers - a **JSON log** and a **HOT / WARM / COOL / COLD** display - and a button for each temperature from -1°C to 30°C.\n\nSlides: overview, then Subject (+ TemperatureListener), TemperatureSensor, JsonLog, Observers as functions, TemperatureCategory, main.ts\n\n<!-- colours: green = abstract Subject, blue = interface, yellow = type, grey = module (a file of functions) -->\n"
    },
    {
      "name": "Overview",
      "x": 240,
      "y": 0,
      "text": "<style scoped>\nsvg[data-nomnoml] { max-height: 400px; }\nsection { font-size: 22px; }\n</style>\n\n# Overview\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<abstract id=Subject>«abstract»;Subject]\n[<type id=Listener>«type»;TemperatureListener]\n[<module id=TC>«module»;TemperatureCategory.ts]\n[Subject] listeners -> * [Listener]\n[Subject] <:- [TemperatureSensor]\n[Listener] <:-- [<note>(celsius) =\\> showCategory(categorise(celsius))]\n[<note>(celsius) =\\> showCategory(categorise(celsius))] --> [TC]\n[Listener] <:-- [<note>(celsius) =\\> jsonLog.record(celsius)]\n[<note>(celsius) =\\> jsonLog.record(celsius)] calls --> [JsonLog]\n```\n\nNo Observer classes: the Observers are **arrow functions**, written in `main.ts`, that fit the `TemperatureListener` type.\n"
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
      "name": "JsonLog",
      "x": 960,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# JsonLog\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[JsonLog|- readings: Reading\\[\\];- show: (json: string) =\\> void|+ constructor(show);+ record(celsius: number): void;+ toJson(): string]\n[<interface id=Reading>«interface»;Reading|reading: number;celsius: number]\n[<note>(celsius) =\\> jsonLog.record(celsius)]\n[JsonLog] readings -> * [Reading]\n[<note>(celsius) =\\> jsonLog.record(celsius)] calls record() --> [JsonLog]\n```\n\n- An **ordinary class**: it implements no Observer interface\n- `record(celsius)` adds a `Reading`, then calls `show(toJson())`\n- `main.ts` attaches an **arrow function** that calls it: `sensor.attach((celsius) => jsonLog.record(celsius))`\n- Not `sensor.attach(jsonLog.record)`: the method would lose `this`\n"
    },
    {
      "name": "Observers as functions",
      "x": 1200,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# Observers as functions\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<abstract id=Subject>«abstract»;Subject]\n[<type id=Listener>«type»;TemperatureListener|(celsius: number) =\\> void]\n[<note>(celsius) =\\> showCategory(categorise(celsius))]\n[<module id=TC>«module»;TemperatureCategory.ts]\n[Subject] listeners -> * [Listener]\n[Listener] <:-- [<note>(celsius) =\\> showCategory(categorise(celsius))]\n[<note>(celsius) =\\> showCategory(categorise(celsius))] --> [TC]\n```\n\n- The category Observer is **not a class** - it's an arrow function in `main.ts`\n- Any function `(celsius: number) => void` *is* a `TemperatureListener` - nothing to implement\n- `notify()` calls it with the new temperature (**push**), so it never calls back to the sensor\n- It turns the temperature into a word, and puts it on the page\n"
    },
    {
      "name": "TemperatureCategory",
      "x": 0,
      "y": 140,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# TemperatureCategory.ts\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<module id=TC>«module»;TemperatureCategory.ts|- HOT_ABOVE = 25;- WARM_FROM = 20;- COOL_FROM = 15|+ categorise(celsius: number): TemperatureCategory]\n[<type id=Category>«type»;TemperatureCategory|\"HOT\" \\| \"WARM\" \\| \"COOL\" \\| \"COLD\"]\n[<module id=main>«module»;main.ts]\n[TC] returns --> [Category]\n[main] --> [TC]\n```\n\n- A **module**: a file of constants and one function - not a class\n- `TemperatureCategory` is a **type**: only the four words are allowed\n- `categorise()`: above 25 is HOT, 20-25 WARM, 15-19 COOL, below 15 COLD\n- No DOM, no Observer code - so it is easy to test on its own\n"
    },
    {
      "name": "main.ts",
      "x": 240,
      "y": 140,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# main.ts\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<module id=main>«module»;main.ts|- jsonOutput: HTMLPreElement;- categoryOutput: HTMLElement;- buttons: HTMLElement;- sensor: TemperatureSensor|- showJson(json): void;- showCategory(category): void]\n[TemperatureSensor]\n[main] --> [TemperatureSensor]\n[JsonLog]\n[<type id=Listener>«type»;TemperatureListener]\n[main] --> creates [JsonLog]\n[main] --> attaches 2 functions [Listener]\n```\n\n- The entry point, and the **only file that touches the page** (the DOM)\n- Finds the page's elements with `document.querySelector()`\n- Makes the sensor and a `JsonLog`, then **attaches two arrow functions**\n- Makes a button for each temperature: a click only calls `sensor.setTemperature()` - the Observers do the rest\n"
    }
  ]
}
