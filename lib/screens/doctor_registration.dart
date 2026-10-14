import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class AppColors {
  static const navy = Color(0xFF14295B);
  static const blue = Color(0xFF3B8FD6);
  static const blueDark = Color(0xFF3B7FC4);
  static const green = Color(0xFF4BA67E);
  static const grey = Color(0xFF6B7A90);
  static const fieldFill = Color(0xFFF7FBFE);
  static const fieldBorder = Color(0xFFD9E9F6);
  static const dashed = Color(0xFF9CCBEA);
  static const iconBg = Color(0xFFE3F1FC);
  static const bgTop = Color(0xFFFFFFFF);
  static const bgBottom = Color(0xFFE6F4FE);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DoctorRegistrationScreen(),
    );
  }
}

class DoctorRegistrationScreen extends StatefulWidget {
  const DoctorRegistrationScreen({super.key});

  @override
  State<DoctorRegistrationScreen> createState() =>
      _DoctorRegistrationScreenState();
}

class _DoctorRegistrationScreenState extends State<DoctorRegistrationScreen> {
  bool obscure = true;
  String? specialization;

  final specs = const [
    'Cardiology',
    'Dermatology',
    'Neurology',
    'Pediatrics',
    'Orthopedics',
    'Psychiatry',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.bgTop, AppColors.bgBottom],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [

                    IconButton(
                      onPressed: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          Navigator.pushReplacementNamed(
                            context,
                            '/roleSelection',
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.navy,
                        size: 22,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),

                    const Spacer(),
                    const LogoMark(width: 36),
                    const SizedBox(width: 6),
                    const Text(
                      'Healix',
                      style: TextStyle(
                        color: AppColors.navy,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 22),
                  ],
                ),
                const SizedBox(height: 40),
                const Text(
                  'Doctor Registration',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Create your doctor account',
                  style: TextStyle(color: AppColors.navy, fontSize: 14),
                ),
                const SizedBox(height: 32),
                Row(
                  children: const [
                    Expanded(
                      child: UploadBox(
                        title: 'Upload Professional License',
                        subtitle: 'PDF, JPG or PNG',
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: UploadBox(
                        title: 'Upload ID Card (Front)',
                        subtitle: 'PDF, JPG or PNG',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                field(Icons.person_outline, 'Full Name'),
                const SizedBox(height: 14),
                field(Icons.mail_outline, 'Email Address',
                    keyboard: TextInputType.emailAddress),
                const SizedBox(height: 14),
                dropdown(),
                const SizedBox(height: 14),
                field(Icons.location_on_outlined, 'Clinic Address'),
                const SizedBox(height: 36),
                field(Icons.lock_outline, 'Password',
                    obscureText: obscure,
                    suffix: IconButton(
                      onPressed: () => setState(() => obscure = !obscure),
                      icon: Icon(
                        obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.grey,
                        size: 20,
                      ),
                    )),
                const SizedBox(height: 36),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [AppColors.blueDark, AppColors.green],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blueDark.withOpacity(0.25),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Create Account',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward,
                            color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration decoration(IconData icon, String hint, {Widget? suffix}) {
    OutlineInputBorder border() => OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.fieldBorder),
        );
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.grey, fontSize: 15),
      prefixIcon: Icon(icon, color: AppColors.blue, size: 22),
      suffixIcon: suffix,
      filled: true,
      fillColor: AppColors.fieldFill,
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
      enabledBorder: border(),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.blue),
      ),
      border: border(),
    );
  }

  Widget field(
    IconData icon,
    String hint, {
    bool obscureText = false,
    Widget? suffix,
    TextInputType? keyboard,
  }) {
    return SizedBox(
      height: 60,
      child: TextField(
        obscureText: obscureText,
        keyboardType: keyboard,
        style: const TextStyle(color: AppColors.navy, fontSize: 15),
        decoration: decoration(icon, hint, suffix: suffix),
      ),
    );
  }

  Widget dropdown() {
    return SizedBox(
      height: 60,
      child: DropdownButtonFormField<String>(
        value: specialization,
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down,
            color: AppColors.navy, size: 22),
        decoration: decoration(Icons.medical_services_outlined, 'Specialization'),
        hint: const Text(
          'Specialization',
          style: TextStyle(color: AppColors.grey, fontSize: 15),
        ),
        style: const TextStyle(color: AppColors.navy, fontSize: 15),
        items: specs
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (v) => setState(() => specialization = v),
      ),
    );
  }
}

class LogoMark extends StatelessWidget {
  final double width;

  const LogoMark({super.key, this.width = 36});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, width * 220 / 315),
      painter: LogoPainter(),
    );
  }
}

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 315);
    canvas.translate(-245, -105);

    final navy = Paint()..color = const Color(0xFF10305E);
    final green = Paint()..color = const Color(0xFF4CA687);

    final crescent = Path()
      ..moveTo(268, 320)
      ..cubicTo(235, 250, 260, 190, 330, 150)
      ..cubicTo(380, 125, 430, 140, 455, 155)
      ..cubicTo(425, 170, 410, 190, 400, 215)
      ..cubicTo(370, 205, 320, 205, 295, 245)
      ..cubicTo(283, 268, 280, 300, 268, 320)
      ..close();

    final blob = Path()
      ..moveTo(303, 258)
      ..cubicTo(312, 232, 352, 225, 380, 232)
      ..cubicTo(392, 265, 395, 300, 407, 325)
      ..cubicTo(360, 330, 318, 305, 303, 258)
      ..close();

    final leaf = Path()
      ..moveTo(398, 263)
      ..cubicTo(395, 200, 450, 125, 558, 105)
      ..cubicTo(560, 170, 500, 255, 398, 263)
      ..close();

    canvas.drawPath(crescent, navy);
    canvas.drawPath(blob, navy);
    canvas.drawPath(leaf, green);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class UploadBox extends StatelessWidget {
  final String title;
  final String subtitle;

  const UploadBox({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedRRectPainter(),
      child: Container(
        height: 104,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.cloud_upload_outlined,
                  color: AppColors.blue, size: 20),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.navy,
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(color: AppColors.grey, fontSize: 8.5),
            ),
          ],
        ),
      ),
    );
  }
}

class DashedRRectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.dashed
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(12),
      ));

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + 5), paint);
        distance += 9;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
