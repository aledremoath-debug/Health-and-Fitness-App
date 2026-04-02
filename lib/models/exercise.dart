class Exercise {
  final int id;
  final Map<String, String> name;
  final List<String> goal;
  final Map<String, String> muscle;
  final String duration;
  final int calories;
  final String image;
  final Map<String, List<String>> instructions;

  Exercise({
    required this.id,
    required this.name,
    required this.goal,
    required this.muscle,
    required this.duration,
    required this.calories,
    required this.image,
    required this.instructions,
  });
}
