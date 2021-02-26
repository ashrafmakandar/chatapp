import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ChatListUser extends StatefulWidget {
  String user, token, currentuser;

  ChatListUser({this.user, this.token, this.currentuser});

  @override
  _ChatListUserState createState() => _ChatListUserState();
}

class _ChatListUserState extends State<ChatListUser> {
  var textentered = TextEditingController();
  String username;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chats =
        FirebaseDatabase.instance.reference().child("chats").child(widget.user);
    username = widget.currentuser;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print("height"+height.toString());
    return Scaffold(
      backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height/20,child: ColoredBox(color: Colors.red,),),

          Text(
            "you are texting",
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
         Text(
              widget.user.toUpperCase(),
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),

          SizedBox(
            height: height*0.70,

            child: FirebaseAnimatedList(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                query: chats,
                itemBuilder: (_, snapshot, animation, index) {
                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      snapshot.value["username"] == widget.user
                          ? Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: height/15,
                                    width: width/3,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(35)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(snapshot.value["username"] ?? ""),
                                        Divider(height: 1),
                                        Text(snapshot.value["text"] ?? ""),

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    height: height/15,
                                    width: width/3,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(35)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(snapshot.value["username"] ?? ""),
                                        Divider(height: 1),
                                        Text(snapshot.value["text"] ?? ""),

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                    ],
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: TextFormField(
              decoration: InputDecoration(border: OutlineInputBorder()),
              controller: textentered,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
            child: RaisedButton(
              onPressed: () {
                chats.push().set({
                  "text": textentered.text.toString(),
                  "username": widget.currentuser
                });
              },
              child: Text("send"),
            ),
          )
        ],
      ),
    ));
  }
}
