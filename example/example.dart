import 'dart:io';

import 'package:file_cryptor/file_cryptor.dart';

void main() async {
  FileCryptor fileCryptor = FileCryptor(
    key: "Your 32 bit key.................",
    iv: 16,
    dir: "example",
    // useCompress: true,
  );

  File encryptedFile =
      await fileCryptor.encrypt(inputFile: "file.txt", outputFile: "file.aes");
  print(encryptedFile.absolute);

  File decryptedFile =
      await fileCryptor.decrypt(inputFile: "file.aes", outputFile: "file.txt");
  print(decryptedFile.absolute);
}
