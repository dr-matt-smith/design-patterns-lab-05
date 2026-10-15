// The Subject: keeps a list of Observers, and sends each one an update() message when it changes.
// It knows nothing about temperatures - TemperatureSensor (a concrete Subject) adds those.

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

    /** Sends update() to every attached Observer. (Not called notify(): Java's Object.notify() is final.) */
    public void notifyObservers() {
        for (Observer observer : observers) {
            observer.update();
        }
    }
}
