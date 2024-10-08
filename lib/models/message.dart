class Message {
  final String role;
  final String content;

  Message({required this.role, required this.content});

  Map<String, dynamic> toJson() => {
    'role': role,
    'content': content,
  };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    role: json['role'],
    content: json['content'],
  );
}