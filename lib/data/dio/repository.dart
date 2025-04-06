import 'package:dio/dio.dart';
import '../../domain/entities/photo.dart';
Future<List<Photo>> fetchPhotos({required int page, required int limit}) async {

  final Dio dio = Dio();

  Response response = await dio.get(
    'https://jsonplaceholder.typicode.com/photos',
    queryParameters: {
      '_page': page, 
      '_limit': limit,
    },
  );

  return (response.data as List).map((photo) {
    return Photo.fromJson(photo);
  }).toList();
}

Future<Photo> fetchSinglePhoto({required int id}) async {
  final dio = Dio();

  Response response = await dio.get(
    'https://jsonplaceholder.typicode.com/photos',
  );

  return Photo.fromJson(response.data[id]);
}
