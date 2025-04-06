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
      appBar: AppBar(title: const Text('Detalhes da Foto')),
      body: BlocBuilder<PhotoDetailsCubit, PhotoDetailsState>(
        bloc: _cubit,
        builder: (_, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.photo.url == null || state.photo.id == null) {
            return const Center(child: Text('Erro ao carregar a imagem da foto'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  state.photo.url!,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16),
                Text(
                  state.photo.title ?? '',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text('ID: ${state.photo.id}'),
                Text('Album ID: ${state.photo.albumId}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
