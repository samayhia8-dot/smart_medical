
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class DoctorRegistrationScreen extends StatefulWidget {
  const DoctorRegistrationScreen({super.key});

  @override
  State<DoctorRegistrationScreen> createState() =>
      _DoctorRegistrationScreenState();
}

class _DoctorRegistrationScreenState
    extends State<DoctorRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();

  bool obscure = true;
  bool isLoading = false;
  String? specialization;

  final List<String> specs = const [
    'Cardiology',
    'Dermatology',
    'Neurology',
    'Pediatrics',
    'Orthopedics',
    'Psychiatry',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> registerDoctor() async {
    if (isLoading) return;

    if (!_formKey.currentState!.validate()) return;

    if (specialization == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your specialization'),
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    User? newUser;

    try {
      final email = _emailController.text.trim();
      final fullName = _nameController.text.trim();
      final clinicAddress = _addressController.text.trim();

      // 1. Create the doctor's Firebase Authentication account.
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: _passwordController.text,
      );

      newUser = credential.user;

      if (newUser == null) {
        throw Exception('Could not create the doctor account.');
      }

      // 2. Save the doctor's information in Cloud Firestore.
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(newUser.uid)
          .set({
        'uid': newUser.uid,
        'fullName': fullName,
        'email': email,
        'specialization': specialization,
        'clinicAddress': clinicAddress,
        'role': 'doctor',
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Doctor account created and data saved successfully!',
          ),
          backgroundColor: Colors.green,
        ),
      );

      // Return to the doctor login screen after successful registration.
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/doctorLogin',
            (route) => route.isFirst,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message;

      switch (e.code) {
        case 'email-already-in-use':
          message = 'This email is already registered.';
          break;
        case 'invalid-email':
          message = 'Please enter a valid email address.';
          break;
        case 'weak-password':
          message = 'Password must be at least 6 characters.';
          break;
        case 'network-request-failed':
          message = 'Check your internet connection.';
          break;
        default:
          message = e.message ?? 'Registration failed.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      // If Auth succeeded but saving the profile failed,
      // remove the newly created Auth account to avoid
      // leaving an account without its Firestore profile.
      if (newUser != null) {
        try {
          await newUser.delete();
        } catch (_) {
          // If deletion fails, the Auth account may remain.
        }
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not save doctor data: $e'),
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

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
            colors: [
              AppColors.bgTop,
              AppColors.bgBottom,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            child: Form(
              key: _formKey,
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
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // These boxes are visual placeholders.
                  // Actual file uploads are not implemented yet.
                  const Row(
                    children: [
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

                  field(
                    icon: Icons.person_outline,
                    hint: 'Full Name',
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),

                  field(
                    icon: Icons.mail_outline,
                    hint: 'Email Address',
                    controller: _emailController,
                    keyboard: TextInputType.emailAddress,
                    validator: (value) {
                      final email = value?.trim() ?? '';

                      if (email.isEmpty) {
                        return 'Please enter your email';
                      }

                      if (!RegExp(
                        r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                      ).hasMatch(email)) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 14),

                  dropdown(),
                  const SizedBox(height: 14),

                  field(
                    icon: Icons.location_on_outlined,
                    hint: 'Clinic Address',
                    controller: _addressController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your clinic address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 36),

                  field(
                    icon: Icons.lock_outline,
                    hint: 'Password',
                    controller: _passwordController,
                    obscureText: obscure,
                    suffix: IconButton(
                      onPressed: () {
                        setState(() => obscure = !obscure);
                      },
                      icon: Icon(
                        obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.grey,
                        size: 20,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }

                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 36),

                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: isLoading
                              ? [
                            AppColors.grey,
                            AppColors.grey,
                          ]
                              : [
                            AppColors.blueDark,
                            AppColors.green,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blueDark.withOpacity(0.25),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: isLoading ? null : registerDoctor,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          disabledBackgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: const StadiumBorder(),
                        ),
                        child: isLoading
                            ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Create Account',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration decoration(
      IconData icon,
      String hint, {
        Widget? suffix,
      }) {
    OutlineInputBorder border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        color: AppColors.fieldBorder,
      ),
    );

    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: AppColors.grey,
        fontSize: 15,
      ),
      prefixIcon: Icon(
        icon,
        color: AppColors.blue,
        size: 22,
      ),
      suffixIcon: suffix,
      filled: true,
      fillColor: AppColors.fieldFill,
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
      enabledBorder: border(),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.blue,
        ),
      ),
      border: border(),
    );
  }

  Widget field({
    required IconData icon,
    required String hint,
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffix,
    TextInputType? keyboard,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboard,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(
        color: AppColors.navy,
        fontSize: 15,
      ),
      decoration: decoration(
        icon,
        hint,
        suffix: suffix,
      ),
    );
  }

  Widget dropdown() {
    return DropdownButtonFormField<String>(
      initialValue: specialization,
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: AppColors.navy,
        size: 22,
      ),
      decoration: decoration(
        Icons.medical_services_outlined,
        'Specialization',
      ),
      hint: const Text(
        'Specialization',
        style: TextStyle(
          color: AppColors.grey,
          fontSize: 15,
        ),
      ),
      style: const TextStyle(
        color: AppColors.navy,
        fontSize: 15,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a specialization';
        }
        return null;
      },
      items: specs
          .map(
            (spec) => DropdownMenuItem<String>(
          value: spec,
          child: Text(spec),
        ),
      )
          .toList(),
      onChanged: isLoading
          ? null
          : (value) {
        setState(() => specialization = value);
      },
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

  const UploadBox({
    super.key,
    required this.title,
    required this.subtitle,
  });

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
              child: const Icon(
                Icons.cloud_upload_outlined,
                color: AppColors.blue,
                size: 20,
              ),
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
              style: const TextStyle(
                color: AppColors.grey,
                fontSize: 8.5,
              ),
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
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          const Radius.circular(12),
        ),
      );

    for (final metric in path.computeMetrics()) {
      double distance = 0;

      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + 5),
          paint,
        );
        distance += 9;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
