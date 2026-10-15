// Tests for categorise(): one test for each edge of each band.

import { assertEquals } from "@std/assert";
import { categorise } from "../src/TemperatureCategory.ts";

Deno.test("below 15°C is COLD", () => {
  assertEquals(categorise(-1), "COLD");
  assertEquals(categorise(14), "COLD");
});

Deno.test("15°C to 19°C is COOL", () => {
  assertEquals(categorise(15), "COOL");
  assertEquals(categorise(19), "COOL");
});

Deno.test("20°C to 25°C is WARM", () => {
  assertEquals(categorise(20), "WARM");
  assertEquals(categorise(25), "WARM");
});

Deno.test("above 25°C is HOT", () => {
  assertEquals(categorise(26), "HOT");
  assertEquals(categorise(30), "HOT");
});
