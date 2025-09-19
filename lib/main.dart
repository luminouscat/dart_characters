import 'package:flutter/material.dart';
import 'package:flutter_characters/screens/home/home.dart';
import 'package:flutter_characters/services/character_store.dart';
import 'package:flutter_characters/theme.dart';
import 'package:flutter_characters/screens/create/create_character.dart';
import 'package:provider/provider.dart';

//Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //could use myApp like used too and just change the myapp into materialapp
  runApp(
    ChangeNotifierProvider(
      create: (context) => CharacterStore(),
      child: MaterialApp(
        theme: primaryTheme,
        home: const Home(),
        routes: {
          '/create': (context) => const CreateCharacter(),
          '/sandbox': (context) => const Sandbox(),
        },
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

//in case of testing
class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandbox'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: const Center(child: Text('Welcome to the Sandbox!')),
    );
  }
}
