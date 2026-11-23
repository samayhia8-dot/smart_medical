
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:smart_medication_system/firebase_options.dart';

// Splash and welcome screens
import 'package:smart_medication_system/screens/welcome/Splash.dart';
import 'package:smart_medication_system/screens/welcome/role_selection_screen.dart';

// Registration and login screens
import 'package:smart_medication_system/screens/login/doctor_registration.dart';
import 'package:smart_medication_system/screens/login/patient_registration_screen.dart';
import 'package:smart_medication_system/screens/login/patient_login.dart';
import 'package:smart_medication_system/screens/login/doctor_login.dart';

// Patient and doctor profiles
import 'package:smart_medication_system/screens/patient_profile_screen.dart';
import 'package:smart_medication_system/screens/doctor_profile_screen.dart';

// Dashboard and other screens
import 'package:smart_medication_system/screens/messages_screen.dart';
import 'package:smart_medication_system/screens/patient_dashboard.dart';
import 'package:smart_medication_system/screens/doctor_dashboard.dart';
import 'package:smart_medication_system/screens/my_doctor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

        // Welcome
        '/roleSelection': (context) => const RoleSelectionScreen(),

        // Registration
        '/patientRegistration': (context) =>
        const PatientRegistrationScreen(),
        '/doctorRegistration': (context) =>
        const DoctorRegistrationScreen(),

        // Login
        '/patientLogin': (context) => const PatientLoginScreen(),
        '/doctorLogin': (context) => const DoctorLoginScreen(),

        // Profiles
        '/patientProfile': (context) => const PatientProfileScreen(),
        '/doctorProfile': (context) => const DoctorProfileScreen(),

        // Dashboards
        '/patientHome': (context) => const PatientDashboard(),
        '/doctorHome': (context) => const DoctorDashboard(),

        // Other screens
        '/messages': (context) => MessagesScreen(),
        '/myDoctor': (context) => const MyDoctorScreen(),
      },
    );
  }
}
