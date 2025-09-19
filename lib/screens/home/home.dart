import 'package:flutter/material.dart';
import 'package:flutter_characters/screens/home/character_card.dart';
import 'package:flutter_characters/services/character_store.dart';
import 'package:flutter_characters/shared/styled_button.dart';
import 'package:flutter_characters/shared/styled_text.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Provider.of<CharacterStore>(context, listen: false).fetchCharactersOnce();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Your Characters'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: const StyledHeadline('Characters List'),
              ),
              Expanded(
                // if i want to use child from Consumer, make the parent widget Consumer -> Column -> Expanded -> ListView
                child: Consumer<CharacterStore>(
                  builder: (context, value, _) {
                    // if not using child in the third parameter, just use _
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.characters.length,
                      itemBuilder: (context, index) {
                        return CharacterCard(
                          character: value.characters[index],
                        );
                      },
                    );
                  },
                ),
              ),
              StyledButtonOne(
                onPressed: () {
                  Navigator.pushNamed(context, '/create');
                },
                child: const StyledHeadline('Add Character'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
