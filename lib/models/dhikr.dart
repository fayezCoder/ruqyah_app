class Dhikr {
  final String text;
  final String translation;
  final String reference;
  final int repeat;
  final bool favorite;

  Dhikr({
    required this.text,
    required this.translation,
    required this.reference,
    required this.repeat,
    this.favorite = false,
  });
}

class DhikrCategory {
  final String name;
  final String icon;
  final List<Dhikr> dhikrs;

  DhikrCategory({
    required this.name,
    required this.icon,
    required this.dhikrs,
  });
}
