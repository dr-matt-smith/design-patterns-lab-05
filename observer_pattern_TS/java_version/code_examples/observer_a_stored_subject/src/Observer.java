// The Observer interface (Approach A): update() has NO parameters.
// Each Observer keeps its own reference to the Subject, and asks it for the new state.

public interface Observer {
    /** Called by the Subject whenever its state changes. */
    void update();
}
