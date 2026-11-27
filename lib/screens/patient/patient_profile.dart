
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  State<PatientProfileScreen> createState() =>
      _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  bool _isLoading = true;
  String _fullName = '';
  String _email = '';
  String _phoneNumber = '';
  List<Map<String, dynamic>> _allergies = [];
  List<Map<String, dynamic>> _medications = [];
  Future<void> _loadPatientData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return;
      }

      final document = await FirebaseFirestore.instance
          .collection('patients')
          .doc(user.uid)
          .get();

      if (document.exists) {
        final data = document.data()!;

        if (!mounted) return;

        setState(() {
          _fullName = data['fullName'] ?? '';
          _email = data['email'] ?? '';
          _phoneNumber = data['phoneNumber'] ?? '';
        });
        final allergiesSnapshot = await FirebaseFirestore.instance
            .collection('patients')
            .doc(user.uid)
            .collection('allergies')
            .get();

        if (!mounted) return;

        setState(() {
          _allergies = allergiesSnapshot.docs
              .map((doc) => doc.data())
              .toList();
        });
        final medicationsSnapshot = await FirebaseFirestore.instance
            .collection('patients')
            .doc(user.uid)
            .collection('medications')
            .get();

        if (!mounted) return;

        setState(() {
          _medications = medicationsSnapshot.docs
              .map((doc) => doc.data())
              .toList();
        });
      } else {
        debugPrint('Patient document not found in Firestore');
      }
    } catch (e) {
      debugPrint('Error loading patient data: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  @override
  void initState() {
    super.initState();
    _loadPatientData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF078F95),
                      Color(0xFF16A6A2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 38,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 45,
                            color: Color(0xFF078F95),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Patient Profile',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                _isLoading ? 'Loading...' : (_fullName.isEmpty ? 'Patient Name' : _fullName) ,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Patient ID: PT-2025-001',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Color(0xFF16A36A),
                            size: 17,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Active',
                            style: TextStyle(
                              color: Color(0xFF16A36A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Personal Information
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4FBFB),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF078F95).withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF078F95),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: _infoItem(
                              Icons.calendar_month,
                              'Date of Birth',
                              '15 Mar 1998',
                            ),
                          ),
                          Expanded(
                            child: _infoItem(
                              Icons.person_outline,
                              'Gender',
                              'Male',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          Expanded(
                            child: _infoItem(
                              Icons.water_drop_outlined,
                              'Blood Type',
                              'O+',
                            ),
                          ),
                          Expanded(
                            child: _infoItem(
                              Icons.height,
                              'Height',
                              '175 cm',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      _infoItem(
                        Icons.monitor_weight_outlined,
                        'Weight',
                        '75 kg',
                      ),
                    ],
                  ),
                ),
              ),

              // Medical Information
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4FBFB),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF078F95).withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Medical Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF078F95),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _infoItem(
                        Icons.medical_information_outlined,
                        'Chronic Conditions',
                        'Diabetes',
                      ),
                      const SizedBox(height: 20),
                      _pillInfoItem(
                        'Current Medications',
                        'Metformin 500 mg',
                      ),
                      const SizedBox(height: 20),
                      _infoItem(
                        Icons.person_outline,
                        'Primary Doctor',
                        'Dr. Amr Atef',
                      ),
                      const SizedBox(height: 20),
                      _infoItem(
                        Icons.calendar_month,
                        'Last Checkup',
                        '10 Nov 2026',
                      ),
                    ],
                  ),
                ),
              ),

              // Contact Information
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4FBFB),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF078F95).withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Contact Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF078F95),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _infoItem(
                          Icons.email_outlined,
                          'Email Address',
                          _email
                      ),
                      const SizedBox(height: 20),
                      _infoItem(
                          Icons.phone_outlined,
                          'Phone Number',
                          _phoneNumber                      ),
                      const SizedBox(height: 20),
                      _infoItem(
                        Icons.location_on_outlined,
                        'Address',
                        'Cairo, Egypt',
                      ),
                    ],
                  ),
                ),
              ),

              // Allergies
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4FBFB),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF078F95).withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Allergies',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF078F95),
                        ),
                      ),
                      const SizedBox(height: 18),
                      if (_isLoading)
                        const CircularProgressIndicator()
                      else if (_allergies.isEmpty)
                        const Text(
                          'No allergies recorded',
                          style: TextStyle(color: Color(0xFF81969E)),
                        )
                      else
                        ..._allergies.map((allergy) {
                          final name = allergy['name'] ?? 'Unknown';
                          final riskLevel = allergy['riskLevel'] ?? 'Not specified';

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.warning_amber_rounded,
                                  color: Color(0xFFE59A32),
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    name.toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF183F59),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF0E5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '$riskLevel Risk',
                                    style: const TextStyle(
                                      color: Color(0xFFD97736),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    ],
                  ),
                ),
              ),

              // Current Medications
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4FBFB),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF078F95).withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current Medications',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF078F95),
                        ),
                      ),
                      const SizedBox(height: 18),

                      if (_isLoading)
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                      else if (_medications.isEmpty)
                        const Text(
                          'No medications recorded',
                          style: TextStyle(
                            color: Color(0xFF81969E),
                          ),
                        )
                      else
                        ..._medications.map((medication) {
                          final name = medication['name'] ?? 'Unknown';
                          final dosage = medication['dosage'] ?? '';
                          final frequency = medication['frequency'] ?? '';

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: _pillInfoItem(
                              name.toString(),
                              '$dosage - $frequency',
                            ),
                          );
                        }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF078F95),
        unselectedItemColor: const Color(0xFF9EADB3),
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _pillIcon(const Color(0xFF9EADB3)),
            activeIcon: _pillIcon(const Color(0xFF078F95)),
            label: 'Medications',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            activeIcon: Icon(Icons.article),
            label: 'Medical Posts',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Regular information item
  Widget _infoItem(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color(0xFF078F95),
          size: 22,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF81969E),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF183F59),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Medication item with a pill drawing
  Widget _pillInfoItem(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pillIcon(const Color(0xFF078F95)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF81969E),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF183F59),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Custom pill shape
  Widget _pillIcon(Color color) {
    return Transform.rotate(
      angle: -0.7,
      child: Container(
        width: 25,
        height: 13,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color,
            width: 1.8,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Container(
              width: 1.5,
              color: color,
            ),
            const Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}