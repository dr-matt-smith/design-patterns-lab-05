// The Subject: keeps a list of Observers, and sends each one an update(this) message when it changes.
// Approach B: it passes ITSELF to update(), so the Observers don't need to store a reference to it.

import java.util.ArrayList;
import java.util.List;

public abstract class Subject {
    private final List<Observer> observers = new ArrayList<>();

    /** Starts sending update() messages to `observer`. */
    public void attach(Observer observer) {
        observers.add(observer);
    }

    /** Stops sending update() messages to `observer`. */
    public void detach(Observer observer) {
        observers.remove(observer);
    }

    /** Sends update(this) to every attached Observer. (Not called notify(): Java's Object.notify() is final.) */
    public void notifyObservers() {
        for (Observer observer : observers) {
            observer.update(this); // pass a reference to myself
        }
    }

    /** Declared here, so an Observer can call getTemperature() on ANY Subject it is given. */
    public abstract int getTemperature();
}
