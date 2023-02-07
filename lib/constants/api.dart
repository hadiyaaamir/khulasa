String apiUrl = "https://khulasa.pythonanywhere.com";

//summary
String summaryType1 = "summa";
String summaryType2 = "apna";

String summaryChoice1 = "Summa Summariser";
String summaryChoice2 = "Khulasa Summariser";

getAlgorithm(String selected) {
  if (selected == summaryChoice1) {
    return summaryType1;
  } else if (selected == summaryChoice2) {
    return summaryType2;
  }
}
