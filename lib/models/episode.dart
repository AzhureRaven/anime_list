import 'dart:convert';

class Episode {
  int no;
  String name;
  bool watched;

  Episode({required this.no,
    required this.name,
    required this.watched});

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
        no: int.parse(json['no'].toString()),
        name: json['name'].toString(),
        watched: json['watched']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['name'] = this.name;
    data['watched'] = this.watched;
    return data;
  }
}

/*List<Anime> parseAnime(String? json) {
  if (json == null) {
    return [];
  }

  final List<dynamic> parsed = jsonDecode(json);

  return parsed.map((json) => Anime.fromJson(json)).toList();
}*/

