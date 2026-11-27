import 'package:flutter/material.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  width: double.infinity,
                  height: 270,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF00A9B5), Color(0xFFB9F3F3)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),

                      Row(
                        children: [
                          const SizedBox(width: 20),
                          const Expanded(
                            child: Text(
                              'Profile',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(width: 40),
                        ],
                      ),

                      const SizedBox(height: 15),
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Color(0xFF00A9B5),
                        ),
                      ),
                      const Text(
                        'Dr . Amr Atef ',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF073B7A),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'General Practitioner',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF073B7A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xFFFFB800),
                              size: 18,
                            ),

                            const SizedBox(width: 6),

                            const Text(
                              '4.8 (532 reviews)',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF073B7A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Icon(Icons.people, color: Colors.teal),
                          const Text(
                            '2.5K+',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF073B7A),
                            ),
                          ),
                          const Text(
                            'Total Patients',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF073B7A),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Expanded(
                      child: Column(
                        children: [
                          Icon(Icons.calendar_month, color: Colors.teal),
                          Text(
                            '1.2K+',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF073B7A),
                            ),
                          ),

                          Text(
                            'Appointments',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF073B7A),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Expanded(
                      child: Column(
                        children: [
                          Icon(Icons.star, color: Colors.teal),
                          Text('4.8'),
                          Text('Rating'),
                        ],
                      ),
                    ),

                    const Expanded(
                      child: Column(
                        children: [
                          Icon(Icons.workspace_premium, color: Colors.teal),
                          Text('10+'),
                          Text('Years Exp.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.10),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFFD9F5F3),
                      child: Icon(
                        Icons.person,
                        color: Color(0xFF00A9B5),
                        size: 22,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'About Doctor',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF073B7A),
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'Dr. Amr Atef is a General Practitioner '
                                'with over 10 years of experience in '
                                'providing comprehensive healthcare.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF073B7A),
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 8),

                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Read More',
                                  style: TextStyle(
                                    color: Color(0xFF00A9B5),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xFF00A9B5),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.10),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Row(
                      children: [
                        const Icon(
                          Icons.medical_services,
                          color: Color(0xFF00A9B5),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Professional Information',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF073B7A),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Specialty
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFF00A9B5),
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Specialty',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF073B7A),
                            ),
                          ),
                        ),
                        const Text(
                          'General Practitioner',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF073B7A),
                          ),
                        ),
                      ],
                    ),

                    const Divider(height: 16, color: Color(0xFFE8F0F3)),

                    // Experience
                    Row(
                      children: [
                        const Icon(
                          Icons.workspace_premium,
                          color: Color(0xFF00A9B5),
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Experience',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF073B7A),
                            ),
                          ),
                        ),
                        const Text(
                          '10+ Years',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF073B7A),
                          ),
                        ),
                      ],
                    ),

                    const Divider(height: 16, color: Color(0xFFE8F0F3)),

                    // Clinic Location
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xFF00A9B5),
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Clinic Location',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF073B7A),
                            ),
                          ),
                        ),
                        const Text(
                          'Cairo, Egypt',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF073B7A),
                          ),
                        ),
                      ],
                    ),

                    const Divider(height: 16, color: Color(0xFFE8F0F3)),

                    // Working Hours
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Color(0xFF00A9B5),
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Working Hours',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF073B7A),
                            ),
                          ),
                        ),
                        const Text(
                          'Sat - Thu, 9:00 AM - 5:00 PM',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF073B7A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.10),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Row(
                        children: [
                          const Icon(
                            Icons.contact_phone,
                            color: Color(0xFF00A9B5),
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Contact Information',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF073B7A),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Phone
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Color(0xFF00A9B5),
                            size: 18,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Phone Number',
                              style: TextStyle(fontSize: 12, color: Color(0xFF073B7A)),
                            ),
                          ),
                          const Text(
                            '+201110224934',
                            style: TextStyle(fontSize: 12, color: Color(0xFF073B7A)),
                          ),
                        ],
                      ),

                      const Divider(height: 16, color: Color(0xFFE8F0F3)),

                      // Email
                      Row(
                        children: [
                          const Icon(
                            Icons.email,
                            color: Color(0xFF00A9B5),
                            size: 18,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Email Address',
                              style: TextStyle(fontSize: 12, color: Color(0xFF073B7A)),
                            ),
                          ),
                          SizedBox(width: 52,),
                          const Flexible(
                            child: Text(
                              'amea04651@gmail.com',
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: 12, color: Color(0xFF073B7A)),
                            ),
                          ),
                        ],
                      ),


                    ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}