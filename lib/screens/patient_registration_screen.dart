
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientRegistrationScreen extends StatefulWidget {
  const PatientRegistrationScreen({super.key});

  static const Color primaryBlue = Color(0xFF0088CE);
  static const Color darkBlue = Color(0xFF003B71);
  static const Color green = Color(0xFF00A889);
  static const Color borderBlue = Color(0xFFCCE8FA);

  @override
  State<PatientRegistrationScreen> createState() =>
      _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState
    extends State<PatientRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _doctorIdController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordHidden = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _doctorIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _createAccount() async {
    if (_isLoading) return;

    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    User? user;

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      user = credential.user;

      if (user == null) {
        throw Exception('Firebase did not return a user.');
      }

      // Save the patient's information in Cloud Firestore.
      await FirebaseFirestore.instance
          .collection('patients')
          .doc(user.uid)
          .set({
        'uid': user.uid,
        'fullName': _nameController.text.trim(),
        'email': user.email,
        'phoneNumber': _phoneController.text.trim(),
        'doctorId': _doctorIdController.text.trim(),
        'role': 'patient',
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Patient account created successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to the patient login screen.
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/patientLogin',
            (route) => false,
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
          message = 'Please choose a stronger password.';
          break;
        case 'network-request-failed':
          message = 'Check your internet connection.';
          break;
        case 'operation-not-allowed':
          message =
          'Email/Password sign-in is not enabled in Firebase.';
          break;
        default:
          message = e.message ?? 'Unable to create the account.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } on FirebaseException catch (e) {
      if (!mounted) return;

      final message = e.code == 'permission-denied'
          ? 'Account authentication succeeded, but Firestore denied '
          'saving the profile. Check your Firestore security rules.'
          : 'Unable to save patient data: ${e.message ?? e.code}';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong. Please try again.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  InputDecoration _decoration(
      String hint,
      IconData icon, {
        Widget? suffixIcon,
      }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFF648399),
        fontSize: 12,
      ),
      prefixIcon: Icon(
        icon,
        size: 19,
        color: PatientRegistrationScreen.primaryBlue,
      ),
      suffixIcon: suffixIcon,
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
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  Widget _buildField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(
        color: PatientRegistrationScreen.darkBlue,
        fontSize: 14,
      ),
      decoration: _decoration(
        hint,
        icon,
        suffixIcon: suffixIcon,
      ),
    );
  }

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
              SizedBox(
                height: 58,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.maybePop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: PatientRegistrationScreen.darkBlue,
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
                        color: PatientRegistrationScreen.darkBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 20,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          'Patient Registration',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            color: PatientRegistrationScreen.darkBlue,
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

                        // Profile picture placeholder
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFD5F7F6),
                          ),
                          child: const Icon(
                            Icons.person_outline,
                            color: PatientRegistrationScreen.primaryBlue,
                            size: 35,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Photo selection is not implemented yet.
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
                              color: PatientRegistrationScreen.green,
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

                        _buildField(
                          hint: 'Full Name',
                          icon: Icons.person_outline,
                          controller: _nameController,
                          validator: (value) =>
                              _validateRequired(value, 'Full name'),
                        ),

                        const SizedBox(height: 12),

                        _buildField(
                          hint: 'Email Address',
                          icon: Icons.mail_outline,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            final requiredError =
                            _validateRequired(value, 'Email');
                            if (requiredError != null) {
                              return requiredError;
                            }

                            final email = value!.trim();
                            final emailPattern =
                            RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

                            if (!emailPattern.hasMatch(email)) {
                              return 'Enter a valid email address';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 12),

                        _buildField(
                          hint: 'UAE Mobile Number',
                          icon: Icons.phone_outlined,
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) =>
                              _validateRequired(value, 'Mobile number'),
                        ),

                        const SizedBox(height: 12),

                        // Optional: referring doctor's ID
                        _buildField(
                          hint: "The doctor's ID (optional)",
                          icon: Icons.badge_outlined,
                          controller: _doctorIdController,
                        ),

                        const SizedBox(height: 12),

                        _buildField(
                          hint: 'Password',
                          icon: Icons.lock_outline,
                          controller: _passwordController,
                          obscureText: _isPasswordHidden,
                          validator: (value) {
                            final requiredError =
                            _validateRequired(value, 'Password');
                            if (requiredError != null) {
                              return requiredError;
                            }

                            if (value!.length < 6) {
                              return 'Password must be at least 6 characters';
                            }

                            return null;
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordHidden = !_isPasswordHidden;
                              });
                            },
                            icon: Icon(
                              _isPasswordHidden
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 19,
                              color: const Color(0xFF648399),
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: DecoratedBox(
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
                                  color: PatientRegistrationScreen
                                      .primaryBlue
                                      .withValues(alpha: 0.15),
                                  blurRadius: 12,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed:
                              _isLoading ? null : _createAccount,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                disabledBackgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                disabledForegroundColor: Colors.white70,
                                shadowColor: Colors.transparent,
                                shape: const StadiumBorder(),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                                  : const Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
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
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
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
