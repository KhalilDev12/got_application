import 'package:dio/dio.dart';
import 'package:got_application/data/models/character_model.dart';

import '../../constants/strings.dart';

class CharacterWebService {
  late Dio dio;

  CharacterWebService() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(seconds: 20),
      connectTimeout: const Duration(seconds: 20),
    );
    dio = Dio(baseOptions);
  }


  // Get All Characters from API
  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get("Characters");
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
