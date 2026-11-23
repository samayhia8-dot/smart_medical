import 'package:cloud_firestore/cloud_firestore.dart';

class Keys {
  static String gnews = '';
  static String gemini = '';

  static Future<void> load() async {
    if (gnews.isNotEmpty && gemini.isNotEmpty) return;

    final doc = await FirebaseFirestore.instance
        .collection('config')
        .doc('keys')
        .get();

    gnews = doc['gnewsKey'];
    gemini = doc['geminiKey'];
  }
}