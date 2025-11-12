package com.airgo.util;

import java.util.Random;

public class BookingUtil {

    public static String generateBookingReference() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder reference = new StringBuilder("AG");
        Random random = new Random();

        for (int i = 0; i < 8; i++) {
            reference.append(chars.charAt(random.nextInt(chars.length())));
        }

        return reference.toString();
    }
}
