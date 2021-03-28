
# 🔏 file_cryptor  
  
📁 FileCryptor is for encryption and decryption files.
  
## Getting Started
### ⚙️Installation
Add to your `pubspec.yaml`:
```yaml
dependencies:
  file_cryptor: <last_version>
```
### 📜Example
```dart
void main() async {  
  FileCryptor fileCryptor = FileCryptor(  
	  key: "Your 32 bit key.................",  
	  iv: 16,  
	  dir: "example",  
  );  
  
  File encryptedFile = await fileCryptor.encrypt(inputFile: "video.mp4", outputFile: "video.aes");  
  print(encryptedFile.absolute);  
  
  File decryptedFile = await fileCryptor.decrypt(inputFile: "video.aes", outputFile: "video.mp4");  
  print(decryptedFile.absolute); 
}
```
## 💻 Output
```
File: '<your_platform_path>\example\video.aes'
File: '<your_platform_path>\example\video.mp4'
```
#### ✉️ Telegram Contact: [webdasturuz](https://t.me/webdasturuz)