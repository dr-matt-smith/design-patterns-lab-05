// Observer 2: shows whether it is HOT, WARM, COOL or COLD.
// Approach A: it stores a reference to the sensor it observes, and asks it for the temperature in update().

import java.util.function.Consumer;

// final: the constructor passes `this` to attach(), so no subclass may run code before that.
public final class CategoryObserver implements Observer {
    private final TemperatureSensor sensor;
    private final Consumer<TemperatureCategory> show;

    /**
     * @param sensor the Subject to observe - stored, so update() can ask it for the temperature
     * @param show   what to do with the category (Main sends it to the page; a test can just keep it)
     */
    public CategoryObserver(TemperatureSensor sensor, Consumer<TemperatureCategory> show) {
        this.sensor = sensor;
        this.show = show;
        sensor.attach(this);
    }

    @Override
    public void update() {
        show.accept(TemperatureCategory.of(sensor.getTemperature())); // pull the new state from the stored Subject
    }
}
