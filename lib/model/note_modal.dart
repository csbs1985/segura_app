class NoteModel {
  final List<String> category;
  final String dateRegistration;
  final bool excluded;
  final String noteId;
  final String userId;
  final String note;
  final List<String> shared;
  final String title;

  NoteModel({
    required this.category,
    required this.dateRegistration,
    required this.excluded,
    required this.noteId,
    required this.userId,
    required this.note,
    required this.shared,
    required this.title,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      category: List<String>.from(map['category']),
      dateRegistration: map['dateRegistration'],
      excluded: map['excluded'],
      noteId: map['noteId'],
      userId: map['userId'],
      note: map['note'],
      shared: List<String>.from(map['shared']),
      title: map['title'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
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
