import 'package:flutter/material.dart';
import 'package:flutter_characters/models/character.dart';
import 'package:flutter_characters/services/firestore_service.dart';

// GLOBALSTATE
class CharacterStore extends ChangeNotifier {
  final List<Character> _characters = [];

  get characters => _characters;

  // functions

  // add character
  void addCharacter(Character character) {
    FirestoreService.addCharacter(
      character,
    ); // this is adding character to the db
    _characters.add(character); // this is adding updating global state
    notifyListeners();
  }

  // get character

  // save (update) character

  // remove character

  // initially fetch characters
  void fetchCharactersOnce() async {
    final snapshot = await FirestoreService.getCharactersOnce();
    for (var doc in snapshot.docs) {
      _characters.add(
        doc.data(),
      ); // this is thanks to the converter, basically we cycle through the FIrestoreServices docs.data and add it to the list
    }
    notifyListeners();
  }
}
