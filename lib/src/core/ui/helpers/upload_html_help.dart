import 'dart:html';
import 'dart:typed_data';

typedef UploadCallBack = void Function(Uint8List file, String fileName);

class UploadHtmlHelp {
  void startUpload(UploadCallBack callBack) {
    final uploadInput = FileUploadInputElement();
    uploadInput.click();
    uploadInput.onChange.listen((_) {
      handleFileUpload(uploadInput, callBack);
    });
  }

  void handleFileUpload(
    FileUploadInputElement uploadInput,
    UploadCallBack callBack,
  ) {
    final files = uploadInput.files;
    if (files != null && files.isNotEmpty) {
      final file = files.first;
      final reader = FileReader();
      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((_) {
        final bytes = Uint8List.fromList(reader.result as List<int>);
        callBack(bytes, file.name);
      });
    }
  }
}
