import '../Model/notification_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiDataProvidor {
  Future<List<Notification>> getNotifications(role) async {
    Map<String, String> roleToBaseUrl = {
      "trainee": "http://127.0.0.1:3050/notification/traineeUnread",
      "trainer": "http://127.0.0.1:3050/notification/trainerUnread",
    };

    try {
      final response = await http.get(Uri.parse(roleToBaseUrl[role]!));
      if (response.statusCode == 200) {
        final List<Notification> notifications = [];
        final List<dynamic> notificationsJson = json.decode(response.body);
        notificationsJson.forEach((notificationJson) {
          notifications.add(Notification.fromJson(notificationJson));
        });
        return notifications;
      } else {
        throw Exception("Failed to load notifications");
      }
    } catch (error) {
      throw Exception("Failed to load notifications");
    }
  }

  Future<void> markNotificationAsDone(Notification notification) async {
    try {
      final response = await http.put(
        Uri.parse("http://127.0.0.1:3050/notification/${notification.id}/markAsRead"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Notification marked as done");
      } else {
        throw Exception("Failed to mark notification as done");
      }
    } catch (error) {
      throw Exception("Failed to mark notification as done");
    }


  }
}
