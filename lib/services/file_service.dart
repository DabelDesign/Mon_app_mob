import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';

class FileService {
  final Client client;
  final Storage storage;
  final String bucketId = 'YOUR_BUCKET_ID';

  FileService(this.client) : storage = Storage(client);

  Future<void> deleteFile(String fileId) async {
    try {
      await storage.deleteFile(bucketId: bucketId, fileId: fileId);
      debugPrint('Fichier supprimé avec succès: $fileId');
    } catch (e) {
      debugPrint('Erreur lors de la suppression du fichier: $e');
    }
  }

  Future<Uint8List?> getFileData(String fileId) async {
    try {
      return storage.getFilePreview(bucketId: bucketId, fileId: fileId);
    } catch (e) {
      debugPrint('Erreur lors de la récupération des données du fichier: $e');
      return null;
    }
  }

  Future<String?> getFileUrl(String fileId) async {
    try {
      final data =
          await storage.getFileView(bucketId: bucketId, fileId: fileId);
      return String.fromCharCodes(data);
    } catch (e) {
      debugPrint('Erreur lors de la récupération de l\'URL du fichier: $e');
      return null;
    }
  }

  Future<String> uploadFile(File file) async {
    try {
      final result = await storage.createFile(
        bucketId: bucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: file.path),
        permissions: ['role:all'],
      );
      return result.$id;
    } catch (e) {
      debugPrint('Erreur lors de l\'upload du fichier: $e');
      return Future.error('Échec de l\'upload');
    }
  }
}
