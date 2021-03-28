import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:file_cryptor/src/base_cryptor.dart';
import 'package:path/path.dart' as p;

/// FileCryptor for encryption and decryption files.
class FileCryptor extends BaseFileCryptor {
  /// [key] is using for encrypt and decrypt given file
  final String key;

  /// [iv] is Initialization vector encryption times
  final int iv;

  /// [IV] private instance for encryption and decryption
  final IV _iv;

  /// [Key] private instance for encryption and decryption
  final Key _key;

  /// [dir] working directory
  final String dir;

  /// [key] is using for encrypt and decrypt given file
  ///
  /// [iv] is Initialization vector encryption times
  ///
  /// [dir] working directory
  FileCryptor({
    required this.key,
    required this.iv,
    required this.dir,
  })   : assert(key.length == 32, "key length must be 32"),
        this._iv = IV.fromLength(iv),
        this._key = Key.fromUtf8(key);

  /// Get current absolute working directory
  String getCurrentDir() => p.absolute(dir);

  @override
  Future<File> decrypt({
    String? inputFile,
    String? outputFile,
  }) async {
    File _inputFile = File(p.join(dir, inputFile));
    File _outputFile = File(p.join(dir, outputFile));

    bool _outputFileExists = await _outputFile.exists();
    bool _inputFileExists = await _inputFile.exists();

    if (!_outputFileExists) {
      await _outputFile.create();
    }

    if (!_inputFileExists) {
      throw Exception("Input file not found.");
    }

    final _fileContents = _inputFile.readAsBytesSync();

    final Encrypter _encrypter = Encrypter(AES(_key));

    final _encryptedFile = Encrypted(_fileContents);
    final _decryptedFile = _encrypter.decrypt(_encryptedFile, iv: _iv);

    final _decryptedBytes = latin1.encode(_decryptedFile);
    return await _outputFile.writeAsBytes(_decryptedBytes);
  }

  @override
  Future<File> encrypt({
    String? inputFile,
    String? outputFile,
  }) async {
    File _inputFile = File(p.join(dir, inputFile));
    File _outputFile = File(p.join(dir, outputFile));

    bool _outputFileExists = await _outputFile.exists();
    bool _inputFileExists = await _inputFile.exists();

    if (!_outputFileExists) {
      await _outputFile.create();
    }

    if (!_inputFileExists) {
      throw Exception("Input file not found.");
    }

    final _fileContents = _inputFile.readAsStringSync(encoding: latin1);

    final Encrypter _encrypter = Encrypter(AES(_key));

    final Encrypted _encrypted = _encrypter.encrypt(_fileContents, iv: _iv);

    File _encryptedFile = await _outputFile.writeAsBytes(_encrypted.bytes);

    return _encryptedFile;
  }

  @override
  Uint8List decryptUint8List({Uint8List? data}) {
    if (data == null) {
      throw Exception("data cannot be null");
    }
    final Encrypter _encrypter = Encrypter(AES(_key));
    final Encrypted _encrypted = Encrypted(data);
    final Uint8List _decrypted = latin1.encode(_encrypter.decrypt(_encrypted, iv: _iv));
    return _decrypted;
  }

  @override
  Uint8List encryptUint8List({Uint8List? data}) {
    if (data == null) {
      throw Exception("data cannot be null");
    }
    final Encrypter _encrypter = Encrypter(AES(_key));
    final Encrypted _encrypted = _encrypter.encrypt(String.fromCharCodes(data), iv: _iv);
    return _encrypted.bytes;
  }
}
