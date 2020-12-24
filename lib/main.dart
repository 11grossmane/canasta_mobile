import 'package:flutter/material.dart';
import './titleSection.dart' as t;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter layout demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class Post {
  String body;
  String author;
  int likes = 0;
  bool userLiked = false;

  Post({this.body, this.author});

  void likePost() {
    this.likes++;
    userLiked = true;
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = '';
  List<Post> posts = [];

  void newPost([String text, String author = 'Eric']) {
    this.setState(() {
      posts.add(new Post(body: text, author: author));
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
          TextInputWidget(
            callback: this.newPost,
          ),
        ]));
  }
}

class TextInputWidget extends StatefulWidget {
  final Function(String, [String]) callback;
  TextInputWidget({this.callback});

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  @override
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void click() {
    FocusScope.of(context).unfocus();
    widget.callback(controller.text);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
        child: TextField(
          // onChanged: (text) => {this.changeText(text)},
          controller: this.controller,
          onEditingComplete: () => {print('complete')},
          onSubmitted: (text) {
            this.click();
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.message),
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                tooltip: 'Post Message',
                splashColor: Colors.grey[500],
                onPressed: () {
                  this.click();
                },
              ),
              labelText: "Type a message:"),
        ));
  }
}

class PostList extends StatefulWidget {
  final List<Post> listItems;

  PostList({this.listItems});

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.widget.listItems.length,
        itemBuilder: (context, i) {
          var post = this.widget.listItems[i];
          return Card(
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(post.body),
                    subtitle: Text(post.author),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(post.likes.toString(),
                          style: TextStyle(fontSize: 20)),
                      padding: EdgeInsets.fromLTRB(1, 1, 4, 1),
                    ),
                    IconButton(
                      icon: Icon(Icons.thumb_up_alt),
                      onPressed: () {
                        this.setState(() {
                          post.likePost();
                        });
                      },
                      color: post.userLiked ? Colors.green : null,
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
