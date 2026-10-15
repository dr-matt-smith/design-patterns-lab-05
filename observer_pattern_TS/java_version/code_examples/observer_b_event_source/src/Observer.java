// The Observer interface (Approach B): update() is given the Subject that changed.

public interface Observer {
    /** Called by `subject` whenever its state changes. */
    void update(Subject subject);
}
