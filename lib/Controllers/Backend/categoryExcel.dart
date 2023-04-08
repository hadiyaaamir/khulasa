import 'dart:io';

import 'package:khulasa/Models/article.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class CategoryExcel {
  toExcel(List articles) async {
    final Workbook workbook = Workbook();

    //Accessing via index
    final Worksheet sheet = workbook.worksheets[0];

    //List of data to import data.
    final List<ExcelDataRow> dataRows = getExcelRows(articles);
    print('got rows: ${dataRows.length}');
    // List<ExcelDataRow> dataRows_1 = await Future.value(dataRows);

    //Import the list to Sheet.
    sheet.importData(dataRows, 1, 1);

    //Auto-Fit columns.
    sheet.getRangeByName('A1:E1').autoFitColumns();

    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();

    //Dispose the document.
    workbook.dispose();

    //Get the storage folder location using path_provider package.
    print('getting directory');
    final Directory? directory = await getExternalStorageDirectory();
    print('got directory');
    final String path = directory!.path;

    print(path);

    final File file = File('$path/Categories${DateTime.now()}.xlsx');
    await file.writeAsBytes(bytes, flush: true);

    print('Excel saved!');

    //Launch the file (used open_file package)
    // await OpenFile.open('$path/ImportData.xlsx');
  }

  List<ExcelDataRow> getExcelRows(List articles) {
    List<ExcelDataRow> rows = [];

    for (var art in articles) {
      rows.add(
        ExcelDataRow(
          cells: [
            ExcelDataCell(columnHeader: 'title', value: art.title),
            ExcelDataCell(columnHeader: 'link', value: art.link!.link),
            ExcelDataCell(columnHeader: 'category', value: art.category),
          ],
        ),
      );
      // print('added row ${art.title}');
    }

    return rows;
  }
}
