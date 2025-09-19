import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_characters/models/skill.dart';
import 'package:flutter_characters/models/stats.dart';
import 'package:flutter_characters/models/vocation.dart';

class Character with Stats {
  // Constructor
  Character({
    required this.id,
    required this.name,
    required this.slogan,
    required this.vocation,
  });

  // Fields
  final Set<Skill> skills = {};
  final Vocation vocation;
  final String name;
  final String slogan;
  final String id;
  bool _isFav = false; // private with the underscore

  // getters
  bool get isFav => _isFav;

  void toggleIsFav() {
    _isFav = !_isFav;
  }

  void updateSkill(Skill skill) {
    // One skill object can be active at a time
    skills.clear();
    skills.add(skill);
  }

  // character to firestore (map)
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'slogan': slogan,
      'isFav': _isFav,
      'vocation':
          vocation
              .toString(), // this becomes vocation.junkie --> the junkie became a string,. basically a label?
      'skills':
          skills
              .map((s) => s.id)
              .toList(), // since the skills are all hard coded and a fixed set, we map each one and put it all ids in the list
      'stats': statsAsMap,
      'points': points,
    };
  }

  // character from firestore
  factory Character.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    // get data
    final data = snapshot.data()!;

    // make character instance
    Character character = Character(
      id: snapshot.id,
      name: data['name'],
      slogan: data['slogan'],
      vocation: Vocation.values.firstWhere(
        (v) => v.toString() == data['vocation'],
      ),
    );

    // update skill
    for (String id in data['skills']) {
      Skill skill = allSkills.firstWhere((s) => s.id == id);
      character.updateSkill(skill);
    }

    // set isFav
    if (data['isFav'] == true) {
      character.toggleIsFav();
    }

    // assign stats and points
    Map<String, dynamic> statsMap = {};
    // character.setStats(points: data['points'], stats: data['stats']);
    for (var stat in data['stats']) {
      statsMap[stat['title']] = int.parse(stat['value']);
    }
    character.setStats(points: data['points'], stats: statsMap);

    return character;
  }
}
