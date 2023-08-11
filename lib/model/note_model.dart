class NoteModel {
  late List<String> category;
  late int color;
  late String dateRegistration;
  late bool excluded;
  late String note;
  late String noteId;
  late int position;
  late List<String> shared;
  late String userId;
  late String title;

  NoteModel({
    required this.category,
    required this.color,
    required this.dateRegistration,
    required this.excluded,
    required this.note,
    required this.noteId,
    required this.position,
    required this.shared,
    required this.userId,
    required this.title,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      category: List<String>.from(map['category']),
      color: map['color'],
      dateRegistration: map['dateRegistration'],
      excluded: map['excluded'],
      noteId: map['noteId'],
      note: map['note'],
      position: map['position'],
      userId: map['userId'],
      shared: List<String>.from(map['shared']),
      title: map['title'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'color': color,
      'dateRegistration': dateRegistration,
      'excluded': excluded,
      'noteId': noteId,
      'userId': userId,
      'note': note,
      'shared': shared,
      'title': title,
    };
  }
}
