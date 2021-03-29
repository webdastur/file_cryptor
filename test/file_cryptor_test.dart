import 'dart:io';
import 'dart:typed_data';

import 'package:file_cryptor/file_cryptor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final Uint8List data = Uint8List.fromList([1, 2, 3]);

  final Uint8List encryptedData = Uint8List.fromList(
    [237, 88, 11, 49, 80, 191, 139, 40, 71, 180, 95, 52, 55, 221, 91, 255],
  );

  late FileCryptor fileCryptor;

  setUp(() {
    fileCryptor = FileCryptor(
      key: "Your 32 bit key.................",
      iv: 16,
      dir: "test",
    );
  });

  test(
    "Uint8List encryption",
    () {
      var _encryptedData = fileCryptor.encryptUint8List(data: data);
      expect(_encryptedData, encryptedData);
    },
  );

  test(
    "Uint8List decryption",
    () {
      var _decryptedData = fileCryptor.decryptUint8List(data: encryptedData);
      expect(_decryptedData, data);
    },
  );

  test(
    "File encryption",
    () async {
      var _encryptedFile = await fileCryptor.encrypt(
          inputFile: "example.txt", outputFile: "res\\example.aes");
      expect(_encryptedFile.readAsBytesSync(),
          File("test\\example.aes").readAsBytesSync());
      await _encryptedFile.delete();
    },
  );

  test(
    "File decryption",
    () async {
      var _decryptedFile = await fileCryptor.decrypt(
          inputFile: "example.aes", outputFile: "res\\example.txt");
      expect(_decryptedFile.readAsBytesSync(),
          File("test\\example.txt").readAsBytesSync());
      await _decryptedFile.delete();
    },
  );
}
