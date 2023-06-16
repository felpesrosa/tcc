import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class IntegerGenerator {
    public static void main(String[] args) {
        List<Integer> generatedIntegers = generateIntegers(10000, 100_000, 1_000_000);
        for (int num : generatedIntegers) {
            System.out.println("@" + num + "#");
        }
    }

    private static List<Integer> generateIntegers(int count, int min, int max) {
        List<Integer> integers = new ArrayList<>();
        Random random = new Random();
        while (integers.size() < count) {
            int num = random.nextInt(max - min + 1) + min;
            if (!isDivisibleByRange(num, 2, 9)) {
                integers.add(num);
            }
        }
        return integers;
    }

    private static boolean isDivisibleByRange(int num, int start, int end) {
        for (int i = start; i <= end; i++) {
            if (num % i == 0) {
                return true;
            }
        }
        return false;
    }
}
