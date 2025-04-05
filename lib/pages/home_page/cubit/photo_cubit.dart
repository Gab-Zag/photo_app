import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_app/data/dio/repository.dart';
import '../../../domain/entities/photo.dart';
import 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  PhotoCubit() : super(const PhotoState());

  Future<void> getPhotos() async {
    emit(state.copyWith(isLoading: true));
    List<Photo> photos = await fetchPhotos();
    emit(state.copyWith(isLoading: false, photos: photos));
  }
}
