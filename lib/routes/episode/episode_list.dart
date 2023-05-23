import 'package:anime_list/routes/episode/update_episode_screen.dart';
import 'package:flutter/material.dart';
import '../../dialogs/yes_no_dialog.dart';
import '../../models/anime.dart';
import '../../models/episode.dart';
import '../../providers/anime_provider.dart';
import '../../utlis/snackbar.dart';

class EpisodeList extends StatefulWidget {
  final Anime anime;
  final AnimeProvider data;
  final String mode;
  const EpisodeList({Key? key, required this.anime, required this.data, required this.mode}) : super(key: key);

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  @override
  Widget build(BuildContext context) {
    return widget.mode == "web" ? Expanded(child: buildList(context, widget.data)) : SizedBox(height: 300, child: buildList(context, widget.data));
  }

  Widget buildList(BuildContext context, AnimeProvider data) {
    if(widget.anime.episodes.isNotEmpty) {
      return ListView.builder(
        itemCount: widget.anime.episodes.length,
        itemBuilder: (context, index) {
          return buildDList(context, widget.anime.episodes[index], data);
        },
      );
    } else {
      return Center(child: Text("No Data"));
    }
  }

  Widget buildDList(BuildContext context, Episode episode, AnimeProvider data) {
    return ListTile(
      leading: Text(episode.no.toString()),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(episode.name, overflow: TextOverflow.ellipsis)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildWatchedIconButton(context, episode, data),
              buildEditIconButton(context, episode),
              buildDeleteIconButton(context, episode, data)
            ],
          )
        ],
      )
    );
  }

  Widget buildWatchedIconButton(BuildContext context, Episode episode, AnimeProvider data) {
    return Row(
      children: [
        Checkbox(value: episode.watched, onChanged: (da){
          data.editEpisodeWatched(widget.anime, episode, !episode.watched);
        })
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

  Widget buildDeleteIconButton(BuildContext context, Episode episode, AnimeProvider data) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return YesNoDialog(
              onSuccess: () {
                Navigator.pop(context);
                data.deleteEpisode(widget.anime, episode);
                ScaffoldMessenger.of(context).showSnackBar(basicSnackBar("Episode Deleted"));
              }, title: 'Delete Anime?', content: 'Deleted Episode cannot be recovered',
            );
          },
        );
      },
      icon: const Icon(Icons.delete),
    );
  }
}
