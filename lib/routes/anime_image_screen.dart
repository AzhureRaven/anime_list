import 'package:flutter/material.dart';
import '../models/anime.dart';

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
          child: Image.network(anime.img),
        ),
      ),
    );
  }
}