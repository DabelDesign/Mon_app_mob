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
      final response = await database.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
      );
      return response.documents;
    } on AppwriteException catch (e) {
      print(
        '❌ Erreur Appwrite lors de la récupération des messages: ${e.message}',
      );
      return [];
    } catch (e) {
      print('❌ Erreur inconnue lors de la récupération des messages: $e');
      return [];
    }
  }

  Future<void> sendMessage(
    String senderID,
    String content,
    String? fileURL,
  ) async {
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
      print('✅ Message envoyé avec succès');
    } on AppwriteException catch (e) {
      print('❌ Erreur Appwrite lors de l\'envoi du message: ${e.message}');
    } catch (e) {
      print('❌ Erreur inconnue lors de l\'envoi du message: $e');
    }
  }
}
