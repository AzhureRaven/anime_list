import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../utlis/snackbar.dart';
import 'manage_anime_screen.dart';

class UpdateAnimeScreen extends StatelessWidget {
  final Anime anime;
  const UpdateAnimeScreen({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Anime"),
      ),
      body: ManageAnimeScreen(onSuccess: (){
        ScaffoldMessenger.of(context).showSnackBar(basicSnackBar("Anime Updated"));
      }, anime: anime),
    );
  }
}
