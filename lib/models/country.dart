class Country {
  final String id; // Menggunakan nanoid
  final String code;
  final String name;
  final String description;
  final String flagUrl;

  Country({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.flagUrl,
  });
}
