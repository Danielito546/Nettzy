class Note {
  final String title;
  final String content;
  bool completed;
  DateTime startDate;
  DateTime endDate;

  Note({
    required this.title,
    required this.content,
    this.completed = false,
    required this.startDate,
    required this.endDate,
  });
}
