
//
// import 'package:dio/dio.dart';
//
// void uploadImage() async {
//   FormData formData = FormData.from({
//     "name_image": _txtNameImage.text,
//     "image": UploadFileInfo(File("$_image"), "image.jpg")
//   });
//   bool upload =
//   await api.uploadImage(data: formData, options: CrudComponent.options);
//   upload ? print('success') : print('fail');
// }