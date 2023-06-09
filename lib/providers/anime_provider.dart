import 'package:anime_list/providers/secured_provider.dart';
import 'package:anime_list/utlis/secured_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/anime.dart';
import '../models/episode.dart';

class AnimeProvider extends ChangeNotifier {
  List<Anime> animeList = [];
  bool initialized = false;
  final _firestore = FirebaseFirestore.instance;

  void addAnime(Anime anime) async {
    _firestore.collection("anime").add(anime.toMap()).then((docRef) {
      anime.id = docRef.id;
      animeList.add(anime);
      notifyListeners();
    }).catchError((e) {
      print(e.toString());
    });
  }

  void editAnime(Anime anime, String name, String desc, String rating,
      String categories, String studio, String img) async {
    Anime edit = animeList[animeList.indexOf(anime)];
    edit.name = name;
    edit.description = desc;
    edit.rating = rating;
    edit.categories = categories;
    edit.studio = studio;
    edit.img = img;
    await _firestore.collection("anime").doc(edit.id).set(anime.toMap());
    notifyListeners();
  }

  void deleteAnime(Anime anime) async {
    Anime edit = animeList[animeList.indexOf(anime)];
    await _firestore.collection("anime").doc(edit.id).delete();
    animeList.remove(edit);
    notifyListeners();
  }

  void addEpisode(Anime anime, Episode episode) async {
    Anime edit = animeList[animeList.indexOf(anime)];
    edit.episodes.add(episode);
    edit.episodes.sort((a, b) => a.no.compareTo(b.no));
    await _firestore.collection("anime").doc(edit.id).set(anime.toMap());
    notifyListeners();
  }

  void editEpisode(Anime anime, Episode episode, String name, int no, bool watched) async {
    Anime edit = animeList[animeList.indexOf(anime)];
    Episode ep = edit.episodes[edit.episodes.indexOf(episode)];
    ep.name = name;
    ep.no = no;
    ep.watched = watched;
    edit.episodes.sort((a, b) => a.no.compareTo(b.no));
    await _firestore.collection("anime").doc(edit.id).set(anime.toMap());
    notifyListeners();
  }

  void editEpisodeWatched(Anime anime, Episode episode, bool watched) async {
    Anime edit = animeList[animeList.indexOf(anime)];
    Episode ep = edit.episodes[edit.episodes.indexOf(episode)];
    ep.watched = watched;
    await _firestore.collection("anime").doc(edit.id).set(anime.toMap());
    notifyListeners();
  }

  void deleteEpisode(Anime anime, Episode episode) async {
    Anime edit = animeList[animeList.indexOf(anime)];
    edit.episodes.remove(episode);
    edit.episodes.sort((a, b) => a.no.compareTo(b.no));
    await _firestore.collection("anime").doc(edit.id).set(anime.toMap());
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  void initialize(
      BuildContext context, QuerySnapshot<Map<String, dynamic>> json) {
    if (!initialized) {
      animeList.clear();
      final securedStorage = Provider.of<SecuredProvider>(context, listen: false);
      animeList.addAll(parseAnime(json)
          .where((anime) => anime.owner == securedStorage.getUser()));
      initialized = true;
    }
  }

  void logout() {
    animeList.clear();
    initialized = false;
  }
}
