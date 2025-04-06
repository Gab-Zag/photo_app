import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/dio/repository.dart';
import 'photo_details_state.dart';

import '../../../domain/entities/photo.dart';

class PhotoDetailsCubit extends Cubit<PhotoDetailsState>{

  PhotoDetailsCubit() : super(const PhotoDetailsState());
  
  Future<void> getPhoto({required int id}) async{
    emit(
      state.copywith(
        isLoading:true,
      ),
    );
    Photo photo = await fetchSinglePhoto(id: id);
    emit(
      state.copywith(
        isLoading: false,
        photo: photo,
      )
    );
  }
}
