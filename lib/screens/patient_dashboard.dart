import 'package:flutter/material.dart';

import '../doctor_settings.dart';
import '../emergency_screen.dart';
import 'chatai_screen.dart';

const kTeal = Color(0xFF009C9C);
const kDark = Color(0xFF0D4A57);
const kBg = Color(0xFFF0FBFB);

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  final List<Map<String, String>> meds = const [
  {
    'name': 'Metformin 500mg',
    'details': '08:00 AM • 1 Tablet • After Breakfast',
    'status': 'Taken',
  },
  {
    'name': 'Vitamin D 1000 IU',
    'details': '12:00 PM • 1 Capsule • After Lunch',
    'status': 'Upcoming',
  },
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 16),
              _welcomeCard(),
              const SizedBox(height: 16),
              _statsRow(),
              const SizedBox(height: 20),
              _sectionTitle(),
              const SizedBox(height: 12),

              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: meds.length,
                  itemBuilder: (context, index) {
                    final m = meds[index];
                    return _medCard(m);
                  },
                  ),
              const SizedBox(height: 8),
              _doctorCard(context),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Icon(Icons.bolt, color: Colors.orange),
                  SizedBox(width: 6),
                  Text('Quick Actions',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kDark)),
                ],
              ),
              const SizedBox(height: 12),
              _quickActions(),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Chatai()),
          );
        },
        backgroundColor: kTeal,
        shape: const CircleBorder(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.smart_toy_outlined, color: Colors.white),
            Text('AI', style: TextStyle(color: Colors.white, fontSize: 10)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: kTeal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.medication), label: 'Medications'),
          BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined), label: 'Medical Posts'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Image.asset('assets/images/7c2f57a9-2c62-48d5-8175-fdd5e2cbd353(1).png', height: 50),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Healix',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kTeal)),
              Text('Your Health .. Our Priority',
                  style: TextStyle(fontSize: 12, color: kTeal)),
            ],
          ),
        ),
        Stack(
          children: [
            const Icon(Icons.notifications_none, size: 30, color: kTeal),
            Positioned(
              right: 4,
              top: 2,
              child: Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                    color: Colors.redAccent, shape: BoxShape.circle),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/images/Patient.png'),
        ),
      ],
    );
  }

  Widget _welcomeCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [kTeal, Color(0xFF3DBFC4)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 37,
              backgroundImage: AssetImage('assets/images/Patient.png'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Good Morning,',
                    style: TextStyle(color: Colors.white, fontSize: 13)),
                const Text('Name',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text(
                    "Take care of your health, it's the most valuable thing you have.",
                    style: TextStyle(color: Colors.white, fontSize: 11)),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text('Patient ID: #P-1042',
                      style: TextStyle(
                          color: kTeal,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statsRow() {
    return Row(
      children: [
        _statCard(Icons.medication, 'Total\nMedications', '5', '+1 new',
            Colors.teal),
        const SizedBox(width: 8),
        _statCard(Icons.calendar_month, "Today's\nDoses", '3', '2 remaining',
            Colors.lightBlue),
        const SizedBox(width: 8),
        _statCard(Icons.check_circle, 'Completed\nDoses', '1', 'Great job!',
            Colors.green),
      ],
    );
  }

  Widget _statCard(
      IconData icon, String title, String number, String sub, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey)),
            Text(number,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: kDark)),
            Text(sub, style: const TextStyle(fontSize: 11, color: kTeal)),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle() {
    return Row(
      children: const [
        Icon(Icons.calendar_month, color: kTeal),
        SizedBox(width: 8),
        Expanded(
          child: Text("Today's Medication Schedule",
              style: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.bold, color: kDark)),
        ),
        Text('View All >', style: TextStyle(color: kTeal)),
      ],
    );
  }

Widget _medCard(Map<String, String> m) {
  final status = m['status']!;

  Color statusColor = Colors.blue;
  IconData statusIcon = Icons.access_time;
  if (status == 'Taken') {
    statusColor = Colors.green;
    statusIcon = Icons.check_circle;
  } else if (status == 'Missed') {
    statusColor = Colors.red;
    statusIcon = Icons.cancel;
  }

  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: statusColor.withOpacity(0.15),
          child: Icon(Icons.medication, color: statusColor),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(m['name']!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: kDark)),
              const SizedBox(height: 2),
              Text(m['details']!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.08),
            border: Border.all(color: statusColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(statusIcon, size: 14, color: statusColor),
              const SizedBox(width: 4),
              Text(status,
                  style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, color: Colors.grey),
      ],
    ),
  );
}
  Widget _doctorCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 38,
            backgroundImage: AssetImage('assets/images/female_doctor.png'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Your Doctor',
                    style: TextStyle(color: kTeal, fontSize: 12)),
                const Text('Dr. Sarah Ahmed',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kDark)),
                const Text('Cardiologist',
                    style: TextStyle(color: Colors.grey)),
                Row(
                  children: const [
                    Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                    SizedBox(width: 4),
                    Text('Next Appointment',
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const Text('Tomorrow - 10:00 AM',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: kDark)),
              ],
            ),
          ),
          Column(
            children: [
              OutlinedButton(
                onPressed: () {
                   Navigator.pushNamed(context, '/myDoctor');
                },
                style: OutlinedButton.styleFrom(
                    foregroundColor: kTeal,
                    side: const BorderSide(color: kTeal)),
                child: const Text('View Profile >',
                    style: TextStyle(fontSize: 11)),
              ),
              ElevatedButton.icon(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: kTeal, foregroundColor: Colors.white),
                icon: const Icon(Icons.chat_bubble_outline, size: 16),
                label:
                    const Text('Chat', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickActions() {
    return Row(
      children: [
        _actionCard(Icons.person, 'Profile', Colors.teal),
        const SizedBox(width: 10),
        _actionCard(Icons.chat_bubble_outline, 'Chat with Doctor', Colors.blue),
        const SizedBox(width: 10),
        _actionCard(Icons.description, 'Medical Posts', Colors.deepPurple),
      ],
    );
  }

  Widget _actionCard(IconData icon, String title, Color color) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 8),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: kDark)),
          ],
        ),
      ),
    );
  }
}