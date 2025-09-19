import 'package:flutter/material.dart';
import 'package:flutter_characters/models/character.dart';
import 'package:flutter_characters/models/vocation.dart';
import 'package:flutter_characters/screens/create/vocation_card.dart';
import 'package:flutter_characters/services/character_store.dart';
import 'package:flutter_characters/shared/styled_button.dart';
import 'package:flutter_characters/shared/styled_text.dart';
import 'package:flutter_characters/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class CreateCharacter extends StatefulWidget {
  const CreateCharacter({super.key});

  @override
  State<CreateCharacter> createState() => _CreateCharacterState();
}

class _CreateCharacterState extends State<CreateCharacter> {
  final _nameController = TextEditingController();
  final _sloganController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  void handleSubmit() {
    final name = _nameController.text;
    final slogan = _sloganController.text;

    // snackbar
    // if (name.isEmpty || slogan.isEmpty) {
    //   // Show an error message or handle empty fields
    //   ScaffoldMessenger.of(
    //     context,
    //   ).showSnackBar(SnackBar(content: Text('Please fill in all fields')));
    //   return;
    // }

    // alert dialog
    if (name.isEmpty || slogan.isEmpty) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              contentPadding: const EdgeInsets.all(20),
              title: const StyledTitle('Error'),
              content: const StyledText('Please fill in all fields'),
              actions: [
                StyledButtonOne(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const StyledText('Close'),
                ),
              ],
              actionsAlignment: MainAxisAlignment.center,
            ),
      );
      return;
    }

    // Process the character creation logic here
    print('Character Created: Name - $name, Slogan - $slogan');

    // Clear the input fields after submission
    _nameController.clear();
    _sloganController.clear();

    // characters.add(
    //   Character(
    //     id: uuid.v4(),
    //     name: name,
    //     slogan: slogan,
    //     vocation: selectedVocation,
    //   ),
    // );

    Provider.of<CharacterStore>(context, listen: false).addCharacter(
      Character(
        id: uuid.v4(),
        name: name,
        slogan: slogan,
        vocation: selectedVocation,
      ),
    );

    // Navigator.pushNamed(context, '/home');
    Navigator.pop(context);
  }

  // handle vocation
  Vocation selectedVocation = Vocation.junkie;

  void handleVocation(Vocation v) {
    setState(() {
      selectedVocation = v;
    });
    print('Selected Vocation: ${v.title}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Character Creation'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 22.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              // welcome message
              Center(
                child: Icon(
                  Icons.code,
                  color: AppColors.primaryColor,
                  size: 25,
                ),
              ),
              const Center(child: StyledHeadline('Welcome, new player!')),
              const Center(
                child: StyledText(
                  'Create a name and slogan for your character.',
                ),
              ),
              const SizedBox(height: 30),

              // name input
              TextField(
                style: GoogleFonts.kanit(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_2, color: Colors.grey),
                  label: StyledText('Character Name'),
                ),
                cursorColor: AppColors.textColor,
                controller: _nameController,
              ),
              SizedBox(height: 10),
              // slogan input
              TextField(
                style: GoogleFonts.kanit(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.tag, color: Colors.grey),
                  label: StyledText('Character Slogan'),
                ),
                cursorColor: AppColors.textColor,
                controller: _sloganController,
              ),
              const SizedBox(height: 30),

              // select vocation
              const Center(child: StyledHeadline('Select a Vocation')),
              const Center(
                child: StyledText('Determines your character\'s abilities.'),
              ),
              const SizedBox(height: 30),

              // vocation card
              VocationCard(
                isSelected: selectedVocation == Vocation.junkie,
                onTap: () => handleVocation(Vocation.junkie),
                vocation: Vocation.junkie,
              ),
              VocationCard(
                isSelected: selectedVocation == Vocation.ninja,
                onTap: () => handleVocation(Vocation.ninja),
                vocation: Vocation.ninja,
              ),
              VocationCard(
                isSelected: selectedVocation == Vocation.raider,
                onTap: () => handleVocation(Vocation.raider),
                vocation: Vocation.raider,
              ),
              VocationCard(
                isSelected: selectedVocation == Vocation.wizard,
                onTap: () => handleVocation(Vocation.wizard),
                vocation: Vocation.wizard,
              ),

              // good luck message
              const Center(child: StyledHeadline('Good Luck!')),
              const Center(child: StyledText('Enjoy your adventure.')),
              const SizedBox(height: 30),

              Center(
                child: StyledButtonOne(
                  child: StyledHeadline('Create Character'),
                  onPressed: () {
                    handleSubmit();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
