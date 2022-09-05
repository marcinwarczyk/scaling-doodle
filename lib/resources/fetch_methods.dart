import 'package:code_brothers/models/comment.dart';
import 'package:code_brothers/models/photo.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../utils/global_variables.dart';
import 'package:flutter/foundation.dart';

import '../utils/utils.dart';

class Data<T> {

  Future<List<T>> fetchData(http.Client client, context) async {
    Future<List<T>> result = Future.value([]);
    try {
      String uri = "";
      uri = (T == Comment) ? commentsUri : photosUri;
      final response = await client.get(Uri.parse(uri));
      result = compute(parseData, response.body);
    } catch (err) {
      showSnackBar(err.toString(), context);
      throw Exception();
    }
    return result;
  }

  List<T> parseData(String responseBody) {
    try {
      final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
      if (T == Comment) {
        return parsed.map<T>((json) => Comment.fromJson(json)).toList();
      } else {
        /*Photo*/
        return parsed.map<T>((json) => Photo.fromJson(json)).toList();
      }
    }
    catch(err){
      throw Exception(err);
    }
  }
}
