import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:khulasa/Models/summary.dart';
import 'package:khulasa/constants/api.dart';

class ApiCall extends StatefulWidget {
  const ApiCall({super.key});

  @override
  State<ApiCall> createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {
  String text = "No Text";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            ElevatedButton(
                onPressed: () async {
                  text = await fetchData();
                  setState(() {});
                },
                child: Text("Call API"))
          ],
        ),
      ),
    );
  }

  Future<String> fetchData() async {
    var url = Uri.parse("$apiUrl/api");
    var response = await http.post(url,
        body: jsonEncode(<String, dynamic>{
          'text':
              """پاکستانی نژاد امریکی گلوکارہ عروج آفتاب نے موسیقی کے سب سے بڑے ایوارڈ گریمی کی تقریب میں پرفارم کرکے مداحوں کے دل جیت لیے تاہم وہ اس بار دوسرا گریمی ایوارڈ حاصل کرنے میں ناکام رہیں۔

واضح رہے کہ عروج آفتاب گزشتہ سال گریمی ایوارڈ کے لیے مسلسل دوسری بار نامزد ہوئی تھیں، وہ پہلی پاکستانی گلوکارہ ہیں جو مسلسل دوسرے سال ایوارڈ کے لیے نامزد ہوئی تھی، عروج آفتاب کا گانا ’ادھیڑو نہ‘ گریمی ایوارڈ کے لیے نامزد ہوا تھا۔

غیر ملکی خبررساں ادارے رائٹرز کی رپورٹ کے مطابق گزشتہ رات لاس اینجلس میں گریمی ایوارڈز 2023 کی تقریب منعقد ہوئی جس میں کئی فنکاروں کو ایوارڈ سے نوازا گیا۔

پاکستانی نژاد امریکی گلوکارہ عروج آفتاب دوسرا گریمی ایوارڈ حاصل نہ کرسکیں لیکن گریمی ایوارڈز کی رنگا رنگ تقریب میں عروج آفتاب نے اپنی ساتھی گلوکارہ انوشکا شنکر کے ہمراہ پہلی بار اردو گیت ’ادھیڑو نا‘ پیش کرکے سب کے دل جیت لیے۔

""",
          'algo': summary_type1,
          'ratio': 0.8
        }));

    final parsed = jsonDecode(response.body);
    Summary s = Summary.fromJson(parsed as Map<String, dynamic>);
    return s.summary;
    // return
  }
}
