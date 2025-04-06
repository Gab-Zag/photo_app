import 'package:equatable/equatable.dart';

import '../../../../domain/entities/photo.dart';

class PhotoState extends Equatable {
  final bool isLoading;
  final List<Photo> photos;
  final List<int> selectedPhotoIds;

  const PhotoState({
    this.isLoading = false,
    this.photos = const [],
    this.selectedPhotoIds = const [],
  });

  PhotoState copyWith({
    bool? isLoading,
    List<Photo>? photos,
    List<int>? selectedPhotoIds,
  }) {
    return PhotoState(
      isLoading: isLoading ?? this.isLoading,
      photos: photos ?? this.photos,
      selectedPhotoIds: selectedPhotoIds ?? this.selectedPhotoIds,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        photos,
        selectedPhotoIds,
      ];
}

