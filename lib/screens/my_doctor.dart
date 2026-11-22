import 'package:flutter/material.dart';

const kTeal = Color(0xFF008B8B);
const kDark = Color(0xFF1F4E5F);
const kBg = Color(0xFFF4FBFB);

class MyDoctorScreen extends StatelessWidget {
  const MyDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:kTeal, 
      body: SafeArea(
        child: Column(
          children: [
            _appBar(context),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: kBg,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _doctorHeader(),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _title(Icons.local_hospital_outlined, 'Clinic Information'),
                            _clinicCard(),
                            const SizedBox(height: 20),
                            _title(Icons.monitor_heart_outlined, 'Specialty & Experience'),
                            _specialtyCard(),
                            const SizedBox(height: 20),
                            _title(Icons.calendar_month, 'Next Appointment'),
                            _appointmentCard(),
                            const SizedBox(height: 16),
                            _supportCard(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('My Doctor',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                Text('Your health is in good hands',
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.more_vert, color: Colors.white),
        ],
      ),
    );
  }

  Widget _doctorHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xFFE6F7F7)],
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 44,
                      backgroundImage:
                          AssetImage('assets/images/female_doctor.png'),
                    ),
                  ),
                  const Positioned(
                    right: 4,
                    bottom: 4,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                          radius: 6, backgroundColor:Colors.green),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Dr. Sarah Ahmed',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kDark)),
                    const Text('Cardiologist',
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                          color: const Color(0xFFD9F2EF),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text('Specialist',
                          style: TextStyle(color: kTeal, fontSize: 12)),
                    ),
                    const SizedBox(height: 6),
                    const Text('Better heart. A healthier tomorrow.',
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
          //const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kTeal,
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: kTeal),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  icon: const Icon(Icons.phone),
                  label: const Text('Call', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:kTeal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  icon: const Icon(Icons.chat_bubble),
                  label: const Text('Chat', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _title(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: kTeal),
          const SizedBox(width: 10),
          Text(text,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: kDark)),
        ],
      ),
    );
  }

  BoxDecoration _cardStyle() {
    return BoxDecoration(
      color: const Color(0xFFF7FCFC),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFD9ECEC)),
    );
  }

  Widget _clinicCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardStyle(),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Al-Nour Medical Center',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: kDark)),
                SizedBox(height: 4),
                Text('Cardiology Department',
                    style: TextStyle(color: Colors.grey)),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 18, color: Colors.grey),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text('123 Medical Street, Cairo, Egypt',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.phone, size: 18, color: Colors.grey),
                    SizedBox(width: 6),
                    Text('+20 2 2345 6789',
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset('assets/images/Clinic.png',
                width: 120, height: 90, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }

  Widget _specialtyCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardStyle(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Cardiology',
              style: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.bold, color: kDark)),
          const SizedBox(height: 4),
          const Text('Heart health • Hypertension • ECG • Cardiac Care',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 16),
          Row(
            children: [
              _info(Icons.school, 'Experience', '10+ years'),
              _info(Icons.edit_note, 'Education', 'M.D. - Cairo University'),
              _info(Icons.language, 'Languages', 'Arabic • English'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _info(IconData icon, String label, String value) {
    return Expanded(
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFDDF3F1),
            child: Icon(icon, size: 18, color: kTeal),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(fontSize: 10, color: Colors.grey)),
                Text(value,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: kDark)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _appointmentCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: const Color(0xFFE9F6F5),
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xFFD5EEEC),
            child: Icon(Icons.event, color: kTeal),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Tue, Oct 14, 2025',
                    style: TextStyle(fontWeight: FontWeight.w600, color: kDark)),
                Text('10:00 AM', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
                color: const Color(0xFFCDEEDD),
                borderRadius: BorderRadius.circular(20)),
            child: const Text('In 2 days',
                style: TextStyle(color: Colors.green, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _supportCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardStyle(),
      child: Row(
        children: const [
          CircleAvatar(
            radius: 32,
            backgroundColor: Color(0xFFD5EEEC),
            child: Icon(Icons.favorite, size: 36, color: kTeal),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Text(
              "Your doctor is here to support your health journey.\nDon't hesitate to reach out with any questions or concerns.",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}