import 'dart:typed_data';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:smart_medication_system/Firebase/FireStore/keys.dart';

class GeminiService {
  static GenerativeModel? _model;

  // بيعمل الموديل مرة واحدة بالمفتاح اللي اتقرا من Firebase
  static GenerativeModel _getModel() {
    final existing = _model;
    if (existing != null) {
      return existing;
    }

    final model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: Keys.gemini,
      systemInstruction: Content.text(
          'أنت Healix AI، مساعد ذكاء اصطناعي متخصص في المجال الطبي والصحي فقط. '

              'أولاً: اللغة وطريقة الرد: '
              'حدد لغة الرد بناءً على لغة المستخدم في رسالته الحالية. '
              'إذا كتب المستخدم بالعربية، فأجب بالعربية. '
              'إذا كتب بالإنجليزية، فأجب بالإنجليزية. '
              'إذا طلب المستخدم صراحةً الرد بلغة مختلفة عن لغة سؤاله، '
              'فاستخدم اللغة التي طلبها. '
              'ينطبق ذلك على جميع الرسائل، حتى لو كانت المحادثة السابقة بلغة أخرى. '
              'إذا خلط المستخدم بين لغتين، فاستخدم اللغة الغالبة في سؤاله، '
              'إلا إذا طلب لغة معينة بوضوح. '

              'ثانياً: التخصص الطبي: '
              'أجب فقط عن الأسئلة المتعلقة بالطب والصحة، '
              'مثل الأمراض والأعراض والأدوية والتحاليل والأشعة '
              'والإسعافات الأولية والتغذية الصحية والوقاية. '
              'إذا كان السؤال خارج المجال الطبي، فلا تجب عن محتواه، '
              'واعتذر باختصار ووضح أنك مساعد طبي متخصص. '
              'اكتب هذا الرفض باللغة التي استخدمها المستخدم، '
              'أو باللغة التي طلبها صراحةً. '

              'ثالثاً: السلامة الطبية: '
              'قدم معلومات طبية عامة وواضحة وحذرة. '
              'لا تقدم تشخيصاً نهائياً ولا تدّعِ أنك طبيب. '
              'وضح أن المعلومات لا تغني عن مراجعة الطبيب المختص عند الحاجة.'
      ),
    );

    _model = model;
    return model;
  }

  static Stream<String> streamMessage({
    required String prompt,
    Uint8List? imageBytes,
    String imageMimeType = 'image/jpeg', String? imageName,
  }) async* {
    try {
      await Keys.load();

      if (Keys.gemini.isEmpty) {
        yield 'خدمة الذكاء الاصطناعي غير مهيأة. '
            'يرجى ضبط إعدادات الخدمة.';
        return;
      }

      final model = _getModel();
      final List<Part> parts = [];

      if (imageBytes != null && imageBytes.isNotEmpty) {
        parts.add(DataPart(imageMimeType, imageBytes));
      }

      final String textPrompt = prompt.trim().isNotEmpty
          ? prompt.trim()
          : 'ما ملاحظاتك على هذه الصورة الطبية؟';

      parts.add(TextPart(textPrompt));

      final responseStream = model.generateContentStream([
        Content.multi(parts),
      ]);

      await for (final chunk in responseStream) {
        if (chunk.text != null && chunk.text!.isNotEmpty) {
          yield chunk.text!;
        }
      }
    } catch (_) {
      yield 'حدث خطأ أثناء الاتصال بخدمة الذكاء الاصطناعي. '
          'حاول مرة أخرى.';
    }
  }
}