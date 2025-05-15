import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';

class FileService {
  final Client client;
  final Storage storage;
  final String bucketId = 'YOUR_BUCKET_ID';

  FileService(this.client) : storage = Storage(client);

  /// Supprime un fichier donné
  Future<void> deleteFile(String fileId) async {
    try {
      await storage.deleteFile(bucketId: bucketId, fileId: fileId);
      debugPrint('✅ Fichier supprimé avec succès: $fileId');
    } on AppwriteException catch (e) {
      debugPrint(
        '❌ Erreur Appwrite lors de la suppression du fichier: ${e.message}',
      );
    } catch (e) {
      debugPrint('❌ Erreur inconnue lors de la suppression du fichier: $e');
    }
  }

  /// Récupère les données d'un fichier sous forme de `Uint8List`
  Future<Uint8List?> getFileData(String fileId) async {
    try {
      final response = await storage.getFileDownload(
        bucketId: bucketId,
        fileId: fileId,
      );
      return response;
    } on AppwriteException catch (e) {
      debugPrint(
        '❌ Erreur Appwrite lors de la récupération des données du fichier: ${e.message}',
      );
      return null;
    } catch (e) {
      debugPrint(
        '❌ Erreur inconnue lors de la récupération des données du fichier: $e',
      );
      return null;
    }
  }

  /// Récupère l'URL du fichier stocké dans Appwrite
  Future<String?> getFileUrl(String fileId) async {
    try {
      return "https://cloud.appwrite.io/v1/storage/buckets/$bucketId/files/$fileId/view";
    } catch (e) {
      debugPrint('❌ Erreur lors de la récupération de l\'URL du fichier: $e');
      return null;
    }
  }

  /// Upload un fichier et retourne son ID
  Future<String> uploadFile(File file) async {
    try {
      final result = await storage.createFile(
        bucketId: bucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: file.path),
        permissions: ['role:all'], // 🔥 Modifie les permissions si besoin
      );
      debugPrint('✅ Fichier uploadé avec succès: ${result.$id}');
      return result.$id;
    } on AppwriteException catch (e) {
      debugPrint(
        '❌ Erreur Appwrite lors de l\'upload du fichier: ${e.message}',
      );
      return Future.error('Échec de l\'upload');
    } catch (e) {
      debugPrint('❌ Erreur inconnue lors de l\'upload du fichier: $e');
      return Future.error('Échec de l\'upload');
    }
  }
}
