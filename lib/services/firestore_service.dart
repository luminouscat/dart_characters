import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_characters/models/character.dart';

class FirestoreService {
  static final ref = FirebaseFirestore.instance
      .collection('characters')
      .withConverter(
        // withConvereter it auto calls both methods
        fromFirestore: Character.fromFirestore,
        toFirestore:
            (Character c, _) =>
                c.toFirestore(), // so it can be called later when we wanna update the database
      );

  // add a new character
  static Future<void> addCharacter(Character character) async {
    await ref
        .doc(character.id)
        .set(
          character,
        ); // so ref.doc is to find if the character if exists or not, it makes a new character! But if it does exist, it overwrites the whole thing.
  }

  // get character once
  static Future<QuerySnapshot<Character>> getCharactersOnce() {
    return ref.get();
  }

  // update
  static Future<QuerySnapshot<Character>> updateCharacter() {
    return ref.get();
  }

  // delete
}
