import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

abstract class Constant {
  static const String constantServerKey =
      'AAAAjXAX6VI:APA91bGV8nTXeZhrYxpDoOwDVWMjF-ctAzVdVvHMi1itmDH_cM43lQ8shh_V1gxrK0523kK0hv1cLWWFgLxWI8gvFFBc4jWNt0TV_Ha0rfid_3nKdzGwStY0SWGy9jWO59eLayWXR9rv';
}

Future<void> sendPushNotification({
  required String title,
  required String body,
  required String token,
  required BuildContext context,
}) async {
  try {
    http.Response response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'key=${Constant.constantServerKey}',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': title,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': token,
        },
      ),
    );
    response;
  } catch (e) {
    e;
  }
}

Future<void> addNotificationToFirestore(
    String userID, String title, String type, String content) async {
  try {
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(userID)
        .collection('Notification')
        .add({
      "title": title,
      "content": content,
      "type": type,
      "date": '${DateTime.now()}',
      "user_id": userID,
      "profile_pic": (await FirebaseFirestore.instance
              .collection('users')
              .doc(userID)
              .get())
          .get('profile_pic'),
    });
  } catch (e) {
    print('Error adding notification: $e');
  }
}

Future<String?> getFCMTokenForUser(String userId) async {
  try {
    // Reference to the collection where FCM tokens are stored
    CollectionReference tokensCollection =
        FirebaseFirestore.instance.collection('users');

    // Query the collection for the specific user
    QuerySnapshot querySnapshot =
        await tokensCollection.where('id', isEqualTo: userId).get();

    // Check if any documents are found
    if (querySnapshot.docs.isNotEmpty) {
      // Assume each user has a unique FCM token, so we just get the first one
      return querySnapshot.docs.first['token'];
    } else {
      print('FCM token not found for user with ID: $userId');
      return null;
    }
  } catch (e) {
    print('Error getting FCM token for user: $e');
    return null;
  }
}
