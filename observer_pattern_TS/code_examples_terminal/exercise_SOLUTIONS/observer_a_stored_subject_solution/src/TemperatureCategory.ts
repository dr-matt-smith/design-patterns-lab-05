// Turns a temperature into one of four words.

export type TemperatureCategory = "HOT" | "WARM" | "COOL" | "COLD";

const HOT_ABOVE = 25; // above 25°C is HOT
const WARM_FROM = 20; // 20°C to 25°C is WARM
const COOL_FROM = 15; // 15°C to 19°C is COOL - and anything below 15°C is COLD

/** The category word for a temperature in °C. */
export const categorise = (celsius: number): TemperatureCategory => {
  if (celsius > HOT_ABOVE) {
    return "HOT";
  }
  if (celsius >= WARM_FROM) {
    return "WARM";
  }
  if (celsius >= COOL_FROM) {
    return "COOL";
  }
  return "COLD";
};
