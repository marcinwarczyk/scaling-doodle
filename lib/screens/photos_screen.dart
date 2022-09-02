import 'package:flutter/material.dart';

import '../models/photo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../resources/fetch_methods.dart';
import '../utils/colors.dart';


class PhotosScreen extends StatelessWidget {
  const PhotosScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PhotosList(photos: snapshot.data!);
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

class PhotosList extends StatelessWidget {
  const PhotosList({super.key, required this.photos});

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: Image.network(photos[index].thumbnailUrl, fit: BoxFit.cover,),
          onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: Text(photos[index].title),
              children: <Widget>[
                SimpleDialogOption(
                    padding: const EdgeInsets.all(20),
                    child: Image.network(photos[index].url),
                ),
                /*SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),*/
              ],
            );
          },
        ),
        );
      },
    );
  }
}
