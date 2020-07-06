import 'package:blog_app/app/post_view_card.dart';
import 'package:blog_app/models/post.dart';
import 'package:blog_app/widgets/constants/constants.dart';
import 'package:flutter/material.dart';

class SpecificTypePosts extends StatefulWidget {
  final List<Post> posts;
  final String type;
  SpecificTypePosts({this.posts, this.type});

  @override
  _SpecificTypePostsState createState() => _SpecificTypePostsState();
}

class _SpecificTypePostsState extends State<SpecificTypePosts> {
  List<Post> typePost = <Post>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTypePosts();
  }

  getTypePosts() async {
    for (var i = 0; i < widget.posts.length; i++) {
      if (widget.posts[i].type == widget.type) {
        setState(() {
          typePost.add(widget.posts[i]);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: backgroundColor,
        title: Text(
          '${widget.type}',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body:typePost.isEmpty ? Center(
        child: Text(
          'No Posts of this type',
          style: TextStyle(color: Colors.grey, fontSize: 25),
        ),
      ) : ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: typePost.length,
        itemBuilder: (context, index) {

          return PostViewCard(post: typePost[index]);
        },
      ),
    );
  }
}
