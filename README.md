# Design Patterns - Lab 05

TypeScript, Deno and Celbridge, and the Observer pattern.

| Folder | What's in it |
|---|---|
| [`lab05_slides`](lab05_slides/) | The lab slides (a Celbridge `slides.story`, and `slides.pdf`) |
| [`template_TS_terminal`](template_TS_terminal/) | A simple terminal TypeScript project to start from: a `Person` class, with tests |
| [`observer_pattern_TS`](observer_pattern_TS/) | The Observer pattern: notes and UML diagrams for three approaches, with example projects |

In `observer_pattern_TS`:

- [`1_ObserverPatternOverview.md`](observer_pattern_TS/1_ObserverPatternOverview.md) - start here
- `code_examples_terminal/` - simple terminal projects (run with `deno run src/main.ts`), and `exercise_SOLUTIONS/`
- `code_examples_web/` - browser projects, with a button for each temperature
- `java_version/` - the same material in Java, for reference

## Running the projects

You need [Deno](https://docs.deno.com/). Each project's own README says how to run it and its tests. The web projects
build into `dist/` - run `deno task build` (or open the project in Celbridge) before opening `dist/index.html`.
