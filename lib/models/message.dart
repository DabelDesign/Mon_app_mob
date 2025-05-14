class Message {
  final String senderID;
  final String content;
  final String? fileURL;
  final DateTime timestamp;

  Message(
      {required this.senderID,
      required this.content,
      this.fileURL,
      required this.timestamp});
}
