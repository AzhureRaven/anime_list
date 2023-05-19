import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../../models/anime.dart';

class AnimeImageScreen extends StatelessWidget {
  final Anime anime;
  const AnimeImageScreen({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Hero(
          tag: anime.img,
          child: PhotoView(imageProvider: NetworkImage(anime.img)),
        ),
      ),
    );
  }
}