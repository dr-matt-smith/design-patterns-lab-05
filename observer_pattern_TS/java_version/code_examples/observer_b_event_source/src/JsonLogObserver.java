// Observer 1: keeps a log of every temperature reading, and shows the whole log as JSON.
// Approach B: no stored sensor - update() is given the Subject that changed.

import java.util.ArrayList;
import java.util.List;
import java.util.function.Consumer;

public class JsonLogObserver implements Observer {
    private final Consumer<String> show;
    private final List<Integer> readings = new ArrayList<>();

    /** @param show what to do with the JSON (Main sends it to the page; a test can just keep it) */
    public JsonLogObserver(Consumer<String> show) {
        this.show = show;
    }

    @Override
    public void update(Subject subject) {
        readings.add(subject.getTemperature()); // the parameter says which Subject changed
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
