import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_app/data/dio/repository.dart';
import 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  PhotoCubit() : super(const PhotoState());

  int _currentPage = 1;
  final int _limit = 15;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  Future<void> getPhotos({bool loadMore = false}) async {
    if (_isLoadingMore || (!_hasMore && loadMore)) return;

    if (loadMore) {
      _isLoadingMore = true;
      _currentPage++;
    } else {
      _currentPage = 1;
      _hasMore = true;
    }

    emit(state.copyWith(isLoading: !loadMore));

    final newPhotos = await fetchPhotos(page: _currentPage, limit: _limit);
    final allPhotos = loadMore ? [...state.photos, ...newPhotos] : newPhotos;

    _hasMore = newPhotos.length == _limit;
    _isLoadingMore = false;

    emit(state.copyWith(
      isLoading: false,
      photos: allPhotos,
    ));
  }

  void nextPage() {
    getPhotos(loadMore: true);
  }

  void previousPage() {
    if (_currentPage > 1) {
      _currentPage -= 2;
      _hasMore = true;
      getPhotos(loadMore: false);
    }
  }

  void toggleSelection(int id) {
    final selected = Set<int>.from(state.selectedPhotoIds);
    if (selected.contains(id)) {
      selected.remove(id);
    } else {
      selected.add(id);
    }
    emit(state.copyWith(selectedPhotoIds: selected.toList()));
  }

  void clearSelections() {
    emit(state.copyWith(selectedPhotoIds: []));
  }
}
