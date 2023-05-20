import 'package:anime_list/providers/anime_provider.dart';
import 'package:anime_list/providers/secured_storage.dart';
import 'package:anime_list/routes/account/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  await SecuredStorage.initialize();
  await Future.delayed(const Duration(seconds: 2));
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
          theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.indigo,
                accentColor: Colors.blueAccent,
                brightness: Brightness.light,
                backgroundColor: Colors.white,
              ),
              primaryColorDark: Colors.white,
              dividerColor: Colors.grey[400],
              disabledColor: Colors.grey[400],
              cardTheme: const CardTheme(color: Colors.white,elevation: 3,)
          ),
          darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.blue,
                  accentColor: Colors.blueAccent,
                  brightness: Brightness.dark,
                  backgroundColor: Colors.grey[900]
              ),
              primaryColorDark: Colors.white,
              dividerColor: Colors.grey[700],
              disabledColor: Colors.grey[700],
              cardTheme: CardTheme(color: Colors.grey[800], elevation: 3)
          ),
          home: const LoginScreen(),
        ),
      ),
    );
  }
}