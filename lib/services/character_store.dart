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
    _characters.add(
      character,
    ); // this is adding updating global state -> UI purposes
    notifyListeners();
  }

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

  // save (update) character
  Future<void> saveCharacter(Character character) async {
    await FirestoreService.updateCharacter(character);
    return;
    // no need to notify listener since the displayed data is already "updated"
  }

  // remove character
  void removeCharacter(Character character) async {
    await FirestoreService.deleteCharacter(character);
    _characters.remove(
      character,
    ); // removes the character in the list -> UIpurposes
    notifyListeners(); // to rebuild the widget || if we dont remove the character, the list still has it, and even if we rebuilt, the deleted character would still be there
  }
}
