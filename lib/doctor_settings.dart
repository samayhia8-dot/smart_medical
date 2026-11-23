import 'package:flutter/material.dart';
import 'doctor_auth.dart';

const mainColor = Color(0xFF1E8E86);
const lightColor = Color(0xFFDDF0EE);

final lang = ValueNotifier<String>('en');
final themeMode = ValueNotifier<ThemeMode>(ThemeMode.light);

final flags = {
  'ar': ['🇪🇬', 'العربية'],
  'en': ['🇺🇸', 'English'],
  'fr': ['🇫🇷', 'Français'],
  'es': ['🇪🇸', 'Español'],
  'de': ['🇩🇪', 'Deutsch'],
};

final words = {
  'ar': {
    'tagline': 'صحتك .. أولويتنا',
    'settings': 'الإعدادات',
    'manage': 'إدارة حسابك وتفضيلاتك',
    'profile': 'المعلومات الشخصية',
    'profileSub': 'حدّث بياناتك الشخصية والمهنية',
    'name': 'الاسم',
    'specialty': 'التخصص',
    'email': 'البريد الإلكتروني',
    'phone': 'رقم الهاتف',
    'edit': 'تعديل الملف',
    'pass': 'تغيير كلمة المرور',
    'passSub': 'حدّث كلمة المرور بانتظام لحماية حسابك',
    'sessions': 'الجلسات النشطة',
    'sessionsSub': 'إدارة الأجهزة المسجلة دخولها',
    'notif': 'الإشعارات',
    'notifSub': 'اختر الإشعارات التي تريد استلامها',
    'appt': 'تذكير المواعيد',
    'apptSub': 'تذكير بالمواعيد القادمة',
    'msgs': 'رسائل المرضى',
    'msgsSub': 'استقبال رسائل من مرضاك',
    'meds': 'تنبيهات الأدوية',
    'medsSub': 'تنبيهات عن تحديثات ومشاكل الأدوية',
    'look': 'المظهر',
    'lookSub': 'خصص شكل التطبيق',
    'theme': 'السمة',
    'light': 'فاتح',
    'dark': 'داكن',
    'system': 'النظام',
    'language': 'اللغة',
    'languageSub': 'اختر لغتك المفضلة',
    'logout': 'تسجيل الخروج',
    'save': 'حفظ التغييرات',
    'home': 'الرئيسية',
    'patients': 'مرضاي',
    'appointments': 'المواعيد',
    'nav': 'الإعدادات',
    'saved': 'تم الحفظ',
  },
  'en': {
    'tagline': 'Your Health .. Our Priority',
    'settings': 'Settings',
    'manage': 'Manage your account and preferences',
    'profile': 'Profile Information',
    'profileSub': 'Update your personal details and professional information',
    'name': 'Name',
    'specialty': 'Specialty',
    'email': 'Email',
    'phone': 'Phone',
    'edit': 'Edit Profile',
    'pass': 'Change Password',
    'passSub': 'Update your password regularly to keep your account secure',
    'sessions': 'Active Sessions',
    'sessionsSub': 'Manage your logged-in devices',
    'notif': 'Notifications',
    'notifSub': 'Choose what notifications you want to receive',
    'appt': 'Appointment Reminders',
    'apptSub': 'Get reminded about upcoming appointments',
    'msgs': 'Patient Messages',
    'msgsSub': 'Receive messages from your patients',
    'meds': 'Medication Alerts',
    'medsSub': 'Get alerts about medication updates and issues',
    'look': 'Appearance',
    'lookSub': 'Customize the look and feel of the app',
    'theme': 'Theme',
    'light': 'Light',
    'dark': 'Dark',
    'system': 'System',
    'language': 'Language',
    'languageSub': 'Select your preferred language',
    'logout': 'Logout',
    'save': 'Save Changes',
    'home': 'Home',
    'patients': 'My Patients',
    'appointments': 'Appointments',
    'nav': 'Settings',
    'saved': 'Saved',
  },
  'fr': {
    'tagline': 'Votre santé .. Notre priorité',
    'settings': 'Paramètres',
    'manage': 'Gérez votre compte et vos préférences',
    'profile': 'Informations du profil',
    'profileSub': 'Mettez à jour vos informations personnelles et professionnelles',
    'name': 'Nom',
    'specialty': 'Spécialité',
    'email': 'E-mail',
    'phone': 'Téléphone',
    'edit': 'Modifier le profil',
    'pass': 'Changer le mot de passe',
    'passSub': 'Mettez à jour votre mot de passe régulièrement',
    'sessions': 'Sessions actives',
    'sessionsSub': 'Gérez vos appareils connectés',
    'notif': 'Notifications',
    'notifSub': 'Choisissez les notifications à recevoir',
    'appt': 'Rappels de rendez-vous',
    'apptSub': 'Rappels des prochains rendez-vous',
    'msgs': 'Messages des patients',
    'msgsSub': 'Recevoir les messages de vos patients',
    'meds': 'Alertes médicaments',
    'medsSub': 'Alertes sur les mises à jour des médicaments',
    'look': 'Apparence',
    'lookSub': "Personnalisez l'apparence de l'application",
    'theme': 'Thème',
    'light': 'Clair',
    'dark': 'Sombre',
    'system': 'Système',
    'language': 'Langue',
    'languageSub': 'Choisissez votre langue',
    'logout': 'Déconnexion',
    'save': 'Enregistrer',
    'home': 'Accueil',
    'patients': 'Mes patients',
    'appointments': 'Rendez-vous',
    'nav': 'Paramètres',
    'saved': 'Enregistré',
  },
  'es': {
    'tagline': 'Tu salud .. Nuestra prioridad',
    'settings': 'Ajustes',
    'manage': 'Administra tu cuenta y preferencias',
    'profile': 'Información del perfil',
    'profileSub': 'Actualiza tus datos personales y profesionales',
    'name': 'Nombre',
    'specialty': 'Especialidad',
    'email': 'Correo',
    'phone': 'Teléfono',
    'edit': 'Editar perfil',
    'pass': 'Cambiar contraseña',
    'passSub': 'Actualiza tu contraseña con regularidad',
    'sessions': 'Sesiones activas',
    'sessionsSub': 'Administra tus dispositivos conectados',
    'notif': 'Notificaciones',
    'notifSub': 'Elige qué notificaciones quieres recibir',
    'appt': 'Recordatorios de citas',
    'apptSub': 'Recordatorios de próximas citas',
    'msgs': 'Mensajes de pacientes',
    'msgsSub': 'Recibe mensajes de tus pacientes',
    'meds': 'Alertas de medicación',
    'medsSub': 'Alertas sobre cambios en los medicamentos',
    'look': 'Apariencia',
    'lookSub': 'Personaliza el aspecto de la app',
    'theme': 'Tema',
    'light': 'Claro',
    'dark': 'Oscuro',
    'system': 'Sistema',
    'language': 'Idioma',
    'languageSub': 'Elige tu idioma preferido',
    'logout': 'Cerrar sesión',
    'save': 'Guardar cambios',
    'home': 'Inicio',
    'patients': 'Mis pacientes',
    'appointments': 'Citas',
    'nav': 'Ajustes',
    'saved': 'Guardado',
  },
  'de': {
    'tagline': 'Ihre Gesundheit .. Unsere Priorität',
    'settings': 'Einstellungen',
    'manage': 'Konto und Einstellungen verwalten',
    'profile': 'Profilinformationen',
    'profileSub': 'Persönliche und berufliche Angaben aktualisieren',
    'name': 'Name',
    'specialty': 'Fachgebiet',
    'email': 'E-Mail',
    'phone': 'Telefon',
    'edit': 'Profil bearbeiten',
    'pass': 'Passwort ändern',
    'passSub': 'Passwort regelmäßig aktualisieren',
    'sessions': 'Aktive Sitzungen',
    'sessionsSub': 'Angemeldete Geräte verwalten',
    'notif': 'Benachrichtigungen',
    'notifSub': 'Wählen Sie, was Sie erhalten möchten',
    'appt': 'Terminerinnerungen',
    'apptSub': 'Erinnerungen an kommende Termine',
    'msgs': 'Patientennachrichten',
    'msgsSub': 'Nachrichten von Ihren Patienten erhalten',
    'meds': 'Medikamentenwarnungen',
    'medsSub': 'Warnungen zu Medikamenten-Updates',
    'look': 'Darstellung',
    'lookSub': 'Aussehen der App anpassen',
    'theme': 'Design',
    'light': 'Hell',
    'dark': 'Dunkel',
    'system': 'System',
    'language': 'Sprache',
    'languageSub': 'Bevorzugte Sprache wählen',
    'logout': 'Abmelden',
    'save': 'Änderungen speichern',
    'home': 'Start',
    'patients': 'Meine Patienten',
    'appointments': 'Termine',
    'nav': 'Einstellungen',
    'saved': 'Gespeichert',
  },
};

String t(String key) => words[lang.value]![key]!;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: lang,
      builder: (context, l, child) {
        return ValueListenableBuilder(
          valueListenable: themeMode,
          builder: (context, mode, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: mode,
              builder: (context, child) {
                return Directionality(
                  textDirection: l == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                  child: child!,
                );
              },
              theme: ThemeData(
                colorSchemeSeed: mainColor,
                scaffoldBackgroundColor: const Color(0xFFEAF5F4),
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                colorSchemeSeed: mainColor,
                scaffoldBackgroundColor: const Color(0xFF111A1A),
              ),
              home: const RegisterScreen(),
            );
          },
        );
      },
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool appt = true;
  bool msgs = true;
  bool meds = true;
  int tab = 3;

  bool get dark => Theme.of(context).brightness == Brightness.dark;
  Color get cardColor => dark ? const Color(0xFF1B2727) : Colors.white.withOpacity(0.75);
  Color get grey => dark ? Colors.white60 : Colors.black54;

  Widget iconCircle(IconData icon, {double size = 44}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF244140) : lightColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: mainColor, size: size * 0.5),
    );
  }

  Widget card(Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }

  Widget cardTitle(IconData icon, String title, String sub) {
    return Row(
      children: [
        iconCircle(icon),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              Text(sub, style: TextStyle(fontSize: 12, color: grey)),
            ],
          ),
        ),
      ],
    );
  }

  Widget topBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          const Icon(Icons.monitor_heart, color: mainColor, size: 44),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Healix',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: mainColor)),
                Text(t('tagline'), style: TextStyle(fontSize: 12, color: grey)),
              ],
            ),
          ),
          Stack(
            children: [
              const Icon(Icons.notifications_none, size: 28),
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          profileAvatar(40),
          const Icon(Icons.keyboard_arrow_down, size: 18),
        ],
      ),
    );
  }

  Widget titleBar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            dark ? const Color(0xFF111A1A) : const Color(0xFFEAF5F4),
            dark ? const Color(0xFF1F3A38) : const Color(0xFFBFE3DF),
          ],
        ),
      ),
      child: Row(
        children: [
          iconCircle(Icons.settings_outlined, size: 48),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t('settings'), style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                Text(t('manage'), style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
          const Icon(Icons.eco, size: 54, color: Color(0x553BA89F)),
        ],
      ),
    );
  }

  Widget infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: mainColor),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 11, color: grey)),
                Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profileCard() {
    return card(
      Column(
        children: [
          cardTitle(Icons.person_outline, t('profile'), t('profileSub')),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      profileAvatar(100),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () => pickPhoto(context, (path) => setState(() => session.photoPath = path)),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: mainColor,
                            child: const Icon(Icons.photo_camera_outlined, size: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit_outlined, size: 16),
                    label: Text(t('edit')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  children: [
                    infoRow(Icons.person_outline, t('name'), session.name),
                    infoRow(Icons.work_outline, t('specialty'), session.specialty),
                    infoRow(Icons.mail_outline, t('email'), session.email),
                    infoRow(Icons.phone_outlined, t('phone'), session.phone),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget arrowRow(IconData icon, String title, String sub) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: mainColor),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(sub, style: TextStyle(fontSize: 11, color: grey)),
                ],
              ),
            ),
            Icon(
              lang.value == 'ar' ? Icons.chevron_left : Icons.chevron_right,
              color: grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget switchRow(IconData icon, String title, String sub, bool value, Function(bool) onChange) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: mainColor),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(sub, style: TextStyle(fontSize: 11, color: grey)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: (v) => onChange(v),
            activeColor: Colors.white,
            activeTrackColor: mainColor,
          ),
        ],
      ),
    );
  }

  Widget themeButton(String text, IconData icon, ThemeMode mode) {
    bool selected = themeMode.value == mode;
    return Expanded(
      child: GestureDetector(
        onTap: () => themeMode.value = mode,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? (dark ? const Color(0xFF244140) : lightColor) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: selected ? mainColor : Colors.transparent),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: selected ? mainColor : grey),
              const SizedBox(width: 4),
              Text(text, style: TextStyle(fontSize: 12, color: selected ? mainColor : grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget appearanceCard() {
    return card(
      Column(
        children: [
          cardTitle(Icons.palette_outlined, t('look'), t('lookSub')),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(t('theme'), style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 6),
              themeButton(t('light'), Icons.wb_sunny_outlined, ThemeMode.light),
              themeButton(t('dark'), Icons.nightlight_outlined, ThemeMode.dark),
              themeButton(t('system'), Icons.desktop_windows_outlined, ThemeMode.system),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              iconCircle(Icons.language, size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t('language'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(t('languageSub'), style: TextStyle(fontSize: 11, color: grey)),
                  ],
                ),
              ),
              DropdownButton<String>(
                value: lang.value,
                underline: const SizedBox(),
                items: flags.keys.map((code) {
                  return DropdownMenuItem(
                    value: code,
                    child: Text('${flags[code]![0]}  ${flags[code]![1]}'),
                  );
                }).toList(),
                onChanged: (v) {
                  lang.value = v!;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: lang,
      builder: (context, l, child) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              topBar(),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    titleBar(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          profileCard(),
                          card(Column(
                            children: [
                              arrowRow(Icons.lock_outline, t('pass'), t('passSub')),
                              arrowRow(Icons.devices, t('sessions'), t('sessionsSub')),
                            ],
                          )),
                          card(Column(
                            children: [
                              cardTitle(Icons.notifications_none, t('notif'), t('notifSub')),
                              const SizedBox(height: 4),
                              switchRow(Icons.calendar_month_outlined, t('appt'), t('apptSub'), appt,
                                      (v) => setState(() => appt = v)),
                              switchRow(Icons.chat_bubble_outline, t('msgs'), t('msgsSub'), msgs,
                                      (v) => setState(() => msgs = v)),
                              switchRow(Icons.medication_outlined, t('meds'), t('medsSub'), meds,
                                      (v) => setState(() => meds = v)),
                            ],
                          )),
                          appearanceCard(),
                          InkWell(
                            onTap: () => logout(context),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                              child: Row(
                                children: [
                                  const Icon(Icons.logout),
                                  const SizedBox(width: 14),
                                  Text(t('logout'), style: const TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 6),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t('saved'))));
                    },
                    icon: const Icon(Icons.save_outlined),
                    label: Text(t('save'), style: const TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: tab,
          onDestinationSelected: (i) => setState(() => tab = i),
          indicatorColor: Colors.transparent,
          destinations: [
            NavigationDestination(icon: const Icon(Icons.home_outlined), label: t('home')),
            NavigationDestination(icon: const Icon(Icons.person_outline), label: t('patients')),
            NavigationDestination(icon: const Icon(Icons.calendar_month_outlined), label: t('appointments')),
            NavigationDestination(
              icon: const Icon(Icons.settings_outlined, color: mainColor),
              label: t('nav'),
            ),
          ],
        ),
      ),
    );
  }
}