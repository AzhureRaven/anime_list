import 'package:anime_list/models/anime.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/episode.dart';
import '../../providers/anime_provider.dart';

class ManageEpisodeScreen extends StatefulWidget {
  final VoidCallback onSuccess;
  final Anime anime;
  final Episode? episode;
  const ManageEpisodeScreen({Key? key, required this.onSuccess, required this.anime, required this.episode}) : super(key: key);

  @override
  State<ManageEpisodeScreen> createState() => _ManageEpisodeScreenState();
}

class _ManageEpisodeScreenState extends State<ManageEpisodeScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _noController;
  bool watched = false;
  String mode = "add";

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey <FormState>();
    _nameController = TextEditingController();
    _noController = TextEditingController();
    isEdit();
  }

  void isEdit(){
    if(widget.episode != null){
      mode = "edit";
      _nameController.text = widget.episode!.name;
      _noController.text = widget.episode!.no.toString();
      watched = widget.episode!.watched;
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
                        controller: _noController,
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
                          labelText: "Episode No.",
                        ),
                      ),
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
                          labelText: "Episode Name",
                        ),
                      ),
                      ListTile(
                        leading: Checkbox(
                          value: watched,
                          onChanged: (bool? value) {
                            setState(() {
                              watched = value!;
                            });
                          },
                        ),
                        title: const Text('Already Watched?'),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                if(mode == "add"){
                                  widget.anime.episodes.add(Episode(no: int.parse(_noController.text.toString()), name: _nameController.text, watched: watched));
                                }
                                else{
                                  widget.episode!.name = _nameController.text;
                                  widget.episode!.no = int.parse(_noController.text.toString());
                                  widget.episode!.watched = watched;
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
