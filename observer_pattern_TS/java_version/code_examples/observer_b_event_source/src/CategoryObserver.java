// Observer 2: shows whether it is HOT, WARM, COOL or COLD.
// Approach B: no stored sensor - update() is given the Subject that changed.

import java.util.function.Consumer;

public class CategoryObserver implements Observer {
    private final Consumer<TemperatureCategory> show;

    /** @param show what to do with the category (Main sends it to the page; a test can just keep it) */
    public CategoryObserver(Consumer<TemperatureCategory> show) {
        this.show = show;
    }

    @Override
    public void update(Subject subject) {
        show.accept(TemperatureCategory.of(subject.getTemperature())); // the parameter says which Subject changed
    }
}
