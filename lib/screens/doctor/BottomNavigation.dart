import 'package:flutter/material.dart';
import 'package:smart_medication_system/screens/doctor/doctor_dashboard.dart';
import 'package:smart_medication_system/screens/doctor/doctor_profile.dart';
import 'package:smart_medication_system/screens/doctor/doctor_settings.dart';
import 'package:smart_medication_system/screens/doctor/doctor_translator.dart';
import 'package:smart_medication_system/screens/messages_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  static const kTeal = Color(0xFF009C9C);
  static const kBlue = Color(0xFF0A5BA5);
  static const kBg = Color(0xFFF2FCFC);

  final List<Widget> _pages = [
    const DoctorDashboard(),
     MessagesScreen(),
    const DoctorProfileScreen(),
    const SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: DoctorTranslator.lang,
      builder: (context, currentLang, child) {
        return FutureBuilder(
          future: DoctorTranslator.load(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(body: Center(child: CircularProgressIndicator(color: kTeal)));
            }
            return Directionality(
              textDirection: currentLang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
              child: Scaffold(
                backgroundColor: kBg,
                body: _pages[_currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  selectedItemColor: kTeal,
                  unselectedItemColor: kBlue,
                  selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  unselectedLabelStyle: const TextStyle(fontSize: 11),
                  onTap: (index) => setState(() => _currentIndex = index),
                  items: [
                    BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'home'.tr()), // 👈 رجعت أهي مباشرة ونظيفة!
                    BottomNavigationBarItem(icon: const Icon(Icons.event_available), label: 'patients'.tr()),
                    BottomNavigationBarItem(icon: const Icon(Icons.person_outline), label: 'profile'.tr()),
                    BottomNavigationBarItem(icon: const Icon(Icons.settings), label: 'settings'.tr()),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
