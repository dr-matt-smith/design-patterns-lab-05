{
  "name": "Class diagram - Observer Pattern Approach A: Stored Subject (web)",
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
      "text": "# Class diagram\n## Observer Pattern - Approach A: Stored Subject\n\nEach Observer **stores a reference** to the sensor it observes, and asks it for the temperature when it receives `update()`.\n\nThis project (web version): a **temperature sensor** (the Subject) with two Observers - a **JSON log** and a **HOT / WARM / COOL / COLD** display - and a button for each temperature from -1°C to 30°C.\n\nSlides: overview, then Subject, Observer, TemperatureSensor, JsonLogObserver, CategoryObserver, TemperatureCategory, main.ts\n\n<!-- colours: green = abstract Subject, blue = interface, yellow = type, grey = module (a file of functions) -->\n"
    },
    {
      "name": "Overview",
      "x": 240,
      "y": 0,
      "text": "<style scoped>\nsvg[data-nomnoml] { max-height: 400px; }\nsection { font-size: 22px; }\n</style>\n\n# Overview\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<abstract id=Subject>«abstract»;Subject]\n[<interface id=Observer>«interface»;Observer]\n[<module id=TC>«module»;TemperatureCategory.ts]\n[Subject] observers -> * [Observer]\n[Subject] <:- [TemperatureSensor]\n[Observer] <:-- [JsonLogObserver]\n[Observer] <:-- [CategoryObserver]\n[TemperatureSensor] 1 <- sensor [JsonLogObserver]\n[TemperatureSensor] 1 <- sensor [CategoryObserver]\n[CategoryObserver] --> [TC]\n```\n\nEach Observer has a `sensor` field - an association back to the **concrete** Subject - so `update()` needs no parameters.\n"
    },
    {
      "name": "Subject",
      "x": 480,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# Subject\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<abstract id=Subject>«abstract»;Subject|- observers: Observer\\[\\]|+ attach(observer: Observer): void;+ detach(observer: Observer): void;+ notify(): void]\n[<interface id=Observer>«interface»;Observer]\n[TemperatureSensor]\n[Subject] observers -> * [Observer]\n[Subject] <:- [TemperatureSensor]\n```\n\n- **Abstract**: never made directly - `TemperatureSensor` extends it\n- Keeps a private list of `Observer`s\n- `attach()` and `detach()` add and remove an Observer\n- `notify()` sends `update()` - with **no parameters** - to every Observer\n- Knows nothing about temperatures\n"
    },
    {
      "name": "Observer",
      "x": 720,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# Observer\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<interface id=Observer>«interface»;Observer||+ update(): void]\n[JsonLogObserver]\n[CategoryObserver]\n[Observer] <:-- [JsonLogObserver]\n[Observer] <:-- [CategoryObserver]\n[Subject]\n[Subject] observers -> * [Observer]\n```\n\n- An **interface**: one method, `update()`, with **no parameters**\n- `update()` only says *something changed* - not what\n- So each Observer must find the new state itself: it **stores the sensor** and asks it\n- Implemented by `JsonLogObserver` and `CategoryObserver`\n"
    },
    {
      "name": "TemperatureSensor",
      "x": 960,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# TemperatureSensor\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<abstract id=Subject>«abstract»;Subject]\n[TemperatureSensor|- celsius: number = 20|+ getTemperature(): number;+ setTemperature(celsius: number): void]\n[Subject] <:- [TemperatureSensor]\n```\n\n- The **concrete Subject**: `extends Subject`\n- Holds the state: `celsius`, which starts at 20\n- `setTemperature()` changes the state, **then calls `notify()`** - that is what sets the Observers off\n"
    },
    {
      "name": "JsonLogObserver",
      "x": 1200,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# JsonLogObserver\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<interface id=Observer>«interface»;Observer]\n[JsonLogObserver|- readings: Reading\\[\\];- sensor: TemperatureSensor;- show: (json: string) =\\> void|+ constructor(sensor, show);+ update(): void;+ toJson(): string]\n[<interface id=Reading>«interface»;Reading|reading: number;celsius: number]\n[TemperatureSensor]\n[Observer] <:-- [JsonLogObserver]\n[JsonLogObserver] readings -> * [Reading]\n[TemperatureSensor] 1 <- sensor [JsonLogObserver]\n```\n\n- **Observer 1**: logs every reading, and shows the whole log as JSON\n- Its constructor **stores the sensor** and attaches itself\n- `update()` asks `this.sensor.getTemperature()`, adds a `Reading`, then calls `show(toJson())`\n- `show` comes from `main.ts`, which puts the JSON on the page - so the class has no DOM code, and can be tested\n"
    },
    {
      "name": "CategoryObserver",
      "x": 0,
      "y": 140,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# CategoryObserver\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<interface id=Observer>«interface»;Observer]\n[CategoryObserver|- sensor: TemperatureSensor;- show: (category: TemperatureCategory) =\\> void|+ constructor(sensor, show);+ update(): void]\n[TemperatureSensor]\n[<module id=TC>«module»;TemperatureCategory.ts]\n[Observer] <:-- [CategoryObserver]\n[TemperatureSensor] 1 <- sensor [CategoryObserver]\n[CategoryObserver] --> [TC]\n```\n\n- **Observer 2**: shows HOT, WARM, COOL or COLD\n- Its constructor **stores the sensor** and attaches itself\n- `update()` asks `this.sensor.getTemperature()` - it **pulls** the new state\n- then calls `show(categorise(...))`; `main.ts` puts the word on the page\n"
    },
    {
      "name": "TemperatureCategory",
      "x": 240,
      "y": 140,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# TemperatureCategory.ts\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<module id=TC>«module»;TemperatureCategory.ts|- HOT_ABOVE = 25;- WARM_FROM = 20;- COOL_FROM = 15|+ categorise(celsius: number): TemperatureCategory]\n[<type id=Category>«type»;TemperatureCategory|\"HOT\" \\| \"WARM\" \\| \"COOL\" \\| \"COLD\"]\n[CategoryObserver]\n[TC] returns --> [Category]\n[CategoryObserver] --> [TC]\n```\n\n- A **module**: a file of constants and one function - not a class\n- `TemperatureCategory` is a **type**: only the four words are allowed\n- `categorise()`: above 25 is HOT, 20-25 WARM, 15-19 COOL, below 15 COLD\n- No DOM, no Observer code - so it is easy to test on its own\n"
    },
    {
      "name": "main.ts",
      "x": 480,
      "y": 140,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# main.ts\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<module id=main>«module»;main.ts|- jsonOutput: HTMLPreElement;- categoryOutput: HTMLElement;- buttons: HTMLElement;- sensor: TemperatureSensor|- showJson(json): void;- showCategory(category): void]\n[TemperatureSensor]\n[main] --> [TemperatureSensor]\n[JsonLogObserver]\n[CategoryObserver]\n[main] --> creates [JsonLogObserver]\n[main] --> creates [CategoryObserver]\n```\n\n- The entry point, and the **only file that touches the page** (the DOM)\n- Finds the page's elements with `document.querySelector()`\n- Makes the sensor, then the two Observers - **each attaches itself** in its constructor\n- Makes a button for each temperature: a click only calls `sensor.setTemperature()` - the Observers do the rest\n"
    }
  ]
}
