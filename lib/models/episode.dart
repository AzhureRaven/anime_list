import 'dart:convert';

class Episode {
  late int no;
  late String name;
  late bool watched;

  Episode({
    required this.no,
    required this.name,
    required this.watched,
  });

  Map<String, dynamic> toMap() {
    return {
      "no": no,
      "name": name,
      "watched": watched,
    };
  }

  Episode.fromMap(Map<String, dynamic> map) {
    no = int.parse(map["no"].toString());
    name = map["name"].toString();
    watched = map["watched"] as bool;
  }
}


/*List<Anime> parseAnime(String? json) {
  if (json == null) {
    return [];
  }

  final List<dynamic> parsed = jsonDecode(json);

  return parsed.map((json) => Anime.fromJson(json)).toList();
}*/

