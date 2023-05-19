import 'dart:convert';

import 'package:anime_list/models/episode.dart';

class Anime {
  String name;
  String description;
  String rating;
  List<Episode> episodes;
  String categories;
  String studio;
  String img;

  Anime({required this.name,
      required this.description,
      required this.rating,
      required this.episodes,
      required this.categories,
      required this.studio,
      required this.img});

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      name: json['name'].toString(),
      description: json['description'].toString(),
      rating: json['rating'].toString(),
      episodes: [],
      categories: json['categorie'].toString(),
      studio: json['studio'].toString(),
      img: json['img'].toString()
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['rating'] = this.rating;
    data['categorie'] = this.categories;
    data['studio'] = this.studio;
    data['img'] = this.img;
    return data;
  }
}

List<Anime> parseAnime(String? json) {
  if (json == null) {
    return [];
  }

  final List<dynamic> parsed = jsonDecode(json);

  return parsed.map((json) => Anime.fromJson(json)).toList();
}

/*List<Anime> animeList = [
  Anime(
      name: "Naruto: Shippuuden",
      description:
          "It has been two and a half years since Naruto Uzumaki left Konohagakure, the Hidden Leaf Village, for intense training following events which fueled his desire to be stronger. Now Akatsuki, the mysterious organization of elite rogue ninja, is closing in on their grand plan which may threaten the safety of the entire shinobi world.",
      rating: "8.26",
      episode: 500,
      categorie: "Drama, Adventure",
      studio: "Studio Pierrot",
      img: "https://cdn.myanimelist.net/images/anime/1565/111305.jpg"),
  Anime(
      name: "One Piece",
      description:
          "Gol D. Roger was known as the 'Pirate King',the strongest and most infamous being to have sailed the Grand Line. The capture and death of Roger by the World Government brought a change throughout the world. His last words before his death revealed the existence of the greatest treasure in the world, One Piece. It was this revelation that brought about the Grand Age of Pirates, men who dreamed of finding One Piece—which promises an unlimited amount of riches and fame—and quite possibly the pinnacle of glory and the title of the Pirate King.",
      rating: "8.69",
      episode: 1000,
      categorie: " Action, Adventure, Fantasy",
      studio: "Toei Animation",
      img: "https://cdn.myanimelist.net/images/anime/6/73245.jpg"),
  Anime(
      name: "Attack on Titan",
      description:
          "Centuries ago, mankind was slaughtered to near extinction by monstrous humanoid creatures called titans, forcing humans to hide in fear behind enormous concentric walls. What makes these giants truly terrifying is that their taste for human flesh is not born out of hunger but what appears to be out of pleasure. To ensure their survival, the remnants of humanity began living within defensive barriers, resulting in one hundred years without a single titan encounter. However, that fragile calm is soon shattered when a colossal titan manages to breach the supposedly impregnable outer wall, reigniting the fight for survival against the man-eating abominations.",
      rating: "8.53",
      episode: 25,
      categorie: "Action, Award Winning, Drama, Suspense",
      studio: "Wit Studio",
      img: "https://cdn.myanimelist.net/images/anime/10/47347.jpg"),
  Anime(
      name: "Death Note",
      description:
          "Brutal murders, petty thefts, and senseless violence pollute the human world. In contrast, the realm of death gods is a humdrum, unchanging gambling den. The ingenious 17-year-old Japanese student Light Yagami and sadistic god of death Ryuk share one belief: their worlds are rotten.",
      rating: "8.62",
      episode: 37,
      categorie: "Supernatural, Suspense",
      studio: "Madhouse",
      img: "https://cdn.myanimelist.net/images/anime/9/9453.jpg"),
  Anime(
      name: "Violet Evergarden",
      description:
          "There are words Violet heard on the battlefield, which she cannot forget. These words were given to her by someone she holds dear, more than anyone else. She does not yet know their meaning.A certain point in time, in the continent of Telesis. The great war which divided the continent into North and South has ended after four years, and the people are welcoming a new generation.",
      rating: "8.67",
      episode: 13,
      categorie: "Drama, Fantasy",
      studio: "Kyoto Animation",
      img: "https://cdn.myanimelist.net/images/anime/1795/95088.jpg"),
  Anime(
      name: "Tokyo Ghoul",
      description: "A  sinister threat is invading Tokyo: flesh-eating \"ghouls\" who appear identical to humans and blend into their population. Reserved college student Ken Kaneki buries his nose in books and avoids the news of the growing crisis. However, the appearance of an attractive woman named Rize Kamishiro shatters his solitude when she forwardly asks him on a date.",
      rating: "7.79",
      episode: 12,
      categorie: "Action, Fantasy, Horror",
      studio: "Studio Pierrot",
      img: "https://cdn.myanimelist.net/images/anime/1498/134443.jpg"),
  Anime(
      name: "Black Clover",
      description:
          "Asta and Yuno were abandoned at the same church on the same day. Raised together as children, they came to know of the Wizard King—a title given to the strongest mage in the kingdom—and promised that they would compete against each other for the position of the next Wizard King. However, as they grew up, the stark difference between them became evident. While Yuno is able to wield magic with amazing power and control, Asta cannot use magic at all and desperately tries to awaken his powers by training physically.",
      rating: "8.14",
      episode: 51,
      categorie: "Action, Comedy, Fantasy",
      studio: "Studio Pierrot",
      img: "https://cdn.myanimelist.net/images/anime/2/88336.jpg"),
  Anime(
      name: "Sword Art Online",
      description:
          "In the year 2022, virtual reality has progressed by leaps and bounds, and a massive online role-playing game called Sword Art Online (SAO) is launched. With the aid of NerveGear technology, players can control their avatars within the game using nothing but their own thoughts.",
      rating: "7.20",
      episode: 25,
      categorie: "Action, Adventure, Fantasy, Romance",
      studio: "A-1 Pictures",
      img: "https://cdn.myanimelist.net/images/anime/11/39717.jpg"),
  Anime(
      name: "Nanatsu no Taizai",
      description:
          "In a world similar to the European Middle Ages, the feared yet revered Holy Knights of Britannia use immensely powerful magic to protect the region of Britannia and its kingdoms. However, a small subset of the Knights supposedly betrayed their homeland and turned their blades against their comrades in an attempt to overthrow the ruler of Liones. They were defeated by the Holy Knights, but rumors continued to persist that these legendary knights, called the \"Seven Deadly Sins,\" were still alive. Ten years later, the Holy Knights themselves staged a coup d’état, and thus became the new, tyrannical rulers of the Kingdom of Liones.",
      rating: "7.67",
      episode: 24,
      categorie: "AAction, Adventure, Fantasy",
      studio: "A-1 Pictures",
      img: "https://cdn.myanimelist.net/images/anime/8/65409.jpg"),
  Anime(
      name: "Kiseijuu: Sei no Kakuritsu",
      description:
          "All of a sudden, they arrived: parasitic aliens that descended upon Earth and quickly infiltrated humanity by burrowing into the brains of vulnerable targets. These insatiable beings acquire full control of their host and are able to morph into a variety of forms in order to feed on unsuspecting prey.",
      rating: "8.34",
      episode: 24,
      categorie: "Action, Horror, Sci-Fi",
      studio: "Madhouse",
      img: "https://cdn.myanimelist.net/images/anime/3/73178.jpg"),
  Anime(
      name: "Hunter x Hunter (2011)",
      description:
          "Hunters devote themselves to accomplishing hazardous tasks, all from traversing the world's uncharted territories to locating rare items and monsters. Before becoming a Hunter, one must pass the Hunter Examination—a high-risk selection process in which most applicants end up handicapped or worse, deceased.",
      rating: "9.04",
      episode: 148,
      categorie: "Action, Adventure, Fantasy",
      studio: "Madhouse",
      img: "https://cdn.myanimelist.net/images/anime/1337/99013.jpg")
];*/
