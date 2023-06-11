import java.io.*;
import java.time.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/primeNumber")
public class PrimeNumberServlet extends HttpServlet {
    private static CSVBuilder csvBuilder;

    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        /* requisição para abrir o arquivo CSV */
        if (Boolean.parseBoolean(request.getParameter("openCSVFile"))) {
            csvBuilder = new CSVBuilder(ProcessHandle.current().pid());
            out.printf("Sent: saida  %s",Thread.currentThread().toString());
        }

        /* requisição para fechar o arquivo CSV */
        if (Boolean.parseBoolean(request.getParameter("closeCSVFile"))) {
            csvBuilder.close();
            out.printf("Sent: saida  %s",Thread.currentThread().toString());
        }

        /* requisição para descobrir se número é primo */
        if (request.getParameter("numberToCheck") != null) {
            Boolean delayedExecution = Boolean.parseBoolean(request.getParameter("delayedExecution"));

            /* Setar as informações do número a ser verificado com dados da URI */
            PrimeNumber numberToCheck = new PrimeNumber(
                Integer.parseInt(request.getParameter("numberToCheck"))
            );

            /* cálculo para descobrir se o número é primo */
            numberToCheck.isPrimeNumber();

            /* escrita no arquivo CSV */
            String csvLine = request.getRequestURI() + ", " + numberToCheck.toString();
            csvBuilder.writeCSV(csvLine, delayedExecution);

            /* resposta da Requisição HTTP */
            String result = numberToCheck.isPrime ? "a prime number." : "not a prime number.";
            String responseText = "The number " + numberToCheck.numberToCheck + " is " + result;
            
            out.println("\n Response: ");
            out.println(responseText);
            out.println("\n CSV data: ");
            out.println(csvLine);
        }
    }
}
