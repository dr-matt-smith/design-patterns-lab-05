// The concrete Subject: a temperature sensor. It calls notifyObservers() whenever its temperature changes.

public class TemperatureSensor extends Subject {
    private int celsius = 20;

    /** The current temperature, in °C. */
    public int getTemperature() {
        return celsius;
    }

    /** Changes the temperature, then tells every attached Observer. */
    public void setTemperature(int celsius) {
        this.celsius = celsius;
        notifyObservers();
    }
}
