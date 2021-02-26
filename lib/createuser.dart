import 'package:chatapp/Allusers.dart';
import 'package:chatapp/tosearch.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class createuser extends StatefulWidget {
  @override
  _createuserState createState() => _createuserState();
}

class _createuserState extends State<createuser> {
  var usercontroller = TextEditingController();
  var _msging = FirebaseMessaging();
  var _token;

  @override
  void initState() {
    // TODO: implement initState

    _msging.getToken().then((value) => _token = value);
    print(_token);
  }

  @override
  Widget build(BuildContext context) {
    var _userdata = FirebaseDatabase.instance.reference().child("createduser");
    print(_token);
    var height= MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(

          child: Column(

            children: [
              SizedBox(
                height: height/3,
              ),
              Container(
                height: height*0.50,
        color: Colors.grey[100],
        child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: TextFormField(
                    controller: usercontroller,
                    decoration: InputDecoration(
                        labelText: "enter username",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: RaisedButton(
                    color: Colors.red,
                    splashColor: Colors.green,
                    textColor: Colors.white,
                    onPressed: () {
                      _userdata.push().set({
                        "user": usercontroller.text.toString(),
                        "token": _token
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext c) => Allusers(
                                  currentuser: usercontroller.text.toString())));
                    },
                    child: Text("create user"),
                  ),
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext c) => Allusers( currentuser:"ashraf2")));
                  },
                  child: Text(" click ashraf4 "),
                )
                ,RaisedButton(
                  color: Colors.blue[200],
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext c) => tosearch()));
                  },
                  child: Text(" to search  "),
                )
              ],
        ),
      ),
            ],
          )),
    );
  }
}
