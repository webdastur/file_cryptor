import 'dart:io';

import 'package:file_cryptor/file_cryptor.dart';

void main() async {
  FileCryptor fileCryptor = FileCryptor(
    key: "Your 32 bit key.................",
    iv: 16,
    dir: "example",
  );

  File encryptedFile = await fileCryptor.encrypt(inputFile: "example.txt", outputFile: "example.aes");
  print(encryptedFile.absolute);

  File decryptedFile = await fileCryptor.decrypt(inputFile: "example.aes", outputFile: "example.txt");
  print(decryptedFile.absolute);
}
