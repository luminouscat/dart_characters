import 'package:flutter/material.dart';
import 'package:flutter_characters/models/character.dart';
import 'package:flutter_characters/screens/profile/profile.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 25),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/img/vocations/${character.vocation.image}',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  character.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  character.vocation.title,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                // Text(
                //   character.slogan,
                //   softWrap: true,
                //   style: const TextStyle(fontSize: 14, color: Colors.grey),
                // ), // use expanded if overflow occurs
              ],
            ),
            // const SizedBox(width: 8),
            const Spacer(),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios_rounded),
              color: Colors.white,
              onPressed: () {
                // using this way needed ModalRoute in profile.dart to extract the arguments
                // Navigator.pushNamed(context, '/profile', arguments: character);
                // if using the direct way without named routes; no need to manipulate the routes in main.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(character: character),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
