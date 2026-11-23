import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'doctor_settings.dart';

class Session {
  String name = '';
  String specialty = '';
  String email = '';
  String phone = '';
  String password = '';
  String licenseNo = '';
  String? photoPath;
  String? licensePath;
  String? idPath;
  bool registered = false;
}

final session = Session();

final authWords = {
  'ar': {
    'regTitle': 'تسجيل طبيب جديد',
    'regSub': 'أنشئ حسابك المهني',
    'photo': 'الصورة الشخصية',
    'fullName': 'الاسم بالكامل',
    'specialty': 'التخصص',
    'email': 'البريد الإلكتروني',
    'phone': 'رقم الهاتف',
    'password': 'كلمة المرور',
    'confirm': 'تأكيد كلمة المرور',
    'licenseNo': 'رقم ترخيص مزاولة المهنة',
    'licenseDoc': 'صورة ترخيص مزاولة المهنة',
    'idDoc': 'صورة البطاقة الشخصية',
    'upload': 'اضغط للرفع',
    'uploaded': 'تم الرفع',
    'camera': 'الكاميرا',
    'gallery': 'المعرض',
    'register': 'تسجيل',
    'haveAcc': 'لديك حساب؟ سجّل الدخول',
    'noAcc': 'ليس لديك حساب؟ سجّل الآن',
    'loginTitle': 'تسجيل الدخول',
    'loginSub': 'أهلًا بعودتك يا دكتور',
    'login': 'دخول',
    'required': 'هذا الحقل مطلوب',
    'mismatch': 'كلمتا المرور غير متطابقتين',
    'short': 'كلمة المرور 6 أحرف على الأقل',
    'badEmail': 'البريد الإلكتروني غير صحيح',
    'wrong': 'البريد أو كلمة المرور غير صحيحة',
    'missing': 'ارفع الصورة وترخيص المزاولة والبطاقة',
    'done': 'تم التسجيل بنجاح',
    'noAccount': 'لا يوجد حساب، سجّل أولًا',
    'cantOpen': 'تعذر فتح الكاميرا أو المعرض',
  },
  'en': {
    'regTitle': 'Doctor Registration',
    'regSub': 'Create your professional account',
    'photo': 'Profile photo',
    'fullName': 'Full name',
    'specialty': 'Specialty',
    'email': 'Email',
    'phone': 'Phone',
    'password': 'Password',
    'confirm': 'Confirm password',
    'licenseNo': 'Medical license number',
    'licenseDoc': 'Medical license photo',
    'idDoc': 'National ID photo',
    'upload': 'Tap to upload',
    'uploaded': 'Uploaded',
    'camera': 'Camera',
    'gallery': 'Gallery',
    'register': 'Register',
    'haveAcc': 'Have an account? Login',
    'noAcc': "Don't have an account? Register",
    'loginTitle': 'Login',
    'loginSub': 'Welcome back, doctor',
    'login': 'Login',
    'required': 'This field is required',
    'mismatch': 'Passwords do not match',
    'short': 'Password must be at least 6 characters',
    'badEmail': 'Invalid email address',
    'wrong': 'Wrong email or password',
    'missing': 'Upload your photo, license and ID',
    'done': 'Registered successfully',
    'noAccount': 'No account found, register first',
    'cantOpen': 'Could not open camera or gallery',
  },
  'fr': {
    'regTitle': 'Inscription du médecin',
    'regSub': 'Créez votre compte professionnel',
    'photo': 'Photo de profil',
    'fullName': 'Nom complet',
    'specialty': 'Spécialité',
    'email': 'E-mail',
    'phone': 'Téléphone',
    'password': 'Mot de passe',
    'confirm': 'Confirmer le mot de passe',
    'licenseNo': "Numéro de licence d'exercice",
    'licenseDoc': "Photo de la licence d'exercice",
    'idDoc': "Photo de la carte d'identité",
    'upload': 'Appuyez pour téléverser',
    'uploaded': 'Téléversé',
    'camera': 'Caméra',
    'gallery': 'Galerie',
    'register': "S'inscrire",
    'haveAcc': 'Déjà un compte ? Connexion',
    'noAcc': "Pas de compte ? Inscrivez-vous",
    'loginTitle': 'Connexion',
    'loginSub': 'Bon retour, docteur',
    'login': 'Se connecter',
    'required': 'Ce champ est obligatoire',
    'mismatch': 'Les mots de passe ne correspondent pas',
    'short': '6 caractères minimum',
    'badEmail': 'E-mail invalide',
    'wrong': 'E-mail ou mot de passe incorrect',
    'missing': 'Ajoutez la photo, la licence et la carte',
    'done': 'Inscription réussie',
    'noAccount': "Aucun compte, inscrivez-vous d'abord",
    'cantOpen': "Impossible d'ouvrir la caméra ou la galerie",
  },
  'es': {
    'regTitle': 'Registro de médico',
    'regSub': 'Crea tu cuenta profesional',
    'photo': 'Foto de perfil',
    'fullName': 'Nombre completo',
    'specialty': 'Especialidad',
    'email': 'Correo',
    'phone': 'Teléfono',
    'password': 'Contraseña',
    'confirm': 'Confirmar contraseña',
    'licenseNo': 'Número de licencia médica',
    'licenseDoc': 'Foto de la licencia médica',
    'idDoc': 'Foto del documento de identidad',
    'upload': 'Toca para subir',
    'uploaded': 'Subido',
    'camera': 'Cámara',
    'gallery': 'Galería',
    'register': 'Registrarse',
    'haveAcc': '¿Tienes cuenta? Inicia sesión',
    'noAcc': '¿No tienes cuenta? Regístrate',
    'loginTitle': 'Iniciar sesión',
    'loginSub': 'Bienvenido de nuevo, doctor',
    'login': 'Entrar',
    'required': 'Este campo es obligatorio',
    'mismatch': 'Las contraseñas no coinciden',
    'short': 'Mínimo 6 caracteres',
    'badEmail': 'Correo no válido',
    'wrong': 'Correo o contraseña incorrectos',
    'missing': 'Sube tu foto, licencia y documento',
    'done': 'Registro completado',
    'noAccount': 'No hay cuenta, regístrate primero',
    'cantOpen': 'No se pudo abrir la cámara o la galería',
  },
  'de': {
    'regTitle': 'Arzt-Registrierung',
    'regSub': 'Erstellen Sie Ihr Berufskonto',
    'photo': 'Profilfoto',
    'fullName': 'Vollständiger Name',
    'specialty': 'Fachgebiet',
    'email': 'E-Mail',
    'phone': 'Telefon',
    'password': 'Passwort',
    'confirm': 'Passwort bestätigen',
    'licenseNo': 'Approbationsnummer',
    'licenseDoc': 'Foto der Approbation',
    'idDoc': 'Foto des Personalausweises',
    'upload': 'Zum Hochladen tippen',
    'uploaded': 'Hochgeladen',
    'camera': 'Kamera',
    'gallery': 'Galerie',
    'register': 'Registrieren',
    'haveAcc': 'Schon ein Konto? Anmelden',
    'noAcc': 'Noch kein Konto? Registrieren',
    'loginTitle': 'Anmelden',
    'loginSub': 'Willkommen zurück, Doktor',
    'login': 'Anmelden',
    'required': 'Pflichtfeld',
    'mismatch': 'Passwörter stimmen nicht überein',
    'short': 'Mindestens 6 Zeichen',
    'badEmail': 'Ungültige E-Mail',
    'wrong': 'E-Mail oder Passwort falsch',
    'missing': 'Foto, Approbation und Ausweis hochladen',
    'done': 'Erfolgreich registriert',
    'noAccount': 'Kein Konto, bitte zuerst registrieren',
    'cantOpen': 'Kamera oder Galerie nicht verfügbar',
  },
};

String tr(String key) => authWords[lang.value]![key]!;

void say(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

Future<void> takeImage(BuildContext context, ImageSource source, Function(String) onPicked) async {
  try {
    final file = await ImagePicker().pickImage(source: source, imageQuality: 80, maxWidth: 1600);
    if (file != null) {
      onPicked(file.path);
    }
  } catch (e) {
    if (context.mounted) {
      say(context, tr('cantOpen'));
    }
  }
}

void pickPhoto(BuildContext context, Function(String) onPicked) {
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    takeImage(context, ImageSource.gallery, onPicked);
    return;
  }
  showModalBottomSheet(
    context: context,
    builder: (sheetContext) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined, color: mainColor),
              title: Text(tr('camera')),
              onTap: () {
                Navigator.pop(sheetContext);
                takeImage(context, ImageSource.camera, onPicked);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined, color: mainColor),
              title: Text(tr('gallery')),
              onTap: () {
                Navigator.pop(sheetContext);
                takeImage(context, ImageSource.gallery, onPicked);
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget avatarFrom(String? path, double size) {
  return ClipOval(
    child: Container(
      width: size,
      height: size,
      color: lightColor,
      child: path == null
          ? Icon(Icons.person, size: size * 0.6, color: mainColor)
          : Image.file(File(path), fit: BoxFit.cover),
    ),
  );
}

Widget profileAvatar(double size) {
  return avatarFrom(session.photoPath, size);
}

void logout(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
  );
}

Widget langMenu() {
  return DropdownButton<String>(
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
  );
}

Widget input(
    TextEditingController controller,
    String label,
    IconData icon, {
      bool secret = false,
      TextInputType type = TextInputType.text,
      String? Function(String?)? check,
    }) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      controller: controller,
      obscureText: secret,
      keyboardType: type,
      validator: check ??
              (v) {
            if (v == null || v.trim().isEmpty) {
              return tr('required');
            }
            return null;
          },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: mainColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
  );
}

Widget mainButton(String text, VoidCallback onPressed) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    ),
  );
}

Widget logoHeader(String title, String sub) {
  return Column(
    children: [
      const Icon(Icons.monitor_heart, color: mainColor, size: 56),
      const Text('Healix', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: mainColor)),
      const SizedBox(height: 14),
      Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      const SizedBox(height: 4),
      Text(sub, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      const SizedBox(height: 18),
    ],
  );
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final specialty = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();
  final licenseNo = TextEditingController();

  String? photo;
  String? licensePath;
  String? idPath;

  Widget uploadBox(String title, String? path, Function(String) onPicked) {
    return GestureDetector(
      onTap: () => pickPhoto(context, onPicked),
      child: Container(
        height: 120,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: path == null ? Colors.grey : mainColor),
        ),
        child: path == null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_upload_outlined, color: mainColor, size: 34),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(tr('upload'), style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        )
            : Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.file(File(path), fit: BoxFit.cover),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(10)),
                child: Text(tr('uploaded'), style: const TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submit() {
    final valid = formKey.currentState!.validate();
    if (photo == null || licensePath == null || idPath == null) {
      say(context, tr('missing'));
      return;
    }
    if (!valid) {
      return;
    }
    session.name = name.text.trim();
    session.specialty = specialty.text.trim();
    session.email = email.text.trim().toLowerCase();
    session.phone = phone.text.trim();
    session.password = password.text;
    session.licenseNo = licenseNo.text.trim();
    session.photoPath = photo;
    session.licensePath = licensePath;
    session.idPath = idPath;
    session.registered = true;
    say(context, tr('done'));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: lang,
      builder: (context, l, child) {
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(18),
                children: [
                  Align(alignment: AlignmentDirectional.centerEnd, child: langMenu()),
                  logoHeader(tr('regTitle'), tr('regSub')),
                  Center(
                    child: GestureDetector(
                      onTap: () => pickPhoto(context, (path) => setState(() => photo = path)),
                      child: Stack(
                        children: [
                          avatarFrom(photo, 110),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 17,
                              backgroundColor: mainColor,
                              child: const Icon(Icons.photo_camera_outlined, size: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Center(child: Text(tr('photo'), style: const TextStyle(fontSize: 12, color: Colors.grey))),
                  const SizedBox(height: 14),
                  input(licenseNo, tr('licenseNo'), Icons.badge_outlined),
                  uploadBox(tr('licenseDoc'), licensePath, (path) => setState(() => licensePath = path)),
                  uploadBox(tr('idDoc'), idPath, (path) => setState(() => idPath = path)),
                  input(name, tr('fullName'), Icons.person_outline),
                  input(specialty, tr('specialty'), Icons.work_outline),
                  input(email, tr('email'), Icons.mail_outline,
                      type: TextInputType.emailAddress,
                      check: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return tr('required');
                        }
                        if (!v.contains('@')) {
                          return tr('badEmail');
                        }
                        return null;
                      }),
                  input(phone, tr('phone'), Icons.phone_outlined, type: TextInputType.phone),
                  input(password, tr('password'), Icons.lock_outline,
                      secret: true,
                      check: (v) {
                        if (v == null || v.isEmpty) {
                          return tr('required');
                        }
                        if (v.length < 6) {
                          return tr('short');
                        }
                        return null;
                      }),
                  input(confirm, tr('confirm'), Icons.lock_outline,
                      secret: true,
                      check: (v) {
                        if (v == null || v.isEmpty) {
                          return tr('required');
                        }
                        if (v != password.text) {
                          return tr('mismatch');
                        }
                        return null;
                      }),
                  const SizedBox(height: 6),
                  mainButton(tr('register'), submit),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                    },
                    child: Text(tr('haveAcc'), style: const TextStyle(color: mainColor)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController(text: session.email);
  final password = TextEditingController();

  void login() {
    if (!session.registered) {
      say(context, tr('noAccount'));
      return;
    }
    if (email.text.trim().toLowerCase() == session.email && password.text == session.password) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
    } else {
      say(context, tr('wrong'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: lang,
      builder: (context, l, child) {
        return Scaffold(
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(18),
              children: [
                Align(alignment: AlignmentDirectional.centerEnd, child: langMenu()),
                const SizedBox(height: 30),
                logoHeader(tr('loginTitle'), tr('loginSub')),
                input(email, tr('email'), Icons.mail_outline, type: TextInputType.emailAddress),
                input(password, tr('password'), Icons.lock_outline, secret: true),
                const SizedBox(height: 6),
                mainButton(tr('login'), login),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => const RegisterScreen()));
                  },
                  child: Text(tr('noAcc'), style: const TextStyle(color: mainColor)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}