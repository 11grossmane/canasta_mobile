import 'package:flutter/material.dart';
import 'package:my_app/01-components/postList.dart';
import 'package:my_app/01-components/textInputWidget.dart';
import 'package:my_app/types/post.dart';

class Home extends StatefulWidget {
  final String author;
  Home({this.author});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String text = '';
  List<Post> posts = [];

  void newPost([String text]) {
    this.setState(() {
      posts.add(new Post(body: text, author: widget.author));
    });
  }
  // void press(String text) {
  //   this.setState(() {
  //     this.text = text;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Hello World!')),
        body: Column(children: <Widget>[
          Expanded(
              child: PostList(
            listItems: this.posts,
          )),
          TextInput(
            callback: this.newPost,
          ),
        ]));
  }
}
