
import 'package:flutter/material.dart';
import 'widgets/login.dart';

class DoctorLoginScreen extends StatelessWidget {
  const DoctorLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginForm(isPatient: false);
  }
}