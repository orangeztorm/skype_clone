import 'dart:io';
import 'dart:math';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Utils{
  static String getUserName(String email){
    return "live:${email.split('@')[0]}";
  }

  static String getInitials(String name) {
    List<String> nameSplit = name.split(" ");
    String firstNameInitial = nameSplit[0][0];
    String lastNameInitial = nameSplit[1][0];
    return firstNameInitial + lastNameInitial;
  }

  static Future<File> pickImage({ImageSource source}) async {
    File selectedImage = await ImagePicker.pickImage(source: source);
    return await compressImage(selectedImage);
  }

  static Future<File> compressImage(File imageToCompress) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = Random().nextInt(10000);

    // Im.Image image = Im.decodeImage(imageToCompress.readAsBytesSync());
    // Im.copyResize(image, width: 500, height: 500);
    //
    // return new File('$path/img_$rand.jpg')
    //   ..writeAsBytesSync(Im.encodeJpg(image, quality: 85));
  }

}