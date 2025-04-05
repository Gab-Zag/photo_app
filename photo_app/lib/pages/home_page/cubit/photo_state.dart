import 'package:equatable/equatable.dart';

import '../../../../domain/entities/photo.dart';

class PhotoState extends Equatable {
  final bool isLoading;
  final List<Photo> photos;

  const PhotoState({
    this.isLoading = false,
    this.photos = const [],
  });

  PhotoState copyWith({
    bool? isLoading,
    List<Photo>? photos,
  }) {
    return PhotoState(
      isLoading: isLoading ?? this.isLoading,
      photos: photos ?? this.photos,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        photos,
      ];
}
