import 'package:anime_list/providers/anime_provider.dart';
import 'package:anime_list/routes/anime/update_anime_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../dialogs/yes_no_dialog.dart';
import '../../models/anime.dart';
import '../../utlis/snackbar.dart';
import 'anime_image_screen.dart';

class AnimeDetailScreen extends StatelessWidget {
  final Anime anime;
  const AnimeDetailScreen({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AnimeProvider>(
        builder: (context, AnimeProvider data, widget) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth <= 600) {
                return buildDetailPhone(context, data);
              } else if (constraints.maxWidth <= 900) {
                return buildDetailWeb(context, 1, data);
              } else if (constraints.maxWidth <= 1200) {
                return buildDetailWeb(context, 2, data);
              } else {
                return buildDetailWeb(context, 3, data);
              }
            },
          );
        },
      )
    );
  }

  Widget buildDetailPhone(BuildContext context, AnimeProvider data) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildBackIconButton(context),
                  Column(
                    children: [
                      Stack(
                        children: [
                          buildAnimeImage(context, anime.img),
                          buildZoomIconButton(context, anime),
                        ],
                      ),
                      buildAnimeName(context, anime.name),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buildEditIconButton(context),
                      buildDeleteIconButton(context, data)
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(anime.description),
              const SizedBox(height: 8.0),
              Text("Category: ${anime.categorie}"),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildAnimeRating(context, anime.rating),
                  buildAnimeEpisode(context, anime.episode),
                  buildAnimeStudio(context, anime.studio),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailWeb(BuildContext context, int flex, AnimeProvider data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildBackIconButton(context),
                Expanded(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          buildAnimeImage(context, anime.img),
                          buildZoomIconButton(context, anime),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildAnimeRating(context, anime.rating),
                          buildAnimeEpisode(context, anime.episode),
                          buildAnimeStudio(context, anime.studio),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: flex,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: buildAnimeName(context, anime.name)),
                        buildEditIconButton(context),
                        buildDeleteIconButton(context, data),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(anime.description),
                    const SizedBox(height: 8.0),
                    Text("Category: ${anime.categorie}"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget buildAnimeImage(BuildContext context, String img) {
    return Hero(
      tag: img,
      child: Image.network(
        img,
        fit: BoxFit.fitHeight,
        height: 300
      ),
    );
  }

  Widget buildZoomIconButton(BuildContext context, Anime anime) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(
          icon: const Icon(
            Icons.zoom_out_map,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return AnimeImageScreen(anime: anime);
              }),
            );
          },
        ),
      ),
    );
  }

  Widget buildBackIconButton(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget buildEditIconButton(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.edit,
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return UpdateAnimeScreen(anime: anime);
        }));
      },
    );
  }

  Widget buildDeleteIconButton(BuildContext context, AnimeProvider data) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return YesNoDialog(
              onSuccess: () {
                Navigator.pop(context);
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(basicSnackBar("Anime Deleted"));
                data.delete(anime);
              },
            );
          },
        );
      },
      icon: const Icon(Icons.delete),
    );
  }

  Widget buildAnimeName(BuildContext context, String name) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget buildAnimeRating(BuildContext context, String rating) {
    return Column(
      children: [
        const Icon(Icons.star),
        const SizedBox(height: 8.0),
        Text(rating),
      ],
    );
  }

  Widget buildAnimeEpisode(BuildContext context, int episode) {
    return Column(
      children: [
        const Icon(Icons.tv),
        const SizedBox(width: 8.0),
        Text("$episode"),
      ],
    );
  }

  Widget buildAnimeStudio(BuildContext context, String studio) {
    return Column(
      children: [
        const Icon(Icons.movie),
        const SizedBox(width: 8.0),
        Text(studio),
      ],
    );
  }


}