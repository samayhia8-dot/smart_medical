

import 'package:flutter/material.dart';
import 'widgets/login.dart';

class PatientLoginScreen extends StatelessWidget {
  const PatientLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginForm(isPatient: true);
  }
}