import 'package:flutter/material.dart';
import 'screens/Splash.dart';//import 'package:smart_medication_system/screens/ahmed2.dart';
import 'screens/patient_login.dart';
import 'screens/doctor_login.dart';
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
        '/patientLogin': (context) => const PatientLoginScreen(),
        '/doctorLogin': (context) => const DoctorLoginScreen(),

        // '/patientLogin': (context) => const PatientLoginScreen(),
        //
        // '/doctorLogin': (context) => const DoctorLoginScreen(),
        //
        // '/signIn': (context) => const SignInScreen(),
      },
    );
  }
}