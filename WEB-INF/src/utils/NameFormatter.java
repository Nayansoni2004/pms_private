package utils;

public class NameFormatter {
    // this class converts the user full name into firstname & also make first character in upper case of first name
    public static String getFormattedFirstName(String fullName) {
        if (fullName == null || fullName.isEmpty()) {
            return "";
        }
        String[] parts = fullName.trim().split(" ");
        String firstName = parts[0];
        return firstName.substring(0, 1).toUpperCase() + firstName.substring(1);
    }
}
