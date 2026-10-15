// Turns a temperature into one of four words.

public enum TemperatureCategory {
    HOT, WARM, COOL, COLD;

    private static final int HOT_ABOVE = 25; // above 25°C is HOT
    private static final int WARM_FROM = 20; // 20°C to 25°C is WARM
    private static final int COOL_FROM = 15; // 15°C to 19°C is COOL - and anything below 15°C is COLD

    /** The category for a temperature in °C. */
    public static TemperatureCategory of(int celsius) {
        if (celsius > HOT_ABOVE) {
            return HOT;
        }
        if (celsius >= WARM_FROM) {
            return WARM;
        }
        if (celsius >= COOL_FROM) {
            return COOL;
        }
        return COLD;
    }
}
