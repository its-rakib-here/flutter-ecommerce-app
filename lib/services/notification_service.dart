import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static Future<String> getDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    return token ?? "";
  }
}
