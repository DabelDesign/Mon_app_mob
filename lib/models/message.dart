class Message {
  final String senderID;
  final String content;
  final String? fileURL;
  final DateTime timestamp;

  Message({
    required this.senderID,
    required this.content,
    this.fileURL,
    required this.timestamp,
  });

  /// Convertit un document JSON en objet `Message`
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderID: json['senderID'] as String,
      content: json['content'] as String,
      fileURL: json['fileURL'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  /// Permet de créer une copie modifiée de l’objet `Message`
  Message copyWith({
    String? senderID,
    String? content,
    String? fileURL,
    DateTime? timestamp,
  }) {
    return Message(
      senderID: senderID ?? this.senderID,
      content: content ?? this.content,
      fileURL: fileURL ?? this.fileURL,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  /// Convertit un objet `Message` en JSON pour Appwrite
  Map<String, dynamic> toJson() {
    return {
      'senderID': senderID,
      'content': content,
      'fileURL': fileURL,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
