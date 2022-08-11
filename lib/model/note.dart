class Note {
  final DateTime date;
  final String content;

  Note({
    required this.date,
    required this.content,
  });

  // toJson
  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'content': content,
      };

  // fromJson
  factory Note.fromJson(Map<String, dynamic> json) => Note(
        date: DateTime.parse(json['date']),
        content: json['content'],
      );
}
