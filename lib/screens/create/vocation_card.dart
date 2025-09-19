import 'package:flutter/material.dart';
import 'package:flutter_characters/models/vocation.dart';
import 'package:flutter_characters/shared/styled_text.dart';
import 'package:flutter_characters/theme.dart';

class VocationCard extends StatelessWidget {
  const VocationCard({
    super.key,
    required this.vocation,
    required this.onTap,
    required this.isSelected,
  });

  final Vocation vocation;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side:
              isSelected
                  ? BorderSide(color: AppColors.secondaryColor, width: 2)
                  : BorderSide(color: Colors.transparent, width: 0),
        ),
        color: isSelected ? AppColors.secondaryColor : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              //vocation img
              Image.asset(
                'assets/img/vocations/${vocation.image}',
                width: 80,
                colorBlendMode: BlendMode.color,
                fit: BoxFit.cover,
                color: !isSelected ? Colors.grey : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    StyledHeadline(vocation.title),
                    const SizedBox(height: 4),
                    StyledText(vocation.description),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
