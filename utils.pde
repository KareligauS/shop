String capitalize(String str) {
    if (str.length() < 1) throw new IllegalArgumentException("String to capilaize can't be shorter than 1 char.");
    return str.substring(0, 1).toUpperCase() + str.substring(1);
}