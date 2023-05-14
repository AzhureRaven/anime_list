import 'package:anime_list/routes/manage_anime_screen.dart';
import 'package:anime_list/routes/anime_list_screen.dart';
import 'package:flutter/material.dart';
import '../utlis/snackbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pil = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anime List"),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        switch(pil){
          case 0: return AnimeListScreen(); break;
          case 1: return ManageAnimeScreen(onSuccess: (){
           setState(() {
             pil = 0;
             ScaffoldMessenger.of(context).showSnackBar(basicSnackBar("New Anime Added"));
           });
          }); break;
          default: return HomeScreen(); break;
        }
      }),
      bottomNavigationBar: Builder(
        builder: (BuildContext context) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "List"),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
              //BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
            ],
            currentIndex: pil,
            onTap: (index) {
              setState(() {
                pil = index;
              });
            },
          );
        },
      ),
    );
  }
}
