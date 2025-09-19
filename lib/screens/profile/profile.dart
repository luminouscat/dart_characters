import 'package:flutter/material.dart';
import 'package:flutter_characters/models/character.dart';
import 'package:flutter_characters/screens/profile/skill_list.dart';
import 'package:flutter_characters/screens/profile/stats_table.dart';
import 'package:flutter_characters/services/character_store.dart';
import 'package:flutter_characters/shared/styled_button.dart';
import 'package:flutter_characters/shared/styled_text.dart';
import 'package:flutter_characters/theme.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: StyledHeadline(character.name), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // basic description
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.secondaryColor.withValues(alpha: 0.3),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/img/vocations/${character.vocation.image}',
                    width: 140,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        StyledText(character.name),
                        StyledText(character.vocation.title),
                        StyledText(
                          character.slogan,
                        ), // use expanded if overflow occurs
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // weapon and ability -> comes from vocation
            const SizedBox(height: 20),
            Center(
              child: Icon(Icons.code, color: AppColors.primaryColor, size: 30),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: AppColors.secondaryColor.withValues(alpha: 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    StyledHeadline('Slogan'),
                    StyledText(character.slogan),
                    const SizedBox(height: 10),
                    StyledHeadline('Weapon'),
                    StyledText(character.vocation.weapon),
                    const SizedBox(height: 10),
                    StyledHeadline('Ability'),
                    StyledText(character.vocation.ability),
                  ],
                ),
              ),
            ),

            // stats and skills
            const SizedBox(height: 20),
            Center(
              child: Icon(Icons.code, color: AppColors.primaryColor, size: 30),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: AppColors.secondaryColor.withValues(alpha: 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        StyledHeadline('Stats'),
                        const SizedBox(height: 10),
                        StatsTable(character),
                        const SizedBox(height: 20),
                        SkillList(character),
                      ],
                    ),
                    // StyledHeadline('Weapon'),
                    // StyledText(character.vocation.weapon),
                    // const SizedBox(height: 10),
                    // StyledHeadline('Ability'),
                    // StyledText(character.vocation.ability),
                  ],
                ),
              ),
            ),

            // save button
            StyledButtonOne(
              child: StyledHeadline('Save Character'),
              onPressed: () {
                Provider.of<CharacterStore>(
                  context,
                  listen: false,
                ).saveCharacter(character);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    showCloseIcon: true,
                    duration: const Duration(seconds: 2),
                    backgroundColor: AppColors.secondaryColor,
                    content: Text('Character is saved'),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
