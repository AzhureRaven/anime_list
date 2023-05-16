import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/anime.dart';
import '../../providers/anime_provider.dart';
import '../../utlis/snackbar.dart';
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
      body: Consumer<AnimeProvider>(
        builder: (context, AnimeProvider data, widget) {
          return ManageAnimeScreen(onSuccess: (){
            ScaffoldMessenger.of(context).showSnackBar(basicSnackBar("Anime Updated"));
            data.update(anime);
            Navigator.pop(context);
          }, anime: anime);
        },
      )
    );
  }
}
