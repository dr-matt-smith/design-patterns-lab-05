{
  "name": "UML class diagram revision",
  "description": "A reference to the UML notation used in class_diagram.story: classes, members, visibility, abstract classes, interfaces, and the lines between them",
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
      "name": "UML revision",
      "x": 0,
      "y": 0,
      "text": "<style scoped>\nsection { font-size: 26px; }\n</style>\n\n# UML class diagram revision\n\nA **class diagram** shows the classes in a program, what is inside each one, and how they are connected.\n\nThese slides explain each piece of the notation used in this project's **`class_diagram.story`**:\n\n- a **class** box: its name, **fields** and **methods**, and their **visibility**\n- **abstract** classes and methods, **interfaces**, and other boxes (**types**, **modules**, **notes**)\n- the lines between boxes: **inheritance**, **implementation**, **association** (with **multiplicity**) and **dependency**\n\nEach slide shows the UML on the left, and what it means - with the TypeScript it comes from - on the right.\n"
    },
    {
      "name": "Colours",
      "x": 240,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 50% 50%; grid-template-rows: auto 1fr; column-gap: 28px; align-items: start; font-size: 23px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 430px; }\npre { font-size: 17px; margin-top: 8px; }\nul { margin-top: 0; }\n</style>\n\n# Colours in our diagrams\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<abstract id=S>«abstract»;Subject]\n[<interface id=O>«interface»;Observer]\n[TemperatureSensor]\n[<type id=T>«type»;TemperatureCategory]\n[<module id=M>«module»;main.ts]\n[<note>a note - e.g. an arrow function]\n[S] -/- [TemperatureSensor]\n[TemperatureSensor] -/- [M]\n[O] -/- [T]\n[T] -/- [<note>a note - e.g. an arrow function]\n```\n\n<div>\n\n- **Colour is not part of UML** - it is a convention in our diagrams, to make each kind of box easy to spot\n- **green**: an abstract class\n- **blue**: an interface\n- **white**: an ordinary (concrete) class\n- **yellow**: a type\n- **grey**: a module (a file of functions)\n- **pale yellow, folded corner**: a note\n\n</div>\n"
    },
    {
      "name": "A class",
      "x": 480,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 50% 50%; grid-template-rows: auto 1fr; column-gap: 28px; align-items: start; font-size: 23px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 430px; }\npre { font-size: 17px; margin-top: 8px; }\nul { margin-top: 0; }\n</style>\n\n# A class\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[TemperatureSensor|- celsius: number = 20|+ getTemperature(): number;+ setTemperature(celsius: number): void]\n```\n\n<div>\n\n- A class is a box with **three compartments**:\n- 1 - the class **name** (bold)\n- 2 - its **fields** (also called attributes): the data each object holds\n- 3 - its **methods** (also called operations): what each object can do\n\n```ts\nclass TemperatureSensor extends Subject {\n  private celsius: number = 20;\n\n  public getTemperature(): number { ... }\n  public setTemperature(celsius: number): void { ... }\n}\n```\n\n</div>\n"
    },
    {
      "name": "Visibility",
      "x": 720,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 50% 50%; grid-template-rows: auto 1fr; column-gap: 28px; align-items: start; font-size: 23px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 430px; }\npre { font-size: 17px; margin-top: 8px; }\nul { margin-top: 0; }\n</style>\n\n# Visibility: + public, - private, # protected\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[Example|+ name: string;- secret: number;# shared: boolean|+ publicMethod(): void;- privateHelper(): void;# forSubclasses(): void]\n```\n\n<div>\n\n- The symbol in front of each member says **who can use it**\n- `+` **public**: any code\n- `-` **private**: only this class\n- `#` **protected**: this class and its subclasses\n- Fields are usually private (`-`); the methods other objects call are public (`+`)\n\n```ts\npublic name: string;\nprivate secret: number;\nprotected shared: boolean;\n```\n\n</div>\n"
    },
    {
      "name": "Fields",
      "x": 960,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 50% 50%; grid-template-rows: auto 1fr; column-gap: 28px; align-items: start; font-size: 23px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 430px; }\npre { font-size: 17px; margin-top: 8px; }\nul { margin-top: 0; }\n</style>\n\n# Fields: name: type\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[JsonLogObserver|- readings: Reading\\[\\];- sensor: TemperatureSensor;- show: (json: string) =\\> void|...]\n```\n\n<div>\n\n- A field is written **`name: type`** - the same order as TypeScript\n- A starting value can follow: `- celsius: number = 20`\n- `Reading[]` is an **array** of `Reading`s\n- `(json: string) => void` is a **function type**: this field holds a function\n- A field whose type is another class (`sensor`) is usually *also* drawn as an **association** line - see later\n\n</div>\n"
    },
    {
      "name": "Methods",
      "x": 1200,
      "y": 0,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 50% 50%; grid-template-rows: auto 1fr; column-gap: 28px; align-items: start; font-size: 23px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 430px; }\npre { font-size: 17px; margin-top: 8px; }\nul { margin-top: 0; }\n</style>\n\n# Methods: name(parameters): return type\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[JsonLogObserver|...|+ constructor(sensor, show);+ update(): void;+ toJson(): string]\n```\n\n<div>\n\n- A method is written **`name(parameter: type): returnType`**\n- `void` means it returns nothing\n- Parameters can be left out, or shortened to their names, to keep a box small: `constructor(sensor, show)`\n- The **constructor** is shown when it matters - e.g. here it attaches the Observer to the sensor\n\n```ts\npublic update(): void { ... }\npublic toJson(): string { ... }\n```\n\n</div>\n"
    },
    {
      "name": "Static members",
      "x": 0,
      "y": 140,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 50% 50%; grid-template-rows: auto 1fr; column-gap: 28px; align-items: start; font-size: 23px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 430px; }\npre { font-size: 17px; margin-top: 8px; }\nul { margin-top: 0; }\n</style>\n\n# Static members (not used in our projects)\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[Counter|+ instances: number «static»;- count: number|+ create(): Counter «static»;+ increment(): void]\n```\n\n<div>\n\n- A **static** member belongs to the **class itself**, not to each object\n- Standard UML **underlines** static members; here they are marked `«static»`\n- Our Observer projects have no static members - but you will meet them in other diagrams\n\n```ts\nclass Counter {\n  public static instances = 0;\n  public static create(): Counter { ... }\n}\n```\n\n</div>\n"
    },
    {
      "name": "Abstract classes",
      "x": 240,
      "y": 140,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 50% 50%; grid-template-rows: auto 1fr; column-gap: 28px; align-items: start; font-size: 23px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 430px; }\npre { font-size: 17px; margin-top: 8px; }\nul { margin-top: 0; }\n</style>\n\n# Abstract classes and methods\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<abstract id=Subject>«abstract»;Subject|- observers: Observer\\[\\]|+ attach(observer: Observer): void;+ notify(): void;+ getTemperature(): number «abstract»]\n```\n\n<div>\n\n- An **abstract class** can't be made with `new` - it is there to be extended\n- Shown with its name in *italics*, and the stereotype **«abstract»**\n- An **abstract method** has no body: every subclass must provide it. Shown in *italics* or marked `«abstract»`\n- A **stereotype** is a word in `«guillemets»` that says what kind of thing a box is\n\n```ts\nabstract class Subject {\n  public abstract getTemperature(): number;\n}\n```\n\n</div>\n"
    },
    {
      "name": "Interfaces",
      "x": 480,
      "y": 140,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 50% 50%; grid-template-rows: auto 1fr; column-gap: 28px; align-items: start; font-size: 23px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 430px; }\npre { font-size: 17px; margin-top: 8px; }\nul { margin-top: 0; }\n</style>\n\n# Interfaces\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<interface id=Observer>«interface»;Observer||+ update(): void]\n```\n\n<div>\n\n- An **interface** lists methods a class promises to have - with no code, and (usually) no fields\n- Shown with the stereotype **«interface»**; the fields compartment is empty\n- A class that has those methods can say it `implements` the interface - see *Implementation*\n- In TypeScript an interface can also describe the **shape of plain data**, like `Reading`\n\n```ts\ninterface Observer {\n  update(): void;\n}\n```\n\n</div>\n"
    },
    {
      "name": "Types and modules",
      "x": 720,
      "y": 140,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 50% 50%; grid-template-rows: auto 1fr; column-gap: 28px; align-items: start; font-size: 23px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 430px; }\npre { font-size: 17px; margin-top: 8px; }\nul { margin-top: 0; }\n</style>\n\n# Other boxes: types, modules, notes\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<type id=Category>«type»;TemperatureCategory|\"HOT\" \\| \"WARM\" \\| \"COOL\" \\| \"COLD\"]\n[<module id=TC>«module»;TemperatureCategory.ts|+ categorise(celsius: number): TemperatureCategory]\n[<note>(celsius) =\\> showCategory(categorise(celsius))]\n[TC] -/- [Category]\n[Category] -/- [<note>(celsius) =\\> showCategory(categorise(celsius))]\n```\n\n<div>\n\n- **«type»**: a TypeScript `type` - here a **union** of four strings, elsewhere a **function type**\n- **«module»**: a file of functions and constants that is not a class, like `main.ts`. Not standard UML - but a common way to show a file\n- **Note**: a comment box with a folded corner. Our diagrams use notes to show **arrow functions**\n\n```ts\ntype TemperatureCategory = \"HOT\" | \"WARM\" | \"COOL\" | \"COLD\";\n```\n\n</div>\n"
    },
    {
      "name": "Inheritance",
      "x": 960,
      "y": 140,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 50% 50%; grid-template-rows: auto 1fr; column-gap: 28px; align-items: start; font-size: 23px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 430px; }\npre { font-size: 17px; margin-top: 8px; }\nul { margin-top: 0; }\n</style>\n\n# Inheritance (generalization)\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<abstract id=Subject>«abstract»;Subject]\n[TemperatureSensor|- celsius: number|+ getTemperature(): number «override»;+ setTemperature(celsius: number): void]\n[Subject] <:- [TemperatureSensor]\n```\n\n<div>\n\n- A **solid line** with a **hollow triangle** at the parent: *TemperatureSensor **is a** Subject*\n- The arrow points **from the subclass to the superclass**\n- The subclass gets all the parent's members - only **new** or **overridden** ones are drawn in its box\n- `«override»` marks a method that replaces (or provides) the parent's version\n\n```ts\nclass TemperatureSensor extends Subject {\n  public override getTemperature(): number { ... }\n}\n```\n\n</div>\n"
    },
    {
      "name": "Implementation",
      "x": 1200,
      "y": 140,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 50% 50%; grid-template-rows: auto 1fr; column-gap: 28px; align-items: start; font-size: 23px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 430px; }\npre { font-size: 17px; margin-top: 8px; }\nul { margin-top: 0; }\n</style>\n\n# Interface implementation (realization)\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<interface id=Observer>«interface»;Observer||+ update(): void]\n[CategoryObserver|...|+ update(): void]\n[JsonLogObserver|...|+ update(): void]\n[Observer] <:-- [CategoryObserver]\n[Observer] <:-- [JsonLogObserver]\n```\n\n<div>\n\n- A **dashed line** with a **hollow triangle** at the interface: *CategoryObserver **implements** Observer*\n- Like inheritance, but the dashes say only a **promise** is inherited - the methods, not their code\n- Every class that implements `Observer` must have an `update()` method\n- One interface, many classes: the Subject can treat them all the same way\n\n```ts\nclass CategoryObserver implements Observer {\n  public update(): void { ... }\n}\n```\n\n</div>\n"
    },
    {
      "name": "Association",
      "x": 0,
      "y": 280,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 50% 50%; grid-template-rows: auto 1fr; column-gap: 28px; align-items: start; font-size: 23px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 430px; }\npre { font-size: 17px; margin-top: 8px; }\nul { margin-top: 0; }\n</style>\n\n# Association: has a reference to\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[TemperatureSensor]\n[CategoryObserver|- sensor: TemperatureSensor|+ update(): void]\n[TemperatureSensor] 1 <- sensor [CategoryObserver]\n```\n\n<div>\n\n- A **solid line**: objects of one class **hold a reference** to objects of the other - usually in a field\n- The **open arrowhead** shows **navigability**: a `CategoryObserver` can reach its sensor, not the other way round\n- The label at the arrowhead end is the **role name** - the name of the field (`sensor`)\n- The number is the **multiplicity**: each `CategoryObserver` has exactly **1** sensor - see next slide\n\n```ts\nclass CategoryObserver implements Observer {\n  private sensor: TemperatureSensor;\n}\n```\n\n</div>\n"
    },
    {
      "name": "Multiplicity",
      "x": 240,
      "y": 280,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 50% 50%; grid-template-rows: auto 1fr; column-gap: 28px; align-items: start; font-size: 23px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 430px; }\npre { font-size: 17px; margin-top: 8px; }\nul { margin-top: 0; }\n</style>\n\n# Multiplicity: how many?\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<abstract id=Subject>«abstract»;Subject|- observers: Observer\\[\\]]\n[<interface id=Observer>«interface»;Observer]\n[Subject] observers -> * [Observer]\n```\n\n<div>\n\n| Written | Means |\n|---|---|\n| `1` | exactly one |\n| `0..1` | none or one (an optional field: `x?: T`, or `T \\| null`) |\n| `*` or `0..*` | any number, including none (an array) |\n| `1..*` | at least one |\n\n- Written **next to the class it counts**: each `Subject` has **`*`** (any number of) `Observer`s\n- `*` usually means an **array** field: `observers: Observer[]`\n\n</div>\n"
    },
    {
      "name": "Dependency",
      "x": 480,
      "y": 280,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 50% 50%; grid-template-rows: auto 1fr; column-gap: 28px; align-items: start; font-size: 23px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 430px; }\npre { font-size: 17px; margin-top: 8px; }\nul { margin-top: 0; }\n</style>\n\n# Dependency: uses\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[CategoryObserver|...|+ update(): void]\n[<module id=TC>«module»;TemperatureCategory.ts|+ categorise(celsius: number): TemperatureCategory]\n[<module id=main>«module»;main.ts]\n[TemperatureSensor]\n[CategoryObserver] --> [TC]\n[main] --> creates [TemperatureSensor]\n[main] --> creates [CategoryObserver]\n```\n\n<div>\n\n- A **dashed line** with an **open arrowhead**: one thing **uses** another, but doesn't keep a reference in a field\n- e.g. it calls a function, takes it as a **parameter**, or **creates** it with `new`\n- A label can say how: `creates`, `attaches`, `calls`\n- Weaker than an association: change `categorise()`, and `CategoryObserver` may need to change - but it holds no `TemperatureCategory` field\n\n```ts\nimport { categorise } from \"./TemperatureCategory.ts\";\n// ...\nconsole.log(categorise(celsius));\n```\n\n</div>\n"
    },
    {
      "name": "Cheat sheet",
      "x": 720,
      "y": 280,
      "text": "<style scoped>\nsection { font-size: 19px; }\nsvg[data-nomnoml] { max-height: 180px; }\ntable { font-size: 17px; margin: 0 auto; }\np { margin: 8px 0; }\nh1 { margin-bottom: 0; }\n</style>\n\n# Cheat sheet: the lines\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[Subclass] -:> [Superclass]\n[Class] --:> [Interface]\n[A] -> [B]\n[User] --> [Used]\n```\n\n| Line (left to right, above) | Means | TypeScript |\n|---|---|---|\n| **inheritance** - solid, hollow triangle | is a | `extends` |\n| **implementation** - dashed, hollow triangle | promises to have | `implements` |\n| **association** - solid, open arrowhead | has a reference to | a field |\n| **dependency** - dashed, open arrowhead | uses | a parameter, a call, `new` |\n\nTriangles point at the **more general** thing. Open arrowheads point at the thing that is **known** or **used**. Dashed lines are **weaker** than solid ones.\n"
    },
    {
      "name": "Reading a diagram",
      "x": 960,
      "y": 280,
      "text": "<style scoped>\nsection { display: grid; grid-template-columns: 50% 50%; grid-template-rows: auto 1fr; column-gap: 28px; align-items: start; font-size: 23px; }\nh1 { grid-column: 1 / -1; }\nsvg[data-nomnoml] { max-height: 430px; }\npre { font-size: 17px; margin-top: 8px; }\nul { margin-top: 0; }\n</style>\n\n# Putting it together: reading a diagram\n\n```nomnoml\n#direction: down\n#fill: #ffffff\n#.abstract: fill=#A6F78E title=bold,italic\n#.interface: fill=#CCFFFF title=bold\n#.type: fill=#FFFFC4 title=bold\n#.module: fill=#EEEEEE title=bold\n[<abstract id=Subject>«abstract»;Subject|- observers: Observer\\[\\]|+ attach(observer: Observer): void;+ notify(): void]\n[<interface id=Observer>«interface»;Observer||+ update(): void]\n[TemperatureSensor|- celsius: number|+ setTemperature(celsius: number): void]\n[CategoryObserver|- sensor: TemperatureSensor|+ update(): void]\n[Subject] observers -> * [Observer]\n[Subject] <:- [TemperatureSensor]\n[Observer] <:-- [CategoryObserver]\n[TemperatureSensor] 1 <- sensor [CategoryObserver]\n```\n\n<div>\n\n- Start with the **abstract** classes and **interfaces** - they are the design: `Subject` and `Observer`\n- Read each line out loud: *a Subject has any number of Observers*; *TemperatureSensor is a Subject*; *CategoryObserver implements Observer*; *a CategoryObserver has 1 sensor*\n- Then read the **public methods**: what can each object be asked to do?\n- Finally, find each class in `src/` and check the code matches the box\n\n</div>\n"
    }
  ]
}
