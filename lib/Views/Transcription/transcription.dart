import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/transcript.dart';
import 'package:khulasa/Views/Entrance/homePage.dart';
import 'package:khulasa/Views/Transcription/generatedTranscription.dart';
import 'package:khulasa/Views/Widgets/NavBar/AppBarPage.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:khulasa/Views/Widgets/button.dart';
import 'package:khulasa/Views/Widgets/textfield.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

class Transcription extends StatefulWidget {
  const Transcription({super.key});

  @override
  State<Transcription> createState() => _TranscriptionState();
}

class _TranscriptionState extends State<Transcription> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController linkController = TextEditingController();

  Transcript transcript = Transcript(transcription: "", summary: "");

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;

    return WillPopScope(
      onWillPop: () async =>
          Navigation().navigationReplace(context, const HomePage()),
      child: Directionality(
        textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: CustomAppBar(title: isEnglish ? 'Transcription' : "تحریر"),
          drawer: const Drawer(child: Draw()),
          backgroundColor: colors.background,
          body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    children: [
                      textField(
                        label: isEnglish ? "Youtube Link" : 'اردو',
                        controller: linkController,
                        lines: 1,
                      ),
                      Btn(
                        label: isEnglish ? "Attach file" : 'اردو',
                        background: colors.secondary,
                        height: 30,
                        width: 130,
                        icon: Icons.attach_file,
                        paddingVert: 0,
                        align: Alignment.centerRight,
                        font: largerSmallFont,
                        onPress: () {},
                      ),
                      Btn(
                        label: isEnglish ? "TRANSCRIBE" : 'اردو',
                        onPress: () async {
                          final FormState form =
                              _formKey.currentState as FormState;
                          if (form.validate()) {
                            //call transcription function here

                            //temp hardcode
                            transcript.transcription =
                                """یوکرینی فوج کے ایک کمانڈر کی جانب سے انھیں ملنے والے پاکستانی اسلحے کے ’غیرمعیاری‘ ہونے کے دعوے کے بعد ایک مرتبہ پھر یہ بحث چھڑ گئی ہے کہ آیا پاکستان یوکرین میں روسی فوج سے برسرپیکار فوجیوں کو اسلحہ دے رہا ہے یا نہیں۔

پاکستان کے دفتر خارجہ نے ایک بار پھر روس، یوکرین جنگ میں یوکرین کو اسلحہ فراہم کرنے کے دعوؤں کو مسترد کیا ہے۔

یوکرین فوج کی 17 ٹینک بٹالین کے کمانڈر ولودیمیر نے بی بی سی کے دفاعی نامہ نگار جوناتھن بیل سے بات کرتے ہوئے دعویٰ کیا کہ یوکرین اپنا گریڈ ایمونیشن ختم کر چکا ہے اس لیے اب دوسرے ممالک سے حاصل ہونے والے راکٹوں پر انحصار کر رہا ہے۔ اور اس ضمن میں یوکرین کی فوج کو ’چیک ریپبلک، رومانیہ اور پاکستان سے سپلائی آ رہی ہے۔‘

پاکستان کے دفتر خارجہ کی ہفتہ وار بریفنگ میں جب بی بی سی کی جانب سے اس بابت سوال ترجمان دفتر خارجہ سے کیا گیا تو انھوں نے اس دعوے کو یکسر مسترد کرتے ہوئے کہا کہ پاکستان یوکرین روس جنگ میں غیر جانبدار ہے اور اس نے یوکرین کو کسی قسم کا اسلحہ یا گولہ بارود سپلائی نہیں کیا ہے۔

ترجمان دفتر خارجہ کا مزید کہنا تھا کہ پاکستان کے ماضی میں یوکرین کے ساتھ اچھے دفاعی تعلقات رہے ہیں مگر اس وقت کسی قسم کا اسلحہ فراہم نہیں کیا جا رہا۔

واضح رہے کہ بی بی سی کے نامہ نگار جوناتھن بیل اس وقت یوکرین میں ہیں اور وہ اگلے مورچوں پر یوکرین کی فوج کی کارروائیوں سے متعلق رپورٹ کر رہے ہیں۔

بی بی سی پر شائع ہونے والی ان کی ایک خبر میں یوکرین فوج کی 17 ٹینک بٹالین کے کمانڈر نے جہاں ایک جانب پاکستان سمیت دیگر ممالک سے راکٹ ملنے کی بات کی تھی وہیں انھوں گلہ کیا تھا کہ ’پاکستان سے آنے والے راکٹ معیاری نہیں ہیں۔‘""";

                            transcript.summary =
                                """یوکرینی فوج کے ایک کمانڈر کی جانب سے انھیں ملنے والے پاکستانی اسلحے کے ’غیرمعیاری‘ ہونے کے دعوے کے بعد ایک مرتبہ پھر یہ بحث چھڑ گئی ہے کہ آیا پاکستان یوکرین میں روسی فوج سے برسرپیکار فوجیوں کو اسلحہ دے رہا ہے یا نہیں۔""";

                            setState(() {});
                          }
                        },
                      ),
                      GeneratedTranscription(transcription: transcript),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
