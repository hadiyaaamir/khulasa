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

//ratios
double short = 0.2;
double medium = 0.4;
double long = 0.7;

getRatio(String size) {
  if (size == "Short") {
    return short;
  } else if (size == "Medium") {
    return medium;
  } else if (size == "Long") {
    return long;
  }
}
