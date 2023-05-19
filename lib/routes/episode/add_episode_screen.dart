import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/anime.dart';
import '../../providers/anime_provider.dart';
import '../../utlis/snackbar.dart';
import 'manage_episode_screen.dart';

class AddEpisodeScreen extends StatelessWidget {
  final Anime anime;
  const AddEpisodeScreen({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Episode"),
        ),
        body: Consumer<AnimeProvider>(
          builder: (context, AnimeProvider data, widget) {
            return ManageEpisodeScreen(onSuccess: (){
              ScaffoldMessenger.of(context).showSnackBar(basicSnackBar("Episode Added"));
              data.update(anime);
              Navigator.pop(context);
            }, anime: anime, episode: null);
          },
        )
    );
  }
}
