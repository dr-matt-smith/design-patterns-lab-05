{
  "name": "Class diagram - Observer Pattern Approach A: Stored Subject (terminal)",
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
      "text": "# Class diagram\n## Observer Pattern - Approach A: Stored Subject\n\nEach Observer **stores a reference** to the sensor it observes, and asks it for the temperature when it receives `update()`.\n\nThis project (terminal version): a **temperature sensor** (the Subject) with one Observer, which prints **HOT / WARM / COOL / COLD** for each temperature you type.\n\nSlides: overview, then Subject, Observer, TemperatureSensor, CategoryObserver, TemperatureCategory, main.ts\n\n<!-- colours: green = abstract Subject, blue = interface, yellow = type, grey = module (a file of functions) -->\n"
    },
    {
      "name": "Overview",
      "x": 240,
      "y": 0,
      "text": "<style scoped>\nsvg[data-nomnoml] { max-height: 400px; }\nsection { font-size: 22px; }\n</style>\n\n# Overview\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<abstract id=Subject>«abstract»;Subject]\n[<interface id=Observer>«interface»;Observer]\n[<module id=TC>«module»;TemperatureCategory.ts]\n[Subject] observers -> * [Observer]\n[Subject] <:- [TemperatureSensor]\n[Observer] <:-- [CategoryObserver]\n[TemperatureSensor] 1 <- sensor [CategoryObserver]\n[CategoryObserver] --> [TC]\n```\n\nEach Observer has a `sensor` field - an association back to the **concrete** Subject - so `update()` needs no parameters.\n"
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
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# Observer\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<interface id=Observer>«interface»;Observer||+ update(): void]\n[CategoryObserver]\n[Observer] <:-- [CategoryObserver]\n[Subject]\n[Subject] observers -> * [Observer]\n```\n\n- An **interface**: one method, `update()`, with **no parameters**\n- `update()` only says *something changed* - not what\n- So each Observer must find the new state itself: it **stores the sensor** and asks it\n- Implemented by `CategoryObserver`\n"
    },
    {
      "name": "TemperatureSensor",
      "x": 960,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# TemperatureSensor\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<abstract id=Subject>«abstract»;Subject]\n[TemperatureSensor|- celsius: number = 20|+ getTemperature(): number;+ setTemperature(celsius: number): void]\n[Subject] <:- [TemperatureSensor]\n```\n\n- The **concrete Subject**: `extends Subject`\n- Holds the state: `celsius`, which starts at 20\n- `setTemperature()` changes the state, **then calls `notify()`** - that is what sets the Observers off\n"
    },
    {
      "name": "CategoryObserver",
      "x": 1200,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# CategoryObserver\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<interface id=Observer>«interface»;Observer]\n[CategoryObserver|- sensor: TemperatureSensor|+ constructor(sensor);+ update(): void]\n[TemperatureSensor]\n[<module id=TC>«module»;TemperatureCategory.ts]\n[Observer] <:-- [CategoryObserver]\n[TemperatureSensor] 1 <- sensor [CategoryObserver]\n[CategoryObserver] --> [TC]\n```\n\n- **The Observer**: shows HOT, WARM, COOL or COLD\n- Its constructor **stores the sensor** and attaches itself\n- `update()` asks `this.sensor.getTemperature()` - it **pulls** the new state\n- then prints e.g. `21°C is WARM` with `console.log()`\n"
    },
    {
      "name": "TemperatureCategory",
      "x": 0,
      "y": 140,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# TemperatureCategory.ts\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<module id=TC>«module»;TemperatureCategory.ts|- HOT_ABOVE = 25;- WARM_FROM = 20;- COOL_FROM = 15|+ categorise(celsius: number): TemperatureCategory]\n[<type id=Category>«type»;TemperatureCategory|\"HOT\" \\| \"WARM\" \\| \"COOL\" \\| \"COLD\"]\n[CategoryObserver]\n[TC] returns --> [Category]\n[CategoryObserver] --> [TC]\n```\n\n- A **module**: a file of constants and one function - not a class\n- `TemperatureCategory` is a **type**: only the four words are allowed\n- `categorise()`: above 25 is HOT, 20-25 WARM, 15-19 COOL, below 15 COLD\n- No DOM, no Observer code - so it is easy to test on its own\n"
    },
    {
      "name": "main.ts",
      "x": 240,
      "y": 140,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# main.ts\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<module id=main>«module»;main.ts|- sensor: TemperatureSensor|reads temperatures with prompt()]\n[TemperatureSensor]\n[main] --> [TemperatureSensor]\n[CategoryObserver]\n[main] --> creates [CategoryObserver]\n```\n\n- The entry point: run it with `deno run src/main.ts`\n- Makes the sensor, then the Observer - which **attaches itself** in its constructor\n- Then reads temperatures with `prompt()`: each one calls `sensor.setTemperature()`\n- Pressing Enter on its own stops the program\n"
    },
    {
      "name": "Exercise",
      "x": 480,
      "y": 140,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 55% 45%; grid-template-rows: auto 1fr; column-gap: 24px; align-items: start; font-size: 24px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 450px; }\n</style>\n\n# Exercise: add a JSON log Observer\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<interface id=Observer>«interface»;Observer]\n#.todo: fill=#FFE0E0 dashed title=bold\n[<todo>JsonLogObserver|- readings: Reading\\[\\];- sensor: TemperatureSensor|+ update(): void]\n[CategoryObserver]\n[Observer] <:-- [CategoryObserver]\n[Observer] <:-- [JsonLogObserver]\n[TemperatureSensor]\n[TemperatureSensor] 1 <- sensor [JsonLogObserver]\n```\n\n- Write `JsonLogObserver`, which `implements Observer` - use `CategoryObserver` as a model\n- In `update()`, add a reading and save the log: `Deno.writeTextFileSync(...)`\n- In `main.ts`, make one for the sensor (it attaches itself), next to the `CategoryObserver`\n- Run with `deno run --allow-write=temperature_log.json src/main.ts` - see the README\n"
    }
  ]
}
