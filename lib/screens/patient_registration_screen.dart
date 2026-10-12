import 'package:flutter/material.dart';

class PatientRegistrationScreen extends StatelessWidget {
  const PatientRegistrationScreen({super.key});

  static const Color primaryBlue = Color(0xFF0088CE);
  static const Color darkBlue = Color(0xFF003B71);
  static const Color green = Color(0xFF00A889);
  static const Color borderBlue = Color(0xFFCCE8FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F7),
      body: SafeArea(
        child: Container(
          width: double.infinity,

          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Color(0xFFF0FCFF),
                Color(0xFFE0F7FC),
              ],
            ),
          ),
          child: Column(
            children: [
              // Header
              Container(
                height: 58,
                decoration: const BoxDecoration(
                 
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.maybePop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: darkBlue,
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/images/7c2f57a9-2c62-48d5-8175-fdd5e2cbd353(1).png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Healix',
                      style: TextStyle(
                        color: darkBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      // Title
                      const Text(
                        'Patient Registration',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          color: darkBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Create your patient account',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF58778D),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Profile Picture
                      Container(
                        width: 100,
                        height: 115,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFD5F7F6),
                        ),
                        child: const Icon(
                          Icons.person_outline,
                          color: primaryBlue,
                          size: 35,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Add Photo
                      InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Photo selection will be added later.',
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Add Photo',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 22),

                      // Full Name
                      const RegistrationField(
                        hint: 'Full Name',
                        icon: Icons.person_outline,
                      ),

                      const SizedBox(height: 12),

                      // Email
                      const RegistrationField(
                        hint: 'Email Address',
                        icon: Icons.mail_outline,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 12),

                      // Mobile Number
                      const RegistrationField(
                        hint: 'UAE Mobile Number',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),

                      const SizedBox(height: 12),

                      // Doctor ID
                      const RegistrationField(
                        hint: "The doctor's ID",
                        icon: Icons.badge_outlined,
                      ),

                      const SizedBox(height: 12),

                      // Password
                      const RegistrationField(
                        hint: 'Password',
                        icon: Icons.lock_outline,
                        isPassword: true,
                      ),

                      const SizedBox(height: 22),

                      // Create Account Button
                      Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF078ACB),
                              Color(0xFF00A889),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: primaryBlue.withValues(alpha: 0.15),
                              blurRadius: 12,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Registration functionality will be added later.',
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: const StadiumBorder(),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Create Account',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 12),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable Input Field
class RegistrationField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;
  final TextInputType keyboardType;

  const RegistrationField({
    super.key,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<RegistrationField> createState() => _RegistrationFieldState();
}

class _RegistrationFieldState extends State<RegistrationField> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword && isPasswordHidden,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: const TextStyle(
          color: Color(0xFF648399),
          fontSize: 12,
        ),
        prefixIcon: Icon(
          widget.icon,
          size: 19,
          color: PatientRegistrationScreen.primaryBlue,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
          onPressed: () {
            setState(() {
              isPasswordHidden = !isPasswordHidden;
            });
          },
          icon: Icon(
            isPasswordHidden
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            size: 19,
            color: const Color(0xFF648399),
          ),
        )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        filled: true,
        fillColor: const Color(0xFFF8FCFE),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(
            color: PatientRegistrationScreen.borderBlue,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(
            color: PatientRegistrationScreen.primaryBlue,
            width: 1.4,
          ),
        ),
      ),
    );
  }
}