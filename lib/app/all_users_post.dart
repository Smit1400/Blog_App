import 'package:blog_app/app/post_view_card.dart';
import 'package:blog_app/models/post.dart';
import 'package:blog_app/services/database_services.dart';
import 'package:blog_app/widgets/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AllUsersPost extends StatefulWidget {
  final DatabaseServices database;
  final String uid;
  AllUsersPost({this.database, this.uid});

  @override
  _AllUsersPostState createState() => _AllUsersPostState();
}

class _AllUsersPostState extends State<AllUsersPost> {



  _delete(Post post) async{
    await widget.database.deletePost(widget.uid, post);
    Fluttertoast.showToast(
        msg: "Post Deleted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Fluttertoast.showToast(
        msg: "Swipe Left to delete Post",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text('Your Posts', style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Post>>(
            stream: widget.database.getAllUsersPosts(widget.uid),
            initialData: [],
            builder: (context, snapshot) {
              var posts = snapshot.data;
              if (posts.isEmpty) {
                return Center(
                  child: Text(
                    'You don\'t have any posts',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                    ),
                  ),
                );
              }
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key('${DateTime.now().toIso8601String()}'),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      child: Center(
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onDismissed:(direction) => _delete(posts[index]),
                    child: PostViewCard(post: posts[index]),
                  );
                },
              );
            }),
      ),
    );
  }
}
