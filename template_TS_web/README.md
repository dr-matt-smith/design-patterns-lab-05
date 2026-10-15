# simple web Celbridge project

The web version of [`template_TS_terminal`](../template_TS_terminal/README.md): a page that asks for your name, stores it
in a **Person** object (from the `Person.ts` class), and greets you.

## Running it

Open the project in Celbridge. The console at the bottom starts by itself, and runs `deno task dev`:

1. **builds** `src/` (TypeScript) and `public/` (HTML, CSS) into `dist/`
2. **tests** everything in `tests/`, and writes a readable report to `test_output/index.html`
3. **watches** - every time you save a file in `src/`, `public/` or `tests/`, it does it all again

`dist/index.html` opens beside the console. After a rebuild, press its **refresh** button to see your changes.

Without Celbridge, in a terminal in this folder:

```bash
deno task build
```

then open `dist/index.html` in a browser. To run just the tests:

```bash
deno task test
```

## What to look at

- `src/Person.ts` - the `Person` class (the same as in `template_TS_terminal`)
- `src/main.ts` - the entry point, and the only file that touches the page
- `public/index.html` - the page: a form with a text box and a **Greet** button
- `tests/Person.test.ts` - the tests for `setName()` and `getName()`
