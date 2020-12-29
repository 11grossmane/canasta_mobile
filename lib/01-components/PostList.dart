import 'package:flutter/material.dart';
import 'package:my_app/types/post.dart';

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
