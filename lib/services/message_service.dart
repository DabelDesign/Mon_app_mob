import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class MessageService {
  final Client client;
  final Databases database;
  final String databaseId = 'YOUR_DATABASE_ID';
  final String collectionId = 'messages';

  MessageService(this.client) : database = Databases(client);

  Future<List<Document>> getMessages() async {
    try {
      DocumentList response = await database.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
      );
      return response.documents;
    } catch (e) {
      print('Erreur lors de la récupération des messages: $e');
      return [];
    }
  }

  Future<void> sendMessage(
      String senderID, String content, String? fileURL) async {
    try {
      await database.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: ID.unique(),
        data: {
          'senderID': senderID,
          'content': content,
          'timestamp': DateTime.now().toIso8601String(),
          'fileURL': fileURL,
        },
      );
    } catch (e) {
      print('Erreur lors de l\'envoi du message: $e');
    }
  }
}
