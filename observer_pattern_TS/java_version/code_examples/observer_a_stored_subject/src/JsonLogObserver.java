// Observer 1: keeps a log of every temperature reading, and shows the whole log as JSON.
// Approach A: it stores a reference to the sensor it observes, and asks it for the temperature in update().

import java.util.ArrayList;
import java.util.List;
import java.util.function.Consumer;

// final: the constructor passes `this` to attach(), so no subclass may run code before that.
public final class JsonLogObserver implements Observer {
    private final TemperatureSensor sensor;
    private final Consumer<String> show;
    private final List<Integer> readings = new ArrayList<>();

    /**
     * @param sensor the Subject to observe - stored, so update() can ask it for the temperature
     * @param show   what to do with the JSON (Main sends it to the page; a test can just keep it)
     */
    public JsonLogObserver(TemperatureSensor sensor, Consumer<String> show) {
        this.sensor = sensor;
        this.show = show;
        sensor.attach(this);
    }

    @Override
    public void update() {
        readings.add(sensor.getTemperature()); // pull the new state from the stored Subject
        show.accept(toJson());
    }

    /** The whole log, as JSON - one reading per line. */
    public String toJson() {
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < readings.size(); i++) {
            json.append(i == 0 ? "\n" : ",\n");
            json.append("  { \"reading\": ").append(i + 1).append(", \"celsius\": ").append(readings.get(i)).append(" }");
        }
        return json.append(readings.isEmpty() ? "]" : "\n]").toString();
    }
}
