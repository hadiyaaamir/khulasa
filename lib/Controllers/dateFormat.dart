import 'dart:ffi';
import 'package:intl/intl.dart';

class DateFormatter {
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

  toDateTime(String date, bool isDateTime) {
    if (isDateTime) {
      if (date.isNotEmpty) {
        DateTime d = DateTime.parse(date);
        return DateTime(d.year, d.month, d.day);
      }
      return DateTime(2000);
    }

    //remove kachra
    RegExp remove = RegExp(r"اپ ڈیٹ", multiLine: true, caseSensitive: true);
    date = date.replaceAll(remove, '');

    remove = RegExp(r"T(.*)GMT", multiLine: true, caseSensitive: true);
    date = date.replaceAll(remove, '');

    // date = date.replaceAll(r"(\|)(.*):(.*)", '');
    remove = RegExp(r"\|(.*):(.*)", multiLine: true, caseSensitive: true);
    date = date.replaceAll(remove, '');

    date = date.trim();

    //if now in date format but string, return datetime
    RegExp dateFormat = RegExp(r"(\d{4})-(\d{2})-(\d{2})",
        multiLine: true, caseSensitive: true);

    if (dateFormat.hasMatch(date)) {
      DateTime d = DateTime.parse(date);
      return DateTime(d.year, d.month, d.day);
    }

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
    monthDate = monthDate.replaceAll(',', '');
    monthDate = monthDate.replaceAll('،', '');
    monthDate = monthDate.trim();

    //remove spaces
    int monthIndex = urduMonths.indexOf(monthDate);
    // return int.parse(dayText).toString();
    if (monthIndex != -1) {
      return DateTime(int.parse(yearText), monthIndex + 1, int.parse(dayText));
    }

    try {
      DateFormat formatter = DateFormat('yyyy-MMM-dd');
      return formatter
          .parse('${int.parse(yearText)}-${monthDate}-${int.parse(dayText)}');
    } catch (e) {
      try {
        DateFormat formatter = DateFormat('yyyy-MMMM-dd');
        return formatter
            .parse('${int.parse(yearText)}-${monthDate}-${int.parse(dayText)}');
      } catch (e) {
        // return DateTime(1990);
        return 'date: $date   year: $yearText   day: $dayText   rmaining: $monthDate';
      }
    }

    return DateTime(1999);
  }

  //format: to urdu date
  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
