class DBForm {
  late String username;
  late String question;

  DBForm({this.username='',this.question='',});

  factory DBForm.fromMap(Map<String, dynamic> json) => new DBForm(
    username: json['username'] ?? '',
    question: json['question'] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "username": username,
    "question": question,
  };

}