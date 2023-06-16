public class PrimeNumber {
    int numberToCheck;
    boolean isPrime;

    public PrimeNumber(int numberToCheck) {
        this.numberToCheck = numberToCheck;
    }

    public boolean isPrimeNumber() {
        this.isPrime = true;
        for (int factor = 2; factor < numberToCheck / 2 && this.isPrime; factor++) {
            if (numberToCheck % factor == 0) {
                this.isPrime = false;
            }
        }
        return isPrime;
    }

    @Override
    public String toString() {
        return numberToCheck + ", " + 
            isPrime + ", " + 
            Thread.currentThread().toString().replace(",","_");
    }
}
