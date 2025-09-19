import 'package:flutter/material.dart';
import 'package:flutter_characters/models/character.dart';
import 'package:flutter_characters/models/skill.dart';
import 'package:flutter_characters/shared/styled_text.dart';
import 'package:flutter_characters/theme.dart';

class SkillList extends StatefulWidget {
  const SkillList(this.character, {super.key});

  final Character? character;
  @override
  State<SkillList> createState() => _SkillListState();
}

class _SkillListState extends State<SkillList> {
  late List<Skill> availableSkills = [];
  late Skill? selectedSkill;

  @override
  void initState() {
    super.initState();
    availableSkills =
        allSkills.where((skill) {
          return skill.vocation == widget.character?.vocation;
        }).toList();

    if (widget.character?.skills != null && widget.character!.skills.isEmpty) {
      selectedSkill = availableSkills.first;
    } else if (widget.character?.skills != null &&
        widget.character!.skills.isNotEmpty) {
      selectedSkill = widget.character!.skills.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        color: AppColors.secondaryColor.withAlpha(100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const StyledHeadline('Choose an Active Skill'),
            const SizedBox(height: 20),
            Row(
              children:
                  availableSkills.map((skill) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(2),
                        color:
                            skill == selectedSkill
                                ? Colors.blue[300]
                                : Colors.transparent,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.character!.updateSkill(skill);
                              selectedSkill = skill;
                            });
                          },
                          child: Image.asset(
                            'assets/img/skills/${skill.image}',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 10),
            StyledText('text'),
          ],
        ),
      ),
    );
  }
}
