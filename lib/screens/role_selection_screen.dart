import 'package:flutter/material.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? selectedRole;

  void selectRole(String role) {
    setState(() {

      selectedRole = role;
    });
  }

  void continueToNextScreen() {
    if (selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select Patient or Doctor'),
        ),
      );
      return;
    }

    if (selectedRole == 'patient') {
      Navigator.pushNamed(context, '/patientLogin');
    } else {
      Navigator.pushNamed(context, '/doctorLogin');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBFE),
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.fromLTRB(25, 35, 25, 25),
            decoration: BoxDecoration(
              color: const Color(0xFFF4FBFE),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                const SizedBox(height:5),

                // Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/Hospital mark.png',
                      width: 50,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width:1),
                    const Text(
                      'Healix',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003B6B),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                // Patient Card
                _roleCard(
                  role: 'patient',
                  title: "I'm a\nPatient",
                  description:
                  'Manage your medications,\nappointments, and medical\nrecords.',
                  icon: Icons.person_outline,
                  iconColor: const Color(0xFF008BD2),
                  backgroundIconColor: const Color(0xFFE7F6FD),
                ),

                const SizedBox(height: 18),

                // Doctor Card
                _roleCard(
                  role: 'doctor',
                  title: "I'm a\nDoctor",
                  description:
                  'Manage your patients,\nappointments, and prescriptions.',
                  icon: Icons.person_outline,
                  iconColor: const Color(0xFF00AA91),
                  backgroundIconColor: const Color(0xFFE7F8F4),
                ),

                const SizedBox(height: 32),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF008FD0),
                          Color(0xFF00AD8D),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      onPressed: continueToNextScreen,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Sign In
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF668294),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signIn');
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00A58A),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _roleCard({
    required String role,
    required String title,
    required String description,
    required IconData icon,
    required Color iconColor,
    required Color backgroundIconColor,
  }) {
    final bool isSelected = selectedRole == role;

    return GestureDetector(
      onTap: () => selectRole(role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 150,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected
                ? iconColor
                : const Color(0xFFC9E8F6),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Circle
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                color: backgroundIconColor,
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    icon,
                    size: 42,
                    color: iconColor,
                  ),
                  Positioned(
                    right: 1,
                    bottom: 10,
                    child: Container(
                      width: 21,
                      height: 21,
                      decoration: BoxDecoration(
                        color: iconColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.medical_services_outlined,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 14),

            // Text
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 19,
                      height: 1.25,
                      color: Color(0xFF003B6B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 10,
                      height: 1.35,
                      color: Color(0xFF78909C),
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF9FD),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chevron_right,
                color: iconColor,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}