class NoteModal {
  final List<String> category;
  final String dateRegistration;
  final String excluded;
  final String noteId;
  final String userId;
  final String note;
  final List<String> shared;
  final String title;

  NoteModal({
    required this.category,
    required this.dateRegistration,
    required this.excluded,
    required this.noteId,
    required this.userId,
    required this.note,
    required this.shared,
    required this.title,
  });
}
