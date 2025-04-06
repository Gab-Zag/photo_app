import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/photo_details_cubit.dart';
import 'cubit/photo_details_state.dart';

class PhotoDetailsPage extends StatefulWidget {
  final int photoId;

  const PhotoDetailsPage({super.key, required this.photoId});

  @override
  State<PhotoDetailsPage> createState() => _PhotoDetailsPageState();
}

class _PhotoDetailsPageState extends State<PhotoDetailsPage> {
  late PhotoDetailsCubit _cubit;

  @override
  void initState() {
    _cubit = PhotoDetailsCubit()..getPhoto(id: widget.photoId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photo Details')),
      body: BlocBuilder<PhotoDetailsCubit, PhotoDetailsState>(
        bloc: _cubit,
        builder: (_, state) {
          if (state.photo.id == null && state.isLoading == false) {
            return Text('Foto nao encontrada');
          }
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text((state.photo.id ?? 0).toString()),
                Text(state.photo.thumbnailUrl ?? ''),
                Text(state.photo.title ?? ''),
                Text((state.photo.albumId ?? 0).toString()),
              ],
            ),
          );
        },
      ),
    );
  }
}
