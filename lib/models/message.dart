class Message {
  final String message;
  final String id;
  Message(this.message, {required this.id});
  factory Message.fromjson(json) {
    return Message(json['message'], id: json['id']);
  }
}
