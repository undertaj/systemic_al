import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ImageController{


  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:8000/api/',
    ));

  Future<void> uploadImage(XFile file) async{
    // This is where the code for uploading an image would go
    FormData formData = FormData.fromMap({
      'image': file,});
    final response = await _dio.post('upload/',data: formData);
    if(response.statusCode == 200) {
      print("UPLOADED SUCCESSFULLY");
    }
  }

  Future<String> getRandomImage() async{
    final response = await _dio.get('random/');
    if(response.statusCode == 200) {
      return response.data['image'];
    }
    return '';
  }
}
