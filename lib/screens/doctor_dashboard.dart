import 'package:flutter/material.dart';

const kTeal = Color(0xFF009C9C);
const kBlue = Color(0xFF0A5BA5);
const kBg = Color(0xFFF2FCFC);

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

  final List<Map<String, String>> appointments = const [
  {
    'name': 'Sarah Mohamed',
    'id': '#P-1042',
    'time': '09:00 AM',
    'type': 'Follow-up Consultation',
    'status': 'Confirmed',
    'image': 'patient_female.png',
  },
  {
    'name': 'Omar Hassan',
    'id': '#P-1038',
    'time': '10:30 AM',
    'type': 'New Consultation',
    'status': 'Pending',
    'image': 'patient_male.png',
  },
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              _header(),
              const SizedBox(height: 12),
              _welcomeCard(),
              const SizedBox(height: 12),
              _statsRow(),
              const SizedBox(height: 14),
              _appointmentsCard(),
              const SizedBox(height: 14),
              _quickActionsCard(),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: kTeal,
        unselectedItemColor: kBlue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'My Patients'),
          BottomNavigationBarItem(
              icon: Icon(Icons.event_available), label: 'Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Image.asset('assets/images/7c2f57a9-2c62-48d5-8175-fdd5e2cbd353(1).png', height: 55),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Healix',
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold, color: kTeal)),
              Text('Your Health .. Our Priority',
                  style: TextStyle(fontSize: 12, color: kTeal)),
            ],
          ),
        ),
        Stack(
          children: const [
            Icon(Icons.notifications_none, size: 30, color: kBlue),
            Positioned(
              right: 4,
              top: 2,
              child: CircleAvatar(radius: 4.5, backgroundColor: Colors.redAccent),
            ),
          ],
        ),
        const SizedBox(width: 12),
        const CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage('assets/images/male_doctor.png'),
        ),
      ],
    );
  }

  Widget _welcomeCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [kTeal, Color(0xFF3DBFC4)]),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Stack(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 48,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 44,
                  backgroundImage: AssetImage('assets/images/male_doctor.png'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Good Morning!',
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                    const SizedBox(height: 4),
                    const Text('Dr. Ahmed El-Sayed',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    const Text('Your dedication makes a healthier tomorrow.',
                        style: TextStyle(color: Colors.white, fontSize: 11)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text('Specialty: General Practitioner',
                          style: TextStyle(
                              color: kTeal,
                              fontSize: 11,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statsRow() {
    return Row(
      children: [
        _statCard(Icons.people_outline, 'Total Patients', '48', '↑ 3 new this week'),
        const SizedBox(width: 8),
        _statCard(Icons.event_available, "Today's Appointments", '6', '2 upcoming'),
        const SizedBox(width: 8),
        _statCard(Icons.star, 'Average Rating', '4.8', 'Based on 32 reviews'),
      ],
    );
  }

  Widget _statCard(IconData icon, String title, String number, String sub) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFD4F1F1))),
        child: Column(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: const Color(0xFFE0F7F7),
              child: Icon(icon, color: kTeal),
            ),
            const SizedBox(height: 8),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: Colors.black54)),
            Text(number,
                style: const TextStyle(
                    fontSize: 26, fontWeight: FontWeight.bold, color: kBlue)),
            Text(sub,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, color: kTeal)),
          ],
        ),
      ),
    );
  }

  Widget _appointmentsCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.event_available, color: kTeal),
              SizedBox(width: 8),
              Expanded(
                child: Text('Upcoming Appointments',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: kBlue)),
              ),
              Text('View All >', style: TextStyle(color: kTeal, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 10),
          ListView.builder(
              shrinkWrap: true,                           // ← مهم
              physics: const NeverScrollableScrollPhysics(), // ← مهم
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final a = appointments[index];
                return _appointmentRow(a);
              },
            ),
        ],
      ),
    );
  }
Widget _appointmentRow(Map<String, String> a) {
  bool confirmed = a['status'] == 'Confirmed';
  Color statusColor = confirmed ? Colors.green : Colors.orange;

  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
        color: const Color(0xFFF4FAFA),
        borderRadius: BorderRadius.circular(14)),
    child: Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/images/${a['image']}'),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(a['name']!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: kBlue)),
              Text('Patient ID: ${a['id']}',
                  style: const TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        ),
        Text(a['time']!,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: kBlue)),
        const SizedBox(width: 6),
        Expanded(
          flex: 2,
          child: Text(a['type']!,
              style: const TextStyle(fontSize: 10, color: kBlue)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
              color: statusColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20)),
          child: Text(a['status']!,
              style: TextStyle(fontSize: 11, color: statusColor)),
        ),
        const Icon(Icons.chevron_right, size: 18, color: kTeal),
      ],
    ),
  );
}

  Widget _quickActionsCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFD4F1F1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.bolt, color: kTeal),
              SizedBox(width: 6),
              Text('Quick Actions',
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold, color: kBlue)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _action(Icons.description, 'Posts\nView posts', Colors.lightBlue),
              _action(Icons.event_available, 'Add Appointment', Colors.teal),
              _action(Icons.chat_bubble_outline, 'Chat with\nPatient', Colors.deepPurple),
              _action(Icons.auto_awesome, 'AI Assistant', Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _action(IconData icon, String title, Color color) {
    return Expanded(
      child: Container(
        height: 90,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(14)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 6),
            Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: color)),
          ],
        ),
      ),
    );
  }
}