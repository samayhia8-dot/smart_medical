import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings = InitializationSettings(
      android: androidSettings,
    );

    await _localNotifications.initialize(settings: settings);

    const channel = AndroidNotificationChannel(
      'healix_chat_channel',
      'Healix Chat Messages',
      description: 'Notifications for new chat messages',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    _messaging.onRegistered.listen((token) {
      _saveTokenToFirestore(token);
    });

    await saveToken();

    FirebaseMessaging.onMessage.listen((message) async {
      final notification = message.notification;

      if (notification == null) return;

      await _localNotifications.show(
        id: message.hashCode,
        title: notification.title ?? 'Healix',
        body: notification.body ?? 'لديك رسالة جديدة',
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'healix_chat_channel',
            'Healix Chat Messages',
            channelDescription: 'Notifications for new chat messages',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
      );
    });
  }

  Future<void> saveToken() async {
    await _messaging.register();
  }

  Future<void> _saveTokenToFirestore(String token) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final uid = user.uid;

    final patientRef = _firestore.collection('patients').doc(uid);
    final doctorRef = _firestore.collection('doctors').doc(uid);

    final patient = await patientRef.get();

    if (patient.exists) {
      await patientRef.set({
        'fcmTokens': FieldValue.arrayUnion([token]),
      }, SetOptions(merge: true));
      return;
    }

    final doctor = await doctorRef.get();

    if (doctor.exists) {
      await doctorRef.set({
        'fcmTokens': FieldValue.arrayUnion([token]),
      }, SetOptions(merge: true));
    }
  }
}
