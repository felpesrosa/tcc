import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class CSVBuilder {
    static PrintWriter logPrinter;
    private static Lock lock = new ReentrantLock();

    public CSVBuilder(Long pid) throws IOException {
                
        String logFileName = "/tmp/reports/log-PID_" 
                + pid 
                + "_" + new Date().toString().replace(" ","_")
                + ".csv";

        File logFile = new File(logFileName);
        FileWriter fileWriter = new FileWriter(logFile);
        logPrinter = new PrintWriter(fileWriter);

        logPrinter.println("Request URI, Número a verificar, Primo?, ThreadInfo, Sequência testada, Execução atrasada?"); // colunas do .CSV
    }

    static public void writeCSV(String logMessage, boolean delayedExecution) {
        lock.lock();
            if (delayedExecution) {
                try {
                    Thread.sleep(500);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }

            logPrinter.println(logMessage + ", " + delayedExecution);
        lock.unlock();
    }

    static public void close() {
        logPrinter.close();
    }
}