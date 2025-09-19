import 'package:flutter/material.dart';
import 'package:flutter_characters/models/character.dart';
import 'package:flutter_characters/shared/styled_text.dart';
import 'package:flutter_characters/theme.dart';

class StatsTable extends StatefulWidget {
  const StatsTable(this.character, {super.key});

  final Character? character;

  @override
  State<StatsTable> createState() => _StatsTableState();
}

class _StatsTableState extends State<StatsTable> {
  double turns = 0.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          // available points
          Container(
            color: AppColors.secondaryColor,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                AnimatedRotation(
                  turns: turns,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.star,
                    color:
                        (widget.character?.points ?? 0) > 0
                            ? Colors.yellow
                            : Colors.grey,
                    // So (widget.character?.points ?? 0) means:
                    // If widget.character?.points is not null, use that value
                    // If widget.character?.points is null, use 0 instead
                  ),
                ),
                const SizedBox(width: 20),
                const StyledText('Stats point available:'),
                Expanded(child: SizedBox(width: 20)),
                StyledHeadline(widget.character?.points.toString() ?? '0'),
              ],
            ),
          ),

          // stats table
          Table(
            // border: TableBorder.all(color: Colors.black54),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children:
                widget.character?.statsAsMap.map((stat) {
                  return TableRow(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor.withAlpha(200),
                    ),
                    children: <Widget>[
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: StyledHeadline(stat['title']!),
                        ),
                      ),
                      // stats value
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: StyledHeadline(stat['value']!),
                        ),
                      ),
                      // increase icon
                      TableCell(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (widget.character?.points == 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    showCloseIcon: true,
                                    duration: const Duration(seconds: 2),
                                    backgroundColor: AppColors.secondaryColor,
                                    content: Text(
                                      'Cannot increase ${stat['title']!.toUpperCase()} - You have no skill points remaining. Try decreasing other stats first.',
                                    ),
                                  ),
                                );
                                return; // Exit the function early
                              }
                              widget.character?.increaseStat(stat['title']!);
                              turns += 0.25;
                            });
                          },
                          icon: const Icon(Icons.arrow_upward),
                        ),
                      ),
                      // decrease icon
                      TableCell(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              // Check if the stat value is 5 or less
                              int statValue = int.parse(stat['value']!);
                              if (statValue <= 5) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    showCloseIcon: true,
                                    duration: const Duration(seconds: 2),
                                    backgroundColor: AppColors.secondaryColor,
                                    content: Text(
                                      'Cannot decrease ${stat['title']!.toUpperCase()} below 5.',
                                    ),
                                  ),
                                );
                                return; // Exit the function early
                              }
                              widget.character?.decreaseStat(stat['title']!);
                              turns -= 0.25;
                            });
                          },
                          icon: const Icon(Icons.arrow_downward),
                        ),
                      ),
                    ],
                  );
                }).toList() ??
                [
                  TableRow(children: [Text('No stats available')]),
                ],
          ),
        ],
      ),
    );
  }
}
