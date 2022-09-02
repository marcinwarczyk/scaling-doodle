import 'package:code_brothers/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../resources/fetch_methods.dart';
import '../utils/colors.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Comment>>(
        future: fetchComments(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return CommentsList(comments: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class CommentsList extends StatelessWidget {
  const CommentsList({super.key, required this.comments});

  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(comments[index].name, style: const TextStyle(
                fontWeight: FontWeight.bold,
              ) ),
              Text(comments[index].email, style: const TextStyle(
                color: secondaryColor,
              )),
              Text(comments[index].body, style: const TextStyle(
                fontSize: 12.0,
              )),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}
