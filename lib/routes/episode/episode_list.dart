import 'package:anime_list/routes/episode/add_episode_screen.dart';
import 'package:anime_list/routes/episode/update_episode_screen.dart';
import 'package:flutter/material.dart';

import '../../models/anime.dart';
import '../../models/episode.dart';

class EpisodeList extends StatefulWidget {
  final Anime anime;
  const EpisodeList({Key? key, required this.anime}) : super(key: key);

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Episode List", style: TextStyle(fontSize: 16)),
            buildAddIconButton(context)
          ],
        ),
        const Divider(thickness: 1, height: 3),

      ],
    );
  }

  Widget buildEditIconButton(BuildContext context, Episode episode) {
    return IconButton(
      icon: const Icon(
        Icons.edit,
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return UpdateEpisodeScreen(anime: widget.anime, episode: episode);
        }));
      },
    );
  }

  Widget buildAddIconButton(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.add,
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return AddEpisodeScreen(anime: widget.anime);
        }));
      },
    );
  }
}
