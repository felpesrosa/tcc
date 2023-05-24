import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.util.Date;
import java.util.concurrent.ThreadFactory;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

public class ThreadedServer {
    static CSVBuilder csvBuilder;

    static HttpServer configServer;
    static HttpServer platformThreadsServer;
    static HttpServer singleThreadServer;
    static HttpServer cachedThreadsServer;
    static HttpServer virtualThreadsServer;

    public static void main(String[] args) throws Exception {
        csvBuilder = new CSVBuilder(ProcessHandle.current().pid());

        configServer = HttpServer.create(new InetSocketAddress(7999), 0);
        configServer.createContext("/config", new ConfigServerHandler());
        configServer.setExecutor(java.util.concurrent.Executors.newVirtualThreadPerTaskExecutor());
        configServer.start();

        platformThreadsServer = HttpServer.create(new InetSocketAddress(8000), 0);
        platformThreadsServer.createContext("/withPlatformThreads", new PlatformThreadsHandler());
        platformThreadsServer.setExecutor(java.util.concurrent.Executors.newThreadPerTaskExecutor(new SimpleThreadFactory()));
        platformThreadsServer.start();

        singleThreadServer = HttpServer.create(new InetSocketAddress(8001), 0);
        singleThreadServer.createContext("/withSingleThread", new SingleThreadHandler());
        singleThreadServer.setExecutor(java.util.concurrent.Executors.newSingleThreadExecutor());
        singleThreadServer.start();

        cachedThreadsServer = HttpServer.create(new InetSocketAddress(8002), 0);
        cachedThreadsServer.createContext("/withCachedThreads", new CachedThreadsHandler());
        cachedThreadsServer.setExecutor(java.util.concurrent.Executors.newCachedThreadPool());
        cachedThreadsServer.start();

        virtualThreadsServer = HttpServer.create(new InetSocketAddress(8003), 0);
        virtualThreadsServer.createContext("/withVirtualThreads", new VirtualThreadsHandler());
        virtualThreadsServer.setExecutor(java.util.concurrent.Executors.newVirtualThreadPerTaskExecutor());
        virtualThreadsServer.start();
    }

    static class ConfigServerHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange t) throws IOException {
            String requestQuery = t.getRequestURI().getQuery();

            if (requestQuery.contains("closeServer")) {
                String response = "Closing the server!";
                t.sendResponseHeaders(200, response.length());
                OutputStream os = t.getResponseBody();
                os.write(response.getBytes());
                os.close();

                csvBuilder.close();

                cachedThreadsServer.stop(0);
                platformThreadsServer.stop(0);
                singleThreadServer.stop(0);
                virtualThreadsServer.stop(0);
                configServer.stop(0);

                System.out.println("\n ------------------- servers closed -------------------");
                System.out.println(" ------ log: " + new Date() + " -------------\n");

                System.exit(0);
            }            
        }
    }

    static class PlatformThreadsHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange t) throws IOException {
            String[] requestURI = t.getRequestURI().toString().split("/");

            /* Setar as informações do número a ser verificado com dados da URI */
            PrimeNumber numberToCheck = new PrimeNumber(Integer.parseInt(requestURI[2]));

            try {
                Thread.currentThread().sleep(250);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            String response = "The number " + numberToCheck.numberToCheck + " is ";
            String result = numberToCheck.isPrime ? "a prime number." : "not a prime number.";
            response = response + result;

            String csvLine = t.getRequestURI().toString() + ", " + numberToCheck.toString();
            csvBuilder.writeCSV(csvLine);

            t.sendResponseHeaders(200, response.length());
            OutputStream os = t.getResponseBody();
            os.write(response.getBytes());
            os.close();
        }
    }

    static class SingleThreadHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange t) throws IOException {
            String[] requestURI = t.getRequestURI().toString().split("/");

            /* Setar as informações do número a ser verificado com dados da URI */
            PrimeNumber numberToCheck = new PrimeNumber(Integer.parseInt(requestURI[2]));

            try {
                Thread.currentThread().sleep(250);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            String response = "The number " + numberToCheck.numberToCheck + " is ";
            String result = numberToCheck.isPrime ? "a prime number." : "not a prime number.";
            response = response + result;

            String csvLine = t.getRequestURI().toString() + ", " + numberToCheck.toString();
            csvBuilder.writeCSV(csvLine);

            t.sendResponseHeaders(200, response.length());
            OutputStream os = t.getResponseBody();
            os.write(response.getBytes());
            os.close();
        }
    }

    static class CachedThreadsHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange t) throws IOException {
            String[] requestURI = t.getRequestURI().toString().split("/");

            /* Setar as informações do número a ser verificado com dados da URI */
            PrimeNumber numberToCheck = new PrimeNumber(Integer.parseInt(requestURI[2]));

            try {
                Thread.currentThread().sleep(250);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            String response = "The number " + numberToCheck.numberToCheck + " is ";
            String result = numberToCheck.isPrime ? "a prime number." : "not a prime number.";
            response = response + result;

            String csvLine = t.getRequestURI().toString() + ", " + numberToCheck.toString();
            csvBuilder.writeCSV(csvLine);

            t.sendResponseHeaders(200, response.length());
            OutputStream os = t.getResponseBody();
            os.write(response.getBytes());
            os.close();
        }
    }

    static class VirtualThreadsHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange t) throws IOException {
            String[] requestURI = t.getRequestURI().toString().split("/");

            /* Setar as informações do número a ser verificado com dados da URI */
            PrimeNumber numberToCheck = new PrimeNumber(Integer.parseInt(requestURI[2]));

            try {
                Thread.currentThread().sleep(250);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            String response = "The number " + numberToCheck.numberToCheck + " is ";
            String result = numberToCheck.isPrime ? "a prime number." : "not a prime number.";
            response = response + result;

            String csvLine = t.getRequestURI().toString() + ", " + numberToCheck.toString();
            csvBuilder.writeCSV(csvLine);

            t.sendResponseHeaders(200, response.length());
            OutputStream os = t.getResponseBody();
            os.write(response.getBytes());
            os.close();
        }
    }

    static class SimpleThreadFactory implements ThreadFactory {
        public Thread newThread(Runnable r) {
            return new Thread(r);
        }
    }

}
