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
  static Future<void> updateCharacter(Character character) async {
    await ref.doc(character.id).update({
      'stats': character.statsAsMap, // statsAsMap getter is called
      'points': character.points,
      'skills': character.skills.map((s) => s.id),
      'isFav': character.isFav,
    });
  }

  // delete a character
  static Future<void> deleteCharacter(Character character) async {
    await ref.doc(character.id).delete();
  }
}
