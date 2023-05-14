import 'package:anime_list/models/anime.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/anime_provider.dart';

class ManageAnimeScreen extends StatefulWidget {
  final VoidCallback onSuccess;
  final Anime? anime;
  const ManageAnimeScreen({Key? key, required this.onSuccess, this.anime}) : super(key: key);

  @override
  State<ManageAnimeScreen> createState() => _ManageAnimeScreenState();
}

class _ManageAnimeScreenState extends State<ManageAnimeScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _descController;
  late final TextEditingController _ratingController;
  late final TextEditingController _epController;
  late final TextEditingController _catController;
  late final TextEditingController _studioController;
  late final TextEditingController _imgController;
  String mode = "add";

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey <FormState>();
    _nameController = TextEditingController();
    _descController = TextEditingController();
    _epController = TextEditingController();
    _ratingController = TextEditingController();
    _catController = TextEditingController();
    _studioController = TextEditingController();
    _imgController = TextEditingController();
    isEditAnime();
  }

  void isEditAnime(){
    if(widget.anime != null){
      mode = "edit";
      _nameController.text = widget.anime!.name;
      _descController.text = widget.anime!.description;
      _epController.text = widget.anime!.episode.toString();
      _ratingController.text = widget.anime!.rating;
      _catController.text = widget.anime!.categorie;
      _studioController.text = widget.anime!.studio;
      _imgController.text = widget.anime!.img;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnimeProvider>(
        builder: (context, AnimeProvider data, widgets){
          return SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        textInputAction: TextInputAction.next,
                        validator: (data) {
                          if (data != null && data != "") {
                            return null;
                          } else {
                            return "Field is required!";
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: "Name",
                        ),
                      ),
                      TextFormField(
                        controller: _descController,
                        textInputAction: TextInputAction.next,
                        validator: (data) {
                          if (data != null && data != "") {
                            return null;
                          } else {
                            return "Field is required!";
                          }
                        },
                        decoration: const InputDecoration(
                            labelText: "Description"
                        ),
                      ),
                      TextFormField(
                        controller: _ratingController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (data) {
                          if(data == null || data == ""){
                            return "Field is required!";
                          }
                          if(double.tryParse(data.toString()) == null){
                            return "Field must be number!";
                          }
                          if(1 > double.parse(data.toString()) || 10 < double.parse(data.toString())){
                            return "Field must be between 1-10!";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Rating",
                        ),
                      ),
                      TextFormField(
                        controller: _epController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (data) {
                          if(data == null || data == ""){
                            return "Field is required!";
                          }
                          if(int.tryParse(data.toString()) == null){
                            return "Field must be integer!";
                          }
                          if(1 > int.parse(data.toString())){
                            return "Field must be between > 0!";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Episode",
                        ),
                      ),
                      TextFormField(
                        controller: _catController,
                        textInputAction: TextInputAction.next,
                        validator: (data) {
                          if (data != null && data != "") {
                            return null;
                          } else {
                            return "Field is required!";
                          }
                        },
                        decoration: const InputDecoration(
                            labelText: "Categories"
                        ),
                      ),
                      TextFormField(
                        controller: _studioController,
                        textInputAction: TextInputAction.next,
                        validator: (data) {
                          if (data != null && data != "") {
                            return null;
                          } else {
                            return "Field is required!";
                          }
                        },
                        decoration: const InputDecoration(
                            labelText: "Studio"
                        ),
                      ),
                      TextFormField(
                        controller: _imgController,
                        validator: (data) {
                          if (data != null && data != "") {
                            return null;
                          } else {
                            return "Field is required!";
                          }
                        },
                        decoration: const InputDecoration(
                            labelText: "Img Link"
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  if(mode == "add"){
                                    data.add(Anime(name: _nameController.text, description: _descController.text, rating: _ratingController.text, episode: int.parse(_epController.text), categorie: _catController.text, studio: _studioController.text, img: _imgController.text));
                                  }
                                  else{
                                    widget.anime!.name = _nameController.text;
                                    widget.anime!.description = _descController.text;
                                    widget.anime!.rating = _ratingController.text;
                                    widget.anime!.episode = int.parse(_epController.text);
                                    widget.anime!.categorie = _catController.text;
                                    widget.anime!.studio = _studioController.text;
                                    widget.anime!.img = _imgController.text;
                                  }
                                  widget.onSuccess.call();
                                }
                              }, child: const Text("Submit")),
                          ),
                        ],
                      )
                    ],
                  ),
                )
            ),
          );
        }
    );
  }
}
