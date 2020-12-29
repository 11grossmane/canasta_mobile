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
