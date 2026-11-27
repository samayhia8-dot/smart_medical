


import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class DoctorTranslator {

  static final ValueNotifier<String> lang = ValueNotifier<String>('en');
  static Map<String, String> _localizedStrings = {};
  static final GoogleTranslator _googleTranslator = GoogleTranslator();


  static Future<void> load() async {
    String jsonString = await rootBundle.loadString('assets/translations/doctor/${lang.value}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  static String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  static Widget translateApiText(String text, {TextStyle? style, TextAlign? textAlign}) {
    if (lang.value == 'en' || text.isEmpty) {
      return Text(text, style: style, textAlign: textAlign);
    }

    return FutureBuilder<Translation>(
      future: _googleTranslator.translate(text, to: 'ar'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(text, style: style?.copyWith(color: style?.color?.withOpacity(0.3)), textAlign: textAlign);
        }
        return Text(snapshot.data?.text ?? text, style: style, textAlign: textAlign);
      },
    );
  }
}


extension DoctorTranslateExtension on String {
  String tr() => DoctorTranslator.translate(this);

  Widget trApi({TextStyle? style, TextAlign? textAlign}) {
    return DoctorTranslator.translateApiText(this, style: style, textAlign: textAlign);
  }
}
