class NoteModal {
  final List<String> category;
  final String dateRegistration;
  final bool excluded;
  final String noteId;
  final String note;
  final num position;
  final List<String> shared;
  final String title;
  final String userId;

  NoteModal({
    required this.category,
    required this.dateRegistration,
    required this.excluded,
    required this.noteId,
    required this.note,
    required this.position,
    required this.shared,
    required this.title,
    required this.userId,
  });
}
