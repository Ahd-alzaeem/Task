import 'package:file_picker/file_picker.dart';

import '../network/http.dart';

class Utils {
  static String? requestTypeToString(RequestMethod requestType) {
    String? type = '';
    switch (requestType) {
      case RequestMethod.get:
        {
          type = 'GET';
        }
        break;
      case RequestMethod.post:
        {
          type = 'POST';
        }
        break;
      case RequestMethod.delete:
        {
          type = 'DELETE';
        }
        break;
      case RequestMethod.patch:
        {
          type = 'PATCH';
        }
        break;
      case RequestMethod.put:
        {
          type = 'PUT';
        }
        break;
    }
    return type;
  }

  static Future<List<PlatformFile>> pickFiles({
    List<String> allowedExtensions = const ["jpg", "jpeg", "png"],
    FileType fileType = FileType.custom,
    bool allowMultiple = false,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
      type: fileType,
      allowedExtensions: allowedExtensions,
    );
    if (result == null) return [];
    return result.files;
  }
}
