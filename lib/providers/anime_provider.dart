import 'dart:html';

import 'package:anime_list/providers/secured_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../models/episode.dart';

class AnimeProvider extends ChangeNotifier{
  List<Anime> animeList = [];
  bool initialized = false;
  final _firestore = FirebaseFirestore.instance;

  void addAnime(Anime anime) async{
    _firestore.collection("anime").add(anime.toMap()).then((docRef) {
      anime.id = docRef.id;
      animeList.add(anime);
      notifyListeners();
    }).catchError((e) {
      print(e.toString());
    });

  }

  void editAnime(Anime anime, String name, String desc, String rating, String categories, String studio, String img){
    Anime edit = animeList[animeList.indexOf(anime)];
    edit.name = name;
    edit.description = desc;
    edit.rating = rating;
    edit.categories = categories;
    edit.studio = studio;
    edit.img = img;
    notifyListeners();
  }

  void deleteAnime(Anime anime){
    animeList.remove(anime);
    notifyListeners();
  }

  void addEpisode(Anime anime, Episode episode){
    Anime edit = animeList[animeList.indexOf(anime)];
    edit.episodes.add(episode);
    notifyListeners();
  }

  void editEpisode(Anime anime, Episode episode, String name, int no, bool watched){
    Anime edit = animeList[animeList.indexOf(anime)];
    Episode ep = edit.episodes[edit.episodes.indexOf(episode)];
    ep.name = name;
    ep.no = no;
    ep.watched = watched;
    notifyListeners();
  }

  void editEpisodeWatched(Anime anime, Episode episode, bool watched){
    Anime edit = animeList[animeList.indexOf(anime)];
    Episode ep = edit.episodes[edit.episodes.indexOf(episode)];
    ep.watched = watched;
    notifyListeners();
  }

  void deleteEpisode(Anime anime, Episode episode){
    Anime edit = animeList[animeList.indexOf(anime)];
    edit.episodes.remove(episode);
    notifyListeners();
  }

  void notify(){
    notifyListeners();
  }

  void initialize(BuildContext context, QuerySnapshot<Map<String, dynamic>> json) {
    if(!initialized){
      animeList.clear();
      animeList.addAll(parseAnime(json).where((anime) => anime.owner == SecuredStorage.getUser()));
      initialized = true;
    }
  }

  void logout(){
    animeList.clear();
    initialized = false;
  }

}