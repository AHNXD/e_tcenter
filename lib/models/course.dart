class Course {
  final int categoryId;
  final int teacherId;
  final String name;
  final double price;
  final String description;
  final bool accepted;
  final double rate;

  Course({
    required this.categoryId,
    required this.teacherId,
    required this.name,
    required this.price,
    required this.description,
    required this.accepted,
    required this.rate,
  });
}
