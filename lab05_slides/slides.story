{
  "name": "Chapter 1 - Introduction: TypeScript, Deno and Celbridge",
  "description": "Object-oriented TypeScript, test first - teacher slides for Chapter 1",
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
      "name": "Week 5 - Lab",
      "x": 0,
      "y": 0,
      "text": "![bg fit](./images/logo_bg.png)\n# Week 5 - Lab\n\n\nExercise 5-1: Software setup: **deno**\n\nExercise 5-2: Software setup: Celbridge v1.4\n\nExercise 5-3: Download the Lab 5 project\n\nExercise 5-4: Hello World (terminal)\n\nExercise 5-5: Hello World (web)\n\nExercise 5-6:  explopre TS Observer pattern resources\n\n"
    },
    {
      "name": "Ex5-1: Install deno",
      "x": 960,
      "y": 0,
      "text": "\n![bg fit](./images/logo_bg.png)\n\n# Exercise 5-1: Software setup: **deno**\n\nhttps://docs.deno.com/\n\n\n1. Open a **Windows Powershell** terminal\n\n2. Run: `irm https://deno.land/install.ps1 | iex`\n\n3. Close the **Windows Powershell** terminal\n\n4. Open a new **Windows Powershell** terminal\n\n5. test with `deno -v`\n\n```bash\n> deno -v\ndeno 2.9.6\n```\n\n"
    },
    {
      "name": "screenshot - Install deno",
      "x": 1200,
      "y": 0,
      "text": "\n\n![bg fit](images/deno_install.webp)\n\n\n"
    },
    {
      "name": "Ex5-2: Install Celbridge v1.4",
      "x": 240,
      "y": 0,
      "text": "![bg fit](./images/logo_bg.png)\n\n# Exercise 5-2: Software setup: Celbridge v1.4\n\nDownload Celbridge **v1.4** <<<<\n- (improved for Typescript)\n\nhttps://celbridge.org/download/\n\n"
    },
    {
      "name": "screenshot - Download Celbridge",
      "x": 480,
      "y": 0,
      "text": "\n\n![bg fit](images/cb_download.webp)\n\n\n"
    },
    {
      "name": "Ex5-3: Download lab05 repo from Github",
      "x": 0,
      "y": 140,
      "text": "![bg fit](./images/logo_bg.png)\n\n# Exercise 5-3: Download the Lab 5 Github project\n\nDownload and unzip the GitHub for week 05:\nhttps://github.com/dr-matt-smith/design-patterns-lab-05\n\n![refresh time](images/week05_repo.webp)"
    },
    {
      "name": "Ex5-4: Hello World - terminal",
      "x": 240,
      "y": 140,
      "text": "![bg fit](./images/logo_bg.png)\n\n# Exercise 5-3: Hello World (terminal)\n\n- Create a copy of Celbridge project `template_TS_terminal`\n\n- look through the code\n- update for `firstName` and `surname` properties\nupdate `main.ts` to input both names\n- add a few more tests\n\nYou should be happy with running and testing a TypeScript project with deno\n- and declaring and using simple classes in TypeScript"
    },
    {
      "name": "terminal - hello matt",
      "x": 480,
      "y": 140,
      "text": "\n![](images/hello_matt_terminal.webp)\nhttp://127.0.0.1:51595/project/images/hello_matt_terminal.webp"
    },
    {
      "name": "Test-driven development",
      "x": 960,
      "y": 420,
      "text": "# Test-driven development\n\nTry writing a test first\n- for `Person.set/getSurname()`\n\nget your RED errors\n\nthen write code to pass the test ...\n\n```mermaid\nflowchart LR\n  R([\"<b>RED</b><br/>write a test for what you<br/>want next - watch it fail\"]) --> G([\"<b>GREEN</b><br/>write just enough code<br/>to make every test pass\"]) --> F([\"<b>REFACTOR</b><br/>tidy the code up - the tests<br/>check you broke nothing\"])\n  F -- \"round again, one small step at a time\" --> R\n  classDef red fill:#e63946,stroke:#e63946,color:#fff\n  classDef green fill:#2a9d8f,stroke:#2a9d8f,color:#fff\n  classDef blue fill:#457b9d,stroke:#457b9d,color:#fff\n  class R red\n  class G green\n  class F blue\n```\n\n"
    },
    {
      "name": "log object properties",
      "x": 200,
      "y": 280,
      "text": "![bg fit](./images/logo_bg.png)\n\n# `console.log(person1)`\n\nthis does **not** call `.toString()` on the object\n\nit dumps out the object properties as JSON:\n\n```typescript\n// add after greeting code\nconsole.log(person1);\n```\n\n```bash\n% deno run src/main.ts\nWhat is your name? fred\nNice to meet you, fred!\n\nPerson { name: \"fred\" }\n```\n\nhandy for debugging OO code ..."
    },
    {
      "name": "Ex5-5: Hello World - web",
      "x": 720,
      "y": 140,
      "text": "![bg fit](./images/logo_bg.png)\n\n# Exercise 5-5: Hello World (web)\n\n- Create a copy of Celbridge project `template_TS_web`\n\n- look through the code\n- update for `firstName` and `surname` properties\nupdate `main.ts` to input both names\n- add a few more tests\n\nYou should be happy with running and testing a TypeScript web project"
    },
    {
      "name": "A bulleted list",
      "x": 720,
      "y": 560,
      "text": "# try adding a bulleted list to your web project\n\n```ts\n// needs a <ul> in the HTML code with ID #planets\nconst list = document.querySelector(\"#planets\");\n\nconst PLANETS: string[] = [\"Mercury\", \"Venus\", \"Earth\", \"Mars\"];\n\nfor (const planet of PLANETS) {\n  const item = document.createElement(\"li\");\n  item.textContent = planet;\n\n  // add an <li> element to the list with current planet name\n  list.appendChild(item);\n}\n```\n\n- `for ... of` - not `for ... in`\n- `.length` - no brackets\n"
    },
    {
      "name": "Ex5-6: explore objserver pattern",
      "x": -100,
      "y": 420,
      "text": "![bg fit](./images/logo_bg.png)\n\n#Exercise 5-6:  explopre TS Observer pattern resources\n\nExplore the contents of folder \n`observer_pattern_TS`\n\n\n\n![](images/observer_pattern_resources.webp)"
    }
  ]
}
