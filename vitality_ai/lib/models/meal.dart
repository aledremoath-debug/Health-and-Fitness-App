class Meal {
  final int id;
  final Map<String, String> name;
  final int calories;
  final Map<String, int> macros;
  final List<String> type;
  final String image;
  final Map<String, List<String>> ingredients;
  final Map<String, List<String>> steps;

  Meal({
    required this.id,
    required this.name,
    required this.calories,
    required this.macros,
    required this.type,
    required this.image,
    required this.ingredients,
    required this.steps,
  });
}
