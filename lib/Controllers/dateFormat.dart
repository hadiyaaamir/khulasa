import 'dart:ffi';

class DateFormat {
  List<String> urduMonths = [
    'جنوری',
    'فروری',
    'مارچ',
    'اپریل',
    'مئی',
    'جون',
    'جولائی',
    'اگست',
    'ستمبر',
    'اکتوبر',
    'نومبر',
    'دسمبر',
  ];

  toDateTime(String date) {
    RegExp remove = RegExp(r"اپ ڈیٹ", multiLine: true, caseSensitive: true);
    date = date.replaceAll(remove, '');

    //extract year
    RegExp expYear = RegExp(r"\d{4}", multiLine: true, caseSensitive: true);
    var year = expYear.firstMatch(date);
    String yearText = "2000";
    if (year != null) {
      yearText = year.group(0).toString();
    }
    String noYearDate = date.replaceAll(expYear, ''); //remove year from date

    //extract day
    RegExp expDay = RegExp(r"\d{2}", multiLine: true, caseSensitive: true);
    var day = expDay.firstMatch(noYearDate);
    String dayText = "00";
    if (day != null) {
      dayText = day.group(0).toString();
    }
    String monthDate = date.replaceAll(expDay, ''); //remove year from date

    //remove spaces
    String month = monthDate.replaceAll(RegExp(r"( )"), '');
    int monthIndex = urduMonths.indexOf(month);
    // return int.parse(dayText).toString();
    return DateTime(int.parse(yearText), monthIndex + 1, int.parse(dayText));
  }

  //format: to urdu date
  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
