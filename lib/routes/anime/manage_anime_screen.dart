import 'package:anime_list/models/anime.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/anime_provider.dart';

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
  late final TextEditingController _catController;
  late final TextEditingController _studioController;
  late final TextEditingController _imgController;
  String mode = "add";
  int flex = 0;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey <FormState>();
    _nameController = TextEditingController();
    _descController = TextEditingController();
    _ratingController = TextEditingController();
    _catController = TextEditingController();
    _studioController = TextEditingController();
    _imgController = TextEditingController();
    isEdit();
  }

  void isEdit(){
    if(widget.anime != null){
      mode = "edit";
      _nameController.text = widget.anime!.name;
      _descController.text = widget.anime!.description;
      _ratingController.text = widget.anime!.rating;
      _catController.text = widget.anime!.categories;
      _studioController.text = widget.anime!.studio;
      _imgController.text = widget.anime!.img;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descController.dispose();
    _ratingController.dispose();
    _catController.dispose();
    _studioController.dispose();
    _imgController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnimeProvider>(
        builder: (context, AnimeProvider data, widgets){
          return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxWidth <= 600) {
                  flex = 0;
                } else if (constraints.maxWidth <= 1200) {
                  flex = 1;
                } else {
                  flex = 2;
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Form(
                      key: _formKey,
                      child: Row(
                        children: [
                          Expanded(flex: flex, child: Row()),
                          Expanded(
                              flex: 2,
                              child: buildForm(data)
                          ),
                          Expanded(flex: flex, child: Row())
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
    );
  }

  Widget buildForm(AnimeProvider data){
    return Column(
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
                    data.add(Anime(name: _nameController.text, description: _descController.text, rating: _ratingController.text, episodes: [], categories: _catController.text, studio: _studioController.text, img: _imgController.text));
                  }
                  else{
                    widget.anime!.name = _nameController.text;
                    widget.anime!.description = _descController.text;
                    widget.anime!.rating = _ratingController.text;
                    widget.anime!.categories = _catController.text;
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
    );
  }
}
