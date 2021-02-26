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
  ];
  List<Post> search = [];

  @override
  Widget build(BuildContext context) {
    print(Allposts.length);
    var namecontroller = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: namecontroller,
              onChanged: (val) {
                Allposts.map((e) => {
                      if (e.name.contains(val))
                        {
                          search.add(new Post(name: e.name, work: "asibfb")),
                          print("list"+search.toString())
                        }
                    });
              },
            ),
          ),
          FlatButton(
              color: Colors.blue,
              onPressed: ()=> {
              print(search.toString())
              },
              child: Text("search")),
          ListView.builder(
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
        ],
      ),
    );
  }
}
