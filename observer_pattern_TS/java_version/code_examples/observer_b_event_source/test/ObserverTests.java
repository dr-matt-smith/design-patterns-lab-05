// Tests for the Subject and its two Observers - plain Java, no test library needed.
// A `show` lambda that just keeps what it is given stands in for the web page.
//
// Run with:  javac -d out src/*.java test/*.java  &&  java -cp out ObserverTests

import java.util.ArrayList;
import java.util.List;

public class ObserverTests {
    private static int passed = 0;
    private static int failed = 0;

    private static void check(String name, boolean ok) {
        if (ok) {
            passed++;
            System.out.println("ok - " + name);
        } else {
            failed++;
            System.out.println("not ok - " + name);
        }
    }

    /** An Observer that keeps every Subject it is sent. */
    static class RecordingObserver implements Observer {
        final List<Subject> senders = new ArrayList<>();

        @Override
        public void update(Subject subject) {
            senders.add(subject);
        }
    }

    public static void main(String[] args) {
        TemperatureSensor sensor = new TemperatureSensor();
        RecordingObserver first = new RecordingObserver();
        RecordingObserver second = new RecordingObserver();
        sensor.attach(first);
        sensor.attach(second);
        sensor.setTemperature(21);
        check("every attached Observer is sent update() when the temperature changes",
                first.senders.size() == 1 && second.senders.size() == 1);
        check("the Subject passes itself to update()", first.senders.get(0) == sensor);

        TemperatureSensor indoor = new TemperatureSensor();
        TemperatureSensor outdoor = new TemperatureSensor();
        RecordingObserver both = new RecordingObserver();
        indoor.attach(both);
        outdoor.attach(both);
        outdoor.setTemperature(3);
        indoor.setTemperature(21);
        check("one Observer can tell two Subjects apart",
                both.senders.get(0) == outdoor && both.senders.get(1) == indoor);

        sensor = new TemperatureSensor();
        RecordingObserver detached = new RecordingObserver();
        sensor.attach(detached);
        sensor.detach(detached);
        sensor.setTemperature(21);
        check("a detached Observer is not sent update()", detached.senders.isEmpty());

        sensor = new TemperatureSensor();
        List<String> json = new ArrayList<>();
        sensor.attach(new JsonLogObserver(json::add));
        sensor.setTemperature(21);
        sensor.setTemperature(27);
        check("the JSON log records every reading, in order", json.get(1).equals("[\n  { \"reading\": 1, \"celsius\": 21 },\n  { \"reading\": 2, \"celsius\": 27 }\n]"));

        sensor = new TemperatureSensor();
        List<TemperatureCategory> shown = new ArrayList<>();
        sensor.attach(new CategoryObserver(shown::add));
        sensor.setTemperature(30);
        sensor.setTemperature(-1);
        check("the category Observer shows the word for the new temperature",
                shown.equals(List.of(TemperatureCategory.HOT, TemperatureCategory.COLD)));

        check("below 15°C is COLD", TemperatureCategory.of(-1) == TemperatureCategory.COLD
                && TemperatureCategory.of(14) == TemperatureCategory.COLD);
        check("15°C to 19°C is COOL", TemperatureCategory.of(15) == TemperatureCategory.COOL
                && TemperatureCategory.of(19) == TemperatureCategory.COOL);
        check("20°C to 25°C is WARM", TemperatureCategory.of(20) == TemperatureCategory.WARM
                && TemperatureCategory.of(25) == TemperatureCategory.WARM);
        check("above 25°C is HOT", TemperatureCategory.of(26) == TemperatureCategory.HOT
                && TemperatureCategory.of(30) == TemperatureCategory.HOT);

        System.out.println(passed + " passed, " + failed + " failed");
        if (failed > 0) {
            System.exit(1);
        }
    }
}
