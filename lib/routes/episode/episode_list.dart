import 'package:anime_list/routes/episode/add_episode_screen.dart';
import 'package:anime_list/routes/episode/update_episode_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../dialogs/yes_no_dialog.dart';
import '../../models/anime.dart';
import '../../models/episode.dart';
import '../../providers/anime_provider.dart';
import '../../utlis/snackbar.dart';

class EpisodeList extends StatefulWidget {
  final Anime anime;
  final AnimeProvider data;
  const EpisodeList({Key? key, required this.anime, required this.data}) : super(key: key);

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
        LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
          if (constraints.maxWidth <= 600) {
            return SizedBox(
              height: 300,
              child: buildList(context, widget.data),
            );
          } else {
            return SizedBox(
              height: 500,
              child: buildList(context, widget.data),
            );
          }
        })
      ],
    );
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
          episode.watched = !episode.watched;
          data.notify();
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
                widget.anime.episodes.remove(episode);
                ScaffoldMessenger.of(context)
                    .showSnackBar(basicSnackBar("Episode Deleted"));
                data.notify();
              }, title: 'Delete Anime?', content: 'Deleted Episode cannot be recovered',
            );
          },
        );
      },
      icon: const Icon(Icons.delete),
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
