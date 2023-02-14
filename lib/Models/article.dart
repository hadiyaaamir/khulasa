class article {
  String title;
  String summary;
  String content;
  String category;

  article({
    required this.title,
    required this.summary,
    required this.content,
    this.category = "",
  });
}
