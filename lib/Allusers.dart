import 'package:chatapp/ChatListUser.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Allusers extends StatefulWidget {
  String currentuser;

  Allusers({this.currentuser});

  @override
  _AllusersState createState() => _AllusersState();
}

class _AllusersState extends State<Allusers> {
  var db = FirebaseDatabase.instance.reference().child("createduser");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FirebaseAnimatedList(
          query: db,
          itemBuilder: (_, snapshot, animaton, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext c) => ChatListUser(
                                  user: snapshot.value["user"],
                                  token: snapshot.value["token"],
                              currentuser:widget.currentuser
                                )));
                  },
                  child: ListTile(
                    title: Text(snapshot.value["user"] ?? ""),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
