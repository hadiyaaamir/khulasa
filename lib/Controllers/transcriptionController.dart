import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Backend/api.dart';
import 'package:khulasa/Controllers/Backend/openAi.dart';
import 'package:khulasa/Models/transcript.dart';
import 'package:khulasa/constants/api.dart';

class TranscriptionController extends ChangeNotifier {
  Transcript _transcript = Transcript(transcription: "", summary: "");
  Transcript get transcript => _transcript;
  set transcript(Transcript t) {
    _transcript = t;
    notifyListeners();
  }

  bool _isGenerating = false;
  bool get isGenerating => _isGenerating;
  set isGenerating(bool generating) {
    _isGenerating = generating;
    notifyListeners();
  }

  bool _fileAttatched = false;
  bool get fileAttatched => _fileAttatched;
  set fileAttatched(bool a) {
    _fileAttatched = a;
    notifyListeners();
  }

  var _file;
  get file => _file;
  set file(var f) {
    _file = f;
    notifyListeners();
  }

  getTranscription() async {
    isGenerating = true;
    notifyListeners();

    await OpenAi().transcription(file).then(
      (result) async {
        // transcript.transcription = result;
        print(result);
        transcript.transcription = result;

        //get summary
        await Api()
            .generateSummary(algo: summaryType1, ratio: 0.2, text: result)
            .then(
          (value) async {
            transcript.summary = value.summary;

            if (value.summary.isEmpty) {
              await Api()
                  .generateSummary(algo: summaryType1, ratio: 0.3, text: result)
                  .then((value) async {
                transcript.summary = value.summary;
                if (value.summary.isEmpty) {
                  await Api()
                      .generateSummary(
                          algo: summaryType1, ratio: 0.4, text: result)
                      .then((value) => transcript.summary =
                          value.summary.isNotEmpty ? value.summary : result);
                }
              }).then((value) {
                isGenerating = false;
              });
            } else {
              isGenerating = false;
            }
          },
        );
      },
    );
    notifyListeners();
  }

  // setTranscript(String transcript) {
  //   _transcript.transcription = transcript;
  //   notifyListeners();
  // }

  // setSummary(String summary) {
  //   _transcript.summary = summary;
  //   notifyListeners();
  // }
}
