import 'package:flutter/material.dart';
import 'package:smart_medication_system/screens/Splash.dart';

import 'screens/role_selection_screen.dart';
// import 'screens/patient_login_screen.dart';
// import 'screens/doctor_login_screen.dart';
// import 'screens/sign_in_screen.dart';
import 'screens/patient_registration_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/patientRegistration': (context) =>
        const PatientRegistrationScreen(),

        //'/patientLogin': (context) => const PatientRegistrationScreen(),
        //
        // '/doctorLogin': (context) => const DoctorLoginScreen(),
        //
        // '/signIn': (context) => const SignInScreen(),
      },
    );
  }
}