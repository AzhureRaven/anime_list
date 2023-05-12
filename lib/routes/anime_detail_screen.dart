import 'package:flutter/material.dart';
import '../models/anime.dart';
import 'anime_image_screen.dart';

class AnimeDetailScreen extends StatelessWidget {
  final Anime anime;
  const AnimeDetailScreen({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Anime"),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return buildDetailPhone(context);
          } else if (constraints.maxWidth <= 900) {
            return buildDetailWeb(context, 2);
          } else {
            return buildDetailWeb(context, 1);
          }
        },
      ),
    );
  }

  Widget buildDetailPhone(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Stack(
                  children: [
                    Hero(
                        tag: anime.img,
                        child: Image.network(
                          anime.img,
                          fit: BoxFit.fitHeight,
                          height: 300,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(
                            Icons.zoom_out_map,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AnimeImageScreen(anime: anime);
                            }));
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Row(),
                Row()
              ],
            ),
            const SizedBox(height: 8.0),
            Container(
                width: double.infinity,
                child: Text(anime.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center)),
            const SizedBox(height: 8.0),
            Text(anime.description),
            const SizedBox(height: 8.0),
            Text("Category: ${anime.categorie}"),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Icon(Icons.star),
                    const SizedBox(height: 8.0),
                    Text(anime.rating),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.tv),
                    const SizedBox(width: 8.0),
                    Text("${anime.episode}"),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.movie),
                    const SizedBox(width: 8.0),
                    Text(anime.studio),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildDetailWeb(BuildContext context, int flex) {
    return Row(
      children: [
        Expanded(child: Row()),
        Expanded(
          flex: flex,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Hero(
                          tag: anime.img,
                          child: Image.network(
                            anime.img,
                            fit: BoxFit.fitHeight,
                            height: 300,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(
                              Icons.zoom_out_map,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return AnimeImageScreen(anime: anime);
                              }));
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(anime.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      const SizedBox(height: 8.0),
                      Text(anime.description),
                      const SizedBox(height: 8.0),
                      Text("Category: ${anime.categorie}"),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Icon(Icons.star),
                          const SizedBox(height: 8.0),
                          Text(anime.rating),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(Icons.tv),
                          const SizedBox(width: 8.0),
                          Text("${anime.episode}"),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(Icons.movie),
                          const SizedBox(width: 8.0),
                          Text(anime.studio),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(child: Row()),
      ],
    );
  }
}
