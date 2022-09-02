import 'package:code_brothers/models/comment.dart';
import 'package:code_brothers/models/photo.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../utils/uri.dart';
import 'package:flutter/foundation.dart';

Future<List<Comment>> fetchComments(http.Client client) async {
  final response = await client
      .get(Uri.parse(commentsUri));

  return compute(parseComments, response.body);
}

List<Comment> parseComments(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Comment>((json) => Comment.fromJson(json)).toList();
}

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse(photosUri));

  return compute(parsePhotos, response.body);
}

List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}