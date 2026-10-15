// The entry point: makes the Subject (a temperature sensor) and its two Observers, and serves the web page.
// The page's buttons send the chosen temperature here; the Observers' latest output is sent back to the page.
//
// The web server is the JDK's own com.sun.net.httpserver - no libraries to download.

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpServer;
import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Map;

public class Main {
    private static final int PORT = 8080;

    // The files the page is made of, and their content types.
    private static final Map<String, String> PAGE_FILES = Map.of(
            "/index.html", "text/html",
            "/styles.css", "text/css",
            "/app.js", "text/javascript");

    // What each Observer last showed - sent to the page after every click.
    private static String jsonText = "[]";
    private static String categoryText = "-";

    public static void main(String[] args) throws IOException {
        TemperatureSensor sensor = new TemperatureSensor();

        // Approach A: each Observer is given the sensor, stores it, and attaches itself in its constructor.
        new JsonLogObserver(sensor, json -> jsonText = json);
        new CategoryObserver(sensor, category -> categoryText = category.name());

        HttpServer server = HttpServer.create(new InetSocketAddress(PORT), 0);
        // A button on the page asks for /temperature?celsius=21 - this changes the Subject.
        server.createContext("/temperature", exchange -> {
            String query = exchange.getRequestURI().getQuery(); // e.g. "celsius=21"
            try {
                sensor.setTemperature(Integer.parseInt(query.replace("celsius=", "")));
            } catch (NumberFormatException | NullPointerException e) {
                send(exchange, 400, "text/plain", "Expected /temperature?celsius=<whole number>");
                return;
            }
            sendOutputs(exchange);
        });
        server.createContext("/outputs", Main::sendOutputs);
        server.createContext("/", Main::sendPageFile);
        server.start();
        System.out.println("Open http://localhost:" + PORT + " in a browser (Ctrl+C to stop)");
    }

    /** Sends both Observers' latest output to the page, as JSON: {"json": "...", "category": "WARM"}. */
    private static void sendOutputs(HttpExchange exchange) throws IOException {
        String body = "{\"json\": " + quote(jsonText) + ", \"category\": " + quote(categoryText) + "}";
        send(exchange, 200, "application/json", body);
    }

    /** Sends index.html, styles.css or app.js from the public/ folder. */
    private static void sendPageFile(HttpExchange exchange) throws IOException {
        String path = exchange.getRequestURI().getPath();
        if (path.equals("/")) {
            path = "/index.html";
        }
        if (!PAGE_FILES.containsKey(path)) {
            send(exchange, 404, "text/plain", "Not found: " + path);
            return;
        }
        String file = Files.readString(Path.of("public" + path));
        send(exchange, 200, PAGE_FILES.get(path), file);
    }

    private static void send(HttpExchange exchange, int status, String type, String body) throws IOException {
        byte[] bytes = body.getBytes(StandardCharsets.UTF_8);
        exchange.getResponseHeaders().set("Content-Type", type + "; charset=utf-8");
        exchange.sendResponseHeaders(status, bytes.length);
        exchange.getResponseBody().write(bytes);
        exchange.close();
    }

    /** `text` as a JSON string: in quotes, with quotes, backslashes and new lines escaped. */
    private static String quote(String text) {
        return "\"" + text.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n") + "\"";
    }
}
