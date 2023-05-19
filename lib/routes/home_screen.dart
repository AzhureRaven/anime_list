import 'package:anime_list/routes/account/login_screen.dart';
import 'package:anime_list/routes/anime/manage_anime_screen.dart';
import 'package:anime_list/routes/anime/anime_list_screen.dart';
import 'package:flutter/material.dart';
import '../dialogs/yes_no_dialog.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return YesNoDialog(
                    onSuccess: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const LoginScreen();
                      }));
                    }, title: 'Logout?', content: '',
                  );
                },
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        switch (pil) {
          case 0:
            return const AnimeListScreen();
            break;
          case 1:
            return ManageAnimeScreen(onSuccess: () {
              setState(() {
                pil = 0;
                ScaffoldMessenger.of(context)
                    .showSnackBar(basicSnackBar("New Anime Added"));
              });
            });
            break;
          default:
            return HomeScreen();
            break;
        }
      }),
      bottomNavigationBar: Builder(
        builder: (BuildContext context) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt), label: "List"),
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
