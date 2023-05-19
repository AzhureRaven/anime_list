import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/anime.dart';
import '../../models/episode.dart';
import '../../providers/anime_provider.dart';
import '../../utlis/snackbar.dart';
import 'manage_episode_screen.dart';

class UpdateEpisodeScreen extends StatelessWidget {
  final Anime anime;
  final Episode episode;
  const UpdateEpisodeScreen({Key? key, required this.anime, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Episode"),
        ),
        body: Consumer<AnimeProvider>(
          builder: (context, AnimeProvider data, widget) {
            return ManageEpisodeScreen(onSuccess: (){
              ScaffoldMessenger.of(context).showSnackBar(basicSnackBar("Episode Updated"));
              Navigator.pop(context);
            }, anime: anime, episode: episode);
          },
        )
    );
  }
}
