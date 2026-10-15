{
  "name": "Class diagram - Observer Pattern Approach B: Event Source (terminal - exercise solution)",
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
      "text": "# Class diagram\n## Observer Pattern - Approach B: Event Source\n\nThe sensor **passes itself** to `update(subject)`, so the Observers don't need to store a reference to it.\n\nThis project (terminal, exercise solution version): a **temperature sensor** (the Subject) with two Observers - one prints **HOT / WARM / COOL / COLD** for each temperature you type, and a **JSON log** (the exercise solution) saves every reading to `temperature_log.json`.\n\nSlides: overview, then Subject, Observer, TemperatureSensor, JsonLogObserver, CategoryObserver, TemperatureCategory, main.ts\n\n<!-- colours: green = abstract Subject, blue = interface, yellow = type, grey = module (a file of functions) -->\n"
    },
    {
      "name": "Overview",
      "x": 240,
      "y": 0,
      "text": "<style scoped>\nsvg[data-nomnoml] { max-height: 400px; }\nsection { font-size: 22px; }\n</style>\n\n# Overview\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<abstract id=Subject>«abstract»;Subject]\n[<interface id=Observer>«interface»;Observer]\n[<module id=TC>«module»;TemperatureCategory.ts]\n[Subject] observers -> * [Observer]\n[Subject] <:- [TemperatureSensor]\n[Observer] <:-- [JsonLogObserver]\n[Observer] <:-- [CategoryObserver]\n[CategoryObserver] --> [TC]\n```\n\nNo association from the Observers back to the sensor: `notify()` passes it in, as `update(this)`.\n"
    },
    {
      "name": "Subject",
      "x": 480,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# Subject\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<abstract id=Subject>«abstract»;Subject|- observers: Observer\\[\\]|+ attach(observer: Observer): void;+ detach(observer: Observer): void;+ notify(): void;+ getTemperature(): number «abstract»]\n[<interface id=Observer>«interface»;Observer]\n[TemperatureSensor]\n[Subject] observers -> * [Observer]\n[Subject] <:- [TemperatureSensor]\n```\n\n- **Abstract**: never made directly - `TemperatureSensor` extends it\n- Keeps a private list of `Observer`s, added and removed with `attach()` and `detach()`\n- `notify()` sends **`update(this)`**: it passes *itself* to each Observer\n- Declares an abstract `getTemperature()`, so an Observer can ask **any** Subject it is given\n"
    },
    {
      "name": "Observer",
      "x": 720,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# Observer\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<interface id=Observer>«interface»;Observer||+ update(subject: Subject): void]\n[JsonLogObserver]\n[CategoryObserver]\n[Observer] <:-- [JsonLogObserver]\n[Observer] <:-- [CategoryObserver]\n[<abstract id=Subject>«abstract»;Subject]\n[Subject] observers -> * [Observer]\n[Observer] update(this) --> [Subject]\n```\n\n- An **interface**: one method, `update(subject: Subject)`\n- The Subject that changed is **passed in** - so no stored reference is needed\n- One Observer can watch **several** Subjects, and tell which one changed\n- Implemented by `JsonLogObserver` and `CategoryObserver`\n"
    },
    {
      "name": "TemperatureSensor",
      "x": 960,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# TemperatureSensor\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<abstract id=Subject>«abstract»;Subject]\n[TemperatureSensor|- celsius: number = 20|+ getTemperature(): number «override»;+ setTemperature(celsius: number): void]\n[Subject] <:- [TemperatureSensor]\n```\n\n- The **concrete Subject**: `extends Subject`\n- Holds the state: `celsius`, which starts at 20\n- `setTemperature()` changes the state, **then calls `notify()`** - that is what sets the Observers off\n- `getTemperature()` is the `override` of the Subject's abstract method\n"
    },
    {
      "name": "JsonLogObserver",
      "x": 1200,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# JsonLogObserver (the solution)\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<interface id=Observer>«interface»;Observer]\n[JsonLogObserver|- readings: Reading\\[\\];- file: string|+ constructor(file = LOG_FILE);+ update(subject: Subject): void;+ toJson(): string]\n[<interface id=Reading>«interface»;Reading|reading: number;celsius: number]\n[Observer] <:-- [JsonLogObserver]\n[JsonLogObserver] readings -> * [Reading]\n```\n\n- **Observer 2**: logs every reading to `temperature_log.json`\n- No `sensor` field: `update(subject)` reads `subject.getTemperature()`\n- Adds a `Reading`, then saves the whole log with `Deno.writeTextFileSync()`\n- `main.ts` attaches it: `sensor.attach(new JsonLogObserver())`\n"
    },
    {
      "name": "CategoryObserver",
      "x": 0,
      "y": 140,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# CategoryObserver\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<interface id=Observer>«interface»;Observer]\n[CategoryObserver||+ update(subject: Subject): void]\n[<module id=TC>«module»;TemperatureCategory.ts]\n[Observer] <:-- [CategoryObserver]\n[CategoryObserver] --> [TC]\n```\n\n- **Observer 1**: shows HOT, WARM, COOL or COLD\n- No `sensor` field: `update(subject)` reads `subject.getTemperature()`\n- `main.ts` attaches it: `sensor.attach(new CategoryObserver())`\n- prints e.g. `21°C is WARM` with `console.log()`\n"
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
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# main.ts\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<module id=main>«module»;main.ts|- sensor: TemperatureSensor|reads temperatures with prompt()]\n[TemperatureSensor]\n[main] --> [TemperatureSensor]\n[JsonLogObserver]\n[CategoryObserver]\n[main] --> attaches [JsonLogObserver]\n[main] --> attaches [CategoryObserver]\n```\n\n- The entry point: run it with `deno run --allow-write=temperature_log.json src/main.ts`\n- Makes the sensor, then **attaches** the two Observers: `sensor.attach(new ...)`\n- Then reads temperatures with `prompt()`: each one calls `sensor.setTemperature()`\n- Pressing Enter on its own stops the program\n"
    }
  ]
}
