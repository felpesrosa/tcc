public class PrimeNumber {
    int numberToCheck;
    int[] testedNumbers;
    boolean isPrime;

    public PrimeNumber(int numberToCheck) {
        this.numberToCheck = numberToCheck;
        this.testedNumbers = new int[numberToCheck / 2];
    }

    public boolean isPrimeNumber() {
        this.isPrime = true;
        for (int factor = 2; factor < numberToCheck / 2 && this.isPrime; factor++) {
            testedNumbers[factor - 2] = factor;
            if (numberToCheck % factor == 0) {
                this.isPrime = false;
            }
        }
        return isPrime;
    }

    private String testedNumbersToString() {
        String s = "{ ";
        for (int i : testedNumbers) {
            if(i == 0) { break; }
            s += i + " ";
        }
        s += "}";

        return s;
    }

    @Override
    public String toString() {
        return numberToCheck + ", " + 
            isPrime + ", " + 
            Thread.currentThread().toString().replace(",","_") + ", " + 
            testedNumbersToString();
    }

}
