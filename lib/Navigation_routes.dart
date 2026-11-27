import 'package:flutter/material.dart';
import 'package:smart_medication_system/screens/chatai_screen.dart';
import 'package:smart_medication_system/screens/doctor/Doctor_Post.dart';
import 'package:smart_medication_system/screens/doctor/doctor_profile.dart';
import 'package:smart_medication_system/screens/doctor/doctor_settings.dart';
import 'package:smart_medication_system/screens/emergency_screen.dart';
import 'package:smart_medication_system/screens/login/doctor_login.dart';
import 'package:smart_medication_system/screens/login/doctor_registration.dart';
import 'package:smart_medication_system/screens/login/patient_login.dart';
import 'package:smart_medication_system/screens/login/patient_registration_screen.dart';
import 'package:smart_medication_system/screens/messages_screen.dart';
import 'package:smart_medication_system/screens/welcome/role_selection_screen.dart';
import 'package:smart_medication_system/screens/welcome/splash.dart';
import 'screens/doctor/BottomNavigation.dart';
import 'screens/doctor/doctor_dashboard.dart';
import 'screens/patient/my_doctor.dart';
import 'screens/patient/patient_dashboard.dart';

final Map<String, WidgetBuilder> navigationRoutes = {
  '/': (context) =>  Splash(),
  '/roleSelection': (context) => const RoleSelectionScreen(),
  '/patientRegistration': (context) => const PatientRegistrationScreen(),
  '/doctorRegistration': (context) => const DoctorRegistrationScreen(),
  '/patientLogin': (context) => const PatientLoginScreen(),
  '/doctorLogin': (context) => const DoctorLoginScreen(),
  '/messages': (context) =>  MessagesScreen(),
  '/patientHome': (context) => const PatientDashboard(),
  '/doctorHome': (context) => const MainScreen(),//DoctorDashboard(),
  '/myDoctor': (context) => const MyDoctorScreen(),
  '/Posts': (context) =>  DoctorPost(),
  '/AI': (context) =>  Chatai(),
  '/Emergency': (context) =>  EmergencyScreen(),
  '/setting': (context) =>  SettingsScreen(),
  '/doctorprofile': (context) =>  DoctorProfileScreen(),

};
