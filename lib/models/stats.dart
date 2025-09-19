mixin Stats {
  int _points = 10;
  int _health = 10;
  int _attack = 10;
  int _defense = 10;
  int _skill = 10;

  int get points => _points;

  // // can do map get
  // Map<String, int> get statsAsMap => {
  //   'health': _health,
  //   'attack': _attack,
  //   'defense': _defense,
  //   'skill': _skill,
  // };

  List<Map<String, String>> get statsAsMap => [
    {'title': 'health', 'value': _health.toString()},
    {'title': 'attack', 'value': _attack.toString()},
    {'title': 'defense', 'value': _defense.toString()},
    {'title': 'skill', 'value': _skill.toString()},
  ];

  void increaseStat(String stat) {
    if (_points > 0) {
      switch (stat) {
        case 'health':
          _health++;
          break;
        case 'attack':
          _attack++;
          break;
        case 'defense':
          _defense++;
          break;
        case 'skill':
          _skill++;
          break;
        default:
          throw ArgumentError('Invalid stat name: $stat');
      }
      _points--;
    } else {
      throw StateError(
        'Cannot increase ${stat.toUpperCase()} - You have no skill points remaining. Try decreasing other stats first.',
      );
    }
  }

  void decreaseStat(String stat) {
    switch (stat) {
      case 'health':
        if (_health > 5) {
          _health--;
          _points++;
        }
        break;
      case 'attack':
        if (_attack > 5) {
          _attack--;
          _points++;
        }
        break;
      case 'defense':
        if (_defense > 5) {
          _defense--;
          _points++;
        }
        break;
      case 'skill':
        if (_skill > 5) {
          _skill--;
          _points++;
        }
        break;
      default:
        throw StateError('Invalid stat name: $stat');
    }
  }

  void setStats({required int points, required Map<String, dynamic> stats}) {
    _points = points;
    _health = stats['health'];
    _attack = stats['attack'];
    _defense = stats['defense'];
    _skill = stats['skill'];
  }
}
