import 'package:anime_list/providers/anime_provider.dart';
import 'package:anime_list/routes/account/login_screen.dart';
import 'package:anime_list/routes/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>AnimeProvider(),
      child: GlobalLoaderOverlay(
        child: MaterialApp(
          title: 'Anime List',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const LoginScreen(),
        ),
      ),
    );
  }
}