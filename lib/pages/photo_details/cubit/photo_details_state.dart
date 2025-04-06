import 'package:equatable/equatable.dart';
import 'package:photo_app/domain/entities/photo.dart';

class PhotoDetailsState extends Equatable{
  final bool isLoading;
  final Photo photo;

  const PhotoDetailsState({
    this.isLoading = false,
    this.photo = const Photo(),
  });

  PhotoDetailsState copywith({
    bool? isLoading,
    Photo? photo,
  }){
    return PhotoDetailsState(
      isLoading: isLoading ?? this.isLoading,
      photo: photo ?? this.photo,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    photo,
  ];
}