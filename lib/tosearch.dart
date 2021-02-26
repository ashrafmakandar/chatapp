import 'package:chatapp/Post.dart';
import 'package:flutter/material.dart';
import 'Post.dart' as post;

class tosearch extends StatefulWidget {
  @override
  _tosearchState createState() => _tosearchState();
}

class _tosearchState extends State<tosearch> {
  List<Post> Allposts = [
    Post(name: "ashraf", work: "android developer"),
    Post(name: "abhi", work: "django developer"),
    Post(name: "hitesh", work: "laravel developer"),
    Post(name: "karthik", work: "web developer"),
    Post(name: "vivek", work: "devops developer"),
    Post(name: "vivian", work: "kuberenetes developer"),
  ];
  List<Post> search = [];

  var namecontroller = TextEditingController();
  bool visible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(Allposts.length);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  visible = true;
                });
              },
              controller: namecontroller,
              decoration: InputDecoration(
                  labelText: "ENTER NAME ",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
          if (visible)
            Visibility(
              visible: visible,
              child: Container(
                  height: 500,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: Allposts.length,
                      itemBuilder: (context, index) {
                        if (namecontroller.text.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20),
                            child: Card(
                              color: Colors.blueGrey[100],
                              child: ListTile(
                                title: Text(Allposts[index].name),
                                subtitle: Text(Allposts[index].work),
                              ),
                            ),
                          );
                        } else if (Allposts[index]
                            .name
                            .contains(namecontroller.text)) {
                          return Card(
                            color: Colors.blueGrey[100],
                            child: ListTile(
                              title: Text(Allposts[index].name),
                              subtitle: Text(Allposts[index].work),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      })),
            )
          else
            Visibility(
              visible: true,
              child: Container(
                height: 500,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: Allposts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Card(
                            child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(Allposts[index].name),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(Allposts[index].work),
                            )
                          ],
                        )),
                      );
                    }),
              ),
            ),
        ],
      ),
    );
  }
}
