import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListofUser extends StatefulWidget {

  DataSnapshot dataSnapshot;
  Animation animation;
  ListofUser({this.dataSnapshot,this.animation});
  @override
  _ListofUserState createState() => _ListofUserState();
}

class _ListofUserState extends State<ListofUser> {
  final ref2 = FirebaseDatabase.instance.reference().child('users');
  final ref3 = FirebaseDatabase.instance.reference().child('new');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirebaseAnimatedList(
          query: ref2,
          padding: const EdgeInsets.all(8.0),
          reverse: true,
          sort: (a, b) => b.key.compareTo(a.key),
          //comparing timestamp of messages to check which one would appear first
          itemBuilder: (_, DataSnapshot messageSnapshot,
              Animation<double> animation, index) {
            return new Card(
                child: InkWell(
                    onTap: () {
                      ref3.push().set({'text': "somevalue"});
                      sendnotification(
                        messageSnapshot.value['usertoken'],
                      );
                    },
                    child: Text(messageSnapshot.value['useremail']??"")));
          }),
    );
  }

  Future<void> sendnotification(value) async {
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAj4et0aY:APA91bHTllpu_JcIkuVo03V7r9HeSrxITLJcOqSO0UaEHE0G26P3JTZHTlQfs2fJZ67QHPBWRTsGZ_MNyEOceIrbFKisglhUlkyWO-RCPTqcu8Xf3rsBR6GpOcqi3EyP4DitqhOUQYVc',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'this is a body',
            'title': 'this is a title'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': await value,
        },
      ),
    );
  }
}
