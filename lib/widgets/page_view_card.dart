

import 'package:blog_app/app/specific_type_posts.dart';
import 'package:blog_app/models/post.dart';
import 'package:flutter/material.dart';
List<Map<String, dynamic>> items = [
  {
    "placeImage": "images/tech.jpg",
    "placeName": "Technology",
  },
  {
    "placeImage": "images/politics.jpg",
    "placeName": "Politics",
  },
  {
    "placeImage": "images/fashion.png",
    "placeName": "Fashion",
  },
  {
    "placeImage": "images/social.jpg",
    "placeName": "Social Awareness",
  },
  {
    "placeImage": "images/finance.jpeg",
    "placeName": "Finance",
  },
  {
    "placeImage": "images/entertain.jpg",
    "placeName": "Entertainment",
  }
];
class PageViewCard extends StatelessWidget {
  List<Post> post;
  PageViewCard({this.post});
  PageController _pageController =
  PageController(initialPage: 1, viewportFraction: 0.8);
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SpecificTypePosts(posts: post,type: items[index]["placeName"],)
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color:Colors.black12,
                            offset: Offset(2,2),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset('${items[index]["placeImage"]}', fit: BoxFit.cover,),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey.withOpacity(0.2),
                            Colors.black,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${items[index]["placeName"]}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text('Click to view Posts related to this topic',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }


    );
  }
}