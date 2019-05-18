import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<List<Comment>> fetchPosts(int postId) async {
  final response = await http
      .get('https://jsonplaceholder.typicode.com/posts/$postId/comments');

  List<Comment> commentApi = [];

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var body = json.decode(response.body);
    for (int i = 0; i < body.length; i++) {
      var comment = Comment.fromJson(body[i]);
      if (comment.postid == postId) {
        commentApi.add(comment);
      }
    }
    return commentApi;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Comment {
  final int postid;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment({this.postid, this.id, this.name, this.email, this.body});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      postid: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}

class CommentPage extends StatelessWidget {
  // Declare a field that holds the Todo
  final int postId;
  // In the constructor, require a Todo
  CommentPage({Key key, @required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create our UI
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("BACK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FutureBuilder(
              future: fetchPosts(this.postId),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return new Text('loading...');
                  default:
                    if (snapshot.hasError) {
                      return new Text('Error: ${snapshot.error}');
                    } else {
                      return createListView(context, snapshot);
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Comment> values = snapshot.data;
    return new Expanded(
      child: new ListView.builder(
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${values[index].postid} : ${values[index].id} ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 10)),
                  Text(
                    values[index].body,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    values[index].name,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    values[index].email,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PostPage(id: this.id),
                //   ),
                // );
              },
            ),
          );
        },
      ),
    );
  }
}
