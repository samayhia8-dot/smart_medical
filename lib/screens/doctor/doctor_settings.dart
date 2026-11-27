import 'package:flutter/material.dart';
import 'package:smart_medication_system/screens/doctor/doctor_translator.dart';


const kTeal = Color(0xFF009C9C);
const kBlue = Color(0xFF0A5BA5);
const kBg = Color(0xFFF2FCFC);

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool apptReminders = true;
  bool patientMessages = true;
  bool medicationAlerts = true;
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                children: [
                  _profileCard(),
                  const SizedBox(height: 14),
                  _securityCard(),
                  const SizedBox(height: 14),
                  _notificationsCard(),
                  const SizedBox(height: 14),
                  _appearanceCard(),
                  const SizedBox(height: 14),
                  _logoutBtn(),
                ],
              ),
            ),
            _saveButton(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Image.asset(
            'assets/images/7c2f57a9-2c62-48d5-8175-fdd5e2cbd353(1).png',
            height: 50,
            errorBuilder: (c, o, s) =>
                const Icon(Icons.medical_services, color: kTeal, size: 40),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Healix',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kTeal,
                  ),
                ),
                Text(
                  'Your Health .. Our Priority',
                  style: TextStyle(fontSize: 11, color: kTeal),
                ),
              ],
            ),
          ),
          const Icon(Icons.notifications_none, size: 28, color: kBlue),
          const SizedBox(width: 10),
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/male_doctor.png'),
          ),
        ],
      ),
    );
  }

  Widget _profileCard() {
    return _sectionCard(
      icon: Icons.person_outline,
      title: "profile_info_title".tr(),
      subtitle: "profile_info_sub".tr(),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                      'assets/images/male_doctor.png',
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: kTeal,
                      child: const Icon(
                        Icons.camera_alt,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Dr. Ahmed El-Sayed',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kBlue,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'General Practitioner',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      'ahmed.elsayed@smartmed.com',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      '+20 123 456 789',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit, size: 16, color: Colors.white),
              label: Text(
                "edit_profile".tr(),
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kTeal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _securityCard() {
    return _sectionCard(
      icon: Icons.lock_outline,
      title: "security_title".tr(),
      subtitle: "security_sub".tr(),
      child: Column(
        children: [
          _arrowRow(
            Icons.lock_reset,
            "change_password".tr(),
            "change_password_sub".tr(),
          ),
          const Divider(height: 20, color: Color(0xFFEAF5F4)),
          _arrowRow(
            Icons.devices,
            "active_sessions".tr(),
            "active_sessions_sub".tr(),
          ),
        ],
      ),
    );
  }

  Widget _notificationsCard() {
    return _sectionCard(
      icon: Icons.notifications_none,
      title: "notifications_title".tr(),
      subtitle: "notifications_sub".tr(),
      child: Column(
        children: [
          _switchRow(
            Icons.calendar_month_outlined,
            "appt_reminders".tr(),
            "appt_reminders_sub".tr(),
            apptReminders,
            (v) {
              setState(() => apptReminders = v);
            },
          ),
          _switchRow(
            Icons.chat_bubble_outline,
            "patient_messages".tr(),
            "patient_messages_sub".tr(),
            patientMessages,
            (v) {
              setState(() => patientMessages = v);
            },
          ),
          _switchRow(
            Icons.medication_outlined,
            "medication_alerts".tr(),
            "medication_alerts_sub".tr(),
            medicationAlerts,
            (v) {
              setState(() => medicationAlerts = v);
            },
          ),
        ],
      ),
    );
  }

  Widget _appearanceCard() {
    return _sectionCard(
      icon: Icons.palette_outlined,
      title: "appearance_title".tr(),
      subtitle: "appearance_sub".tr(),
      child: Column(
        children: [
          _switchRow(
            Icons.dark_mode_outlined,
            "dark_mode".tr(),
            "dark_mode_sub".tr(),
            isDarkMode,
            (v) {
              setState(() {
                isDarkMode = v;
              });
            },
          ),
          const Divider(height: 20, color: Color(0xFFEAF5F4)),
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFFE0F7F7),
                child: Icon(Icons.language, color: kTeal, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "language".tr(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kBlue,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "language_sub".tr(),
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  value: DoctorTranslator.lang.value,
                  underline: const SizedBox(),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text(
                        'English 🇺🇸',
                        style: TextStyle(fontSize: 13, color: kBlue),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'ar',
                      child: Text(
                        'العربية 🇪🇬',
                        style: TextStyle(fontSize: 13, color: kBlue),
                      ),
                    ),
                  ],
                  onChanged: (langCode) {
                    if (langCode != null) {
                      setState(() {
                        DoctorTranslator.lang.value = langCode;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _logoutBtn() {
    return InkWell(
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/doctorLogin',
              (route) => false,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          children: [
             Icon(Icons.logout, color: kTeal),
             SizedBox(width: 14),
            Text("logout".tr(), style:  TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: kBlue)),
          ],
        ),
      ),
    );
  }


  Widget _saveButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 4, 14, 12),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("changes_saved".tr())));
          },
          icon: const Icon(Icons.save_outlined, color: Colors.white),
          label: Text(
            "save_changes".tr(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: kTeal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
        ),
      ),
    );
  }

  Widget _sectionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD4F1F1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: kTeal, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kBlue,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: Color(0xFFEAF5F4), height: 1),
          ),
          child,
        ],
      ),
    );
  }

  Widget _arrowRow(IconData icon, String title, String sub) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: const Color(0xFFE0F7F7),
          child: Icon(icon, color: kTeal, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: kBlue,
                  fontSize: 14,
                ),
              ),
              Text(
                sub,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
      ],
    );
  }

  Widget _switchRow(
    IconData icon,
    String title,
    String sub,
    bool val,
    ValueChanged<bool> onChange,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFE0F7F7),
            child: Icon(icon, color: kTeal, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: kBlue,
                    fontSize: 14,
                  ),
                ),
                Text(
                  sub,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),
          Switch(
            value: val,
            onChanged: onChange,
            activeColor: Colors.white,
            activeTrackColor: kTeal,
            inactiveTrackColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
