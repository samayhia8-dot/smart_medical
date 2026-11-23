
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  bool medicationReminders = true;

  final Color primaryColor = const Color(0xFF008F83);

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void showOption(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text(
            'Are you sure you want to logout?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                showMessage('Logout selected');
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget settingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFE5F2EE),
        child: Icon(icon, color: primaryColor),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 11),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.black54,
      ),
      onTap: onTap,
    );
  }

  Widget switchItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFE5F2EE),
        child: Icon(icon, color: primaryColor),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 11),
      ),
      trailing: Switch(
        value: value,
        activeColor: Colors.white,
        activeTrackColor: primaryColor,
        onChanged: onChanged,
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        top: 15,
        bottom: 5,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F7),
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: TextStyle(fontSize: 19),
            ),
            Text(
              'Manage your account and app preferences',
              style: TextStyle(fontSize: 11),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18),
            child: Icon(Icons.settings_outlined),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: const Color(0xFFE5F2EE),
                    child: Icon(
                      Icons.person_outline,
                      size: 32,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Manage your personal information',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ],
              ),
            ),

            sectionTitle('Account'),

            settingItem(
              icon: Icons.person_outline,
              title: 'Profile Settings',
              subtitle: 'View and update your personal information',
              onTap: () {
                showOption(
                  'Profile Settings',
                  'Manage your personal information.',
                );
              },
            ),

            settingItem(
              icon: Icons.lock_outline,
              title: 'Account & Security',
              subtitle: 'Change your password and manage security',
              onTap: () {
                showOption(
                  'Account & Security',
                  'Manage your account security.',
                );
              },
            ),

            sectionTitle('App Preferences'),

            switchItem(
              icon: Icons.notifications_none,
              title: 'Notifications',
              subtitle: 'Manage your notifications',
              value: notifications,
              onChanged: (value) {
                setState(() {
                  notifications = value;
                });
              },
            ),

            switchItem(
              icon: Icons.medication_outlined,
              title: 'Medication Reminders',
              subtitle: 'Set and manage your medication alerts',
              value: medicationReminders,
              onChanged: (value) {
                setState(() {
                  medicationReminders = value;
                });
              },
            ),

            settingItem(
              icon: Icons.language,
              title: 'Language',
              subtitle: 'Choose your preferred language',
              onTap: () {
                showOption(
                  'Language',
                  'English is currently selected.',
                );
              },
            ),

            settingItem(
              icon: Icons.palette_outlined,
              title: 'Appearance',
              subtitle: 'Choose your app theme - Light',
              onTap: () {
                showOption(
                  'Appearance',
                  'Light theme is currently selected.',
                );
              },
            ),

            sectionTitle('Support & Legal'),

            settingItem(
              icon: Icons.shield_outlined,
              title: 'Privacy & Data',
              subtitle: 'Manage your data and privacy settings',
              onTap: () {
                showOption(
                  'Privacy & Data',
                  'Privacy and data settings.',
                );
              },
            ),

            settingItem(
              icon: Icons.help_outline,
              title: 'Help & Support',
              subtitle: 'Get help or contact us',
              onTap: () {
                showOption(
                  'Help & Support',
                  'Contact our support team for assistance.',
                );
              },
            ),

            settingItem(
              icon: Icons.description_outlined,
              title: 'Terms & Conditions',
              subtitle: 'Read our terms and policies',
              onTap: () {
                showOption(
                  'Terms & Conditions',
                  'Terms and conditions of Healix.',
                );
              },
            ),

            const SizedBox(height: 15),

            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFEEEE),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.red,
                  size: 16,
                ),
                onTap: showLogoutDialog,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medication_outlined),
            label: 'Medications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'Medical Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
