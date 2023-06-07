import 'package:anime_list/providers/anime_provider.dart';
import 'package:anime_list/routes/anime/anime_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/anime.dart';

class AnimeListScreen extends StatefulWidget {
  const AnimeListScreen({Key? key}) : super(key: key);

  @override
  State<AnimeListScreen> createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen> {
  TextEditingController searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String search = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.search,
                    color: searchController.text.isNotEmpty
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey),
                onPressed: () {
                  setState(() {
                    search = searchController.text;
                  });
                },
              ),
              Expanded(
                child: Stack(alignment: const Alignment(1.0, 1.0), children: [
                  TextField(
                      decoration:
                          const InputDecoration(hintText: 'Search Anime'),
                      onChanged: (text) {
                        setState(() {
                          search = searchController.text;
                        });
                      },
                      onSubmitted: (value) {
                        setState(() {
                          search = searchController.text;
                        });
                      },
                      controller: searchController),
                  searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              searchController.clear();
                              search = searchController.text;
                            });
                          })
                      : Container(height: 0.0)
                ]),
              ),
            ],
          ),
        ),
        Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _firestore.collection("anime").orderBy('name', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Consumer<AnimeProvider>(
                      builder: (context, AnimeProvider data, widget) {
                        data.initialize(context, snapshot.data!);
                        return buildLayout(context, data);
                  });
                }
              },
            )
        ),
      ],
    );
  }

  Widget buildLayout(BuildContext context, AnimeProvider data) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        List<Anime> resultList = [];
        if (search.isNotEmpty) {
          for (int i = 0; i < data.animeList.length; i++) {
            String str1 = search.toUpperCase();
            String str2 = data.animeList[i].name.toUpperCase();
            if (str2.contains(str1)) {
              resultList.add(data.animeList[i]);
            }
          }
        } else {
          for (int i = 0; i < data.animeList.length; i++) {
            resultList.add(data.animeList[i]);
          }
        }
        if (resultList.isEmpty) {
          return const Center(
            child: Text("Maaf, tidak ada anime ditemukan",
                style: TextStyle(fontSize: 18)),
          );
        } else {
          if (constraints.maxWidth <= 600) {
            return buildAnimeList(context, resultList);
          } else if (constraints.maxWidth <= 900) {
            return buildAnimeGrid(context, resultList, 2);
          } else if (constraints.maxWidth <= 1200) {
            return buildAnimeGrid(context, resultList, 3);
          } else {
            return buildAnimeGrid(context, resultList, 4);
          }
        }
      },
    );
  }

  Widget buildAnimeList(BuildContext context, List<Anime> listAnime) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          Anime anime = listAnime[index];
          return buildAnimeListTile(context, anime);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(height: 0, thickness: 3);
        },
        itemCount: listAnime.length);
  }

  Widget buildAnimeGrid(
      BuildContext context, List<Anime> listAnime, int gridCount) {
    return GridView.count(
      crossAxisCount: gridCount,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children:
          listAnime.map((anime) => buildAnimeListGrid(context, anime)).toList(),
    );
  }

  Widget buildAnimeListTile(BuildContext context, Anime anime) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AnimeDetailScreen(anime: anime);
        }));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: CachedNetworkImage(
                  imageUrl :anime.img,
                  placeholder: (context, url) => Image.asset('images/splash.jpg',fit: BoxFit.fitWidth, width: double.infinity),
                  errorWidget: (context, url, error) => Image.asset('images/splash.jpg',fit: BoxFit.fitWidth, width: double.infinity),
                  fit: BoxFit.fitWidth, width: double.infinity
              )
          ),
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(anime.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(Icons.star),
                        const SizedBox(width: 8.0),
                        Text(anime.rating),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(Icons.tv),
                        const SizedBox(width: 8.0),
                        Text("${anime.episodes.length}"),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(Icons.movie),
                        const SizedBox(width: 8.0),
                        Text(anime.studio),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget buildAnimeListGrid(BuildContext context, Anime anime) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AnimeDetailScreen(anime: anime);
          }));
        },
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            Expanded(
                flex: 2,
                child: Image.network(anime.img, fit: BoxFit.fitHeight)),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(anime.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
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
                              Text("${anime.episodes.length}"),
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
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
