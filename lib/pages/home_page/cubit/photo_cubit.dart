import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_app/data/dio/repository.dart';
import '../../../domain/entities/photo.dart';
import 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  PhotoCubit() : super(const PhotoState());

  int _currentPage = 1;
  final int _limit = 10;
  bool _hasMore = true;

  Future<void> getPhotos({bool reset = false}) async {
    if (state.isLoading || (!_hasMore && !reset)) return;

    emit(state.copyWith(isLoading: true));

    if (reset) {
      _currentPage = 1;
      _hasMore = true;
    }

    final List<Photo> newPhotos = await fetchPhotos(
      page: _currentPage,
      limit: _limit,
    );
    final List<Photo> updatedPhotos =
        reset ? newPhotos 
        : [...state.photos, ...newPhotos];
    _hasMore = newPhotos.length == _limit;

    emit(state.copyWith(
      isLoading: false,
      photos: updatedPhotos,
    ));
  }

  void nextPage(){
    if(_hasMore){
      _currentPage++;
      getPhotos();
    }
  }

  void previousPage(){
    if(_currentPage > 1){
      _currentPage--;
      _hasMore = true;
      getPhotos(reset: true);
    }
  }

  void toggleSelection(int id){
    final selected = Set<int>.from(state.selectedPhotoIds);
    if(selected.contains(id)){
      selected.remove(id);
    }else{
      selected.add(id);
    }
    emit(state.copyWith(selectedPhotoIds: selected.toList()));
  }

  void clearSelections(){
    emit(state.copyWith(selectedPhotoIds: []));
  }
}
