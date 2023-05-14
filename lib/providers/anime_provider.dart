import 'package:flutter/material.dart';
import '../models/anime.dart';

class AnimeProvider extends ChangeNotifier{
  late final List<Anime> animeList;

  void add(Anime anime){
    animeList.add(anime);
    notifyListeners();
  }

  void delete(Anime anime){
    animeList.remove(anime);
    notifyListeners();
  }

  void initialize(BuildContext context) {
    var data = DefaultAssetBundle.of(context).loadString('assets/anime.json');
    data.then((value) => animeList = parseAnime(value));
    notifyListeners();
  }

}