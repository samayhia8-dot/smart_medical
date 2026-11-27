
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_medication_system/screens/doctor/doctor_translator.dart';
class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  final Color primaryColor = const Color(0xFF008F83);

  Future<void> callEmergency() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '112');

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> shareLocation(BuildContext context) async {
    bool serviceEnabled =
    await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('enable_location_msg'.tr())),
      );
      return;
    }

    LocationPermission permission =
    await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('location_denied_msg'.tr())),
      );
      return;
    }

    Position position =
    await Geolocator.getCurrentPosition();

    String location =
        '${'my_location_text'.tr()}: https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';

    await Share.share(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F7),
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.favorite_outline, size: 30),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Healix',
                  style: TextStyle(fontSize: 19),
                ),
                Text(
                  'Your Health .. Our Priority',
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            const SizedBox(height: 35),

            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.06),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emergency,
                color: Colors.red,
                size: 95,
              ),
            ),

            const SizedBox(height: 25),

            Text(
              'emergency_title'.tr(),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF17243B),
              ),
            ),

            const SizedBox(height: 10),

             Text(
               'emergency_sub'.tr(),
               textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 85,
              child: ElevatedButton(
                onPressed: callEmergency,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD91F32),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child:  Row(
                  children: [
                    Icon(Icons.phone, size: 30),
                    SizedBox(width: 25),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'call_emergency'.tr(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'emergency_num_sub'.tr(),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 20),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 75,
              child: OutlinedButton(
                onPressed: () => shareLocation(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  side: const BorderSide(color: Colors.black12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFFE0F0EA),
                      child: Icon(
                        Icons.location_on,
                        color: primaryColor,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 18),
                     Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'share_location'.tr(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'find_faster_sub'.tr(),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 18),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF2EF),
                borderRadius: BorderRadius.circular(18),
              ),
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.verified_user_outlined,
                    color: Color(0xFF008F83),
                    size: 28,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'safety_title'.tr(),
                          style: TextStyle(
                            color: Color(0xFF008F83),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'safety_desc'.tr(),
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.5,
                            color: Colors.black54,
                          ),
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
    );
  }
}