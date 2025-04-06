import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_app/pages/selected_page/seleceted_photos_pages.dart';
import 'package:photo_app/utils/ui_card.dart';

import 'cubit/photo_cubit.dart';
import 'cubit/photo_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PhotoCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = PhotoCubit()..getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeria'),
        actions: [
          BlocBuilder<PhotoCubit, PhotoState>(
            bloc: _cubit,
            builder: (_, state) {
              return Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite),
                    onPressed: () {
                      final selectPhotos =
                          state.photos
                              .where(
                                (photo) =>
                                    state.selectedPhotoIds.contains(photo.id),
                              )
                              .toList();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (_) => SelecetedPhotosPages(
                                selectedPhotos: selectPhotos,
                              ),
                        ),
                      );
                    },
                  ),
                  Text('${state.selectedPhotoIds.length}'),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _cubit.clearSelections(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<PhotoCubit, PhotoState>(
        bloc: _cubit,
        builder: (_, state) {
          if (state.isLoading && state.photos.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.photos.isEmpty) {
            return const Center(child: Text('Nenhuma foto encontrada'));
          }
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => _cubit.previousPage(),
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  IconButton(
                    onPressed: () => _cubit.nextPage(),
                    icon: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: state.photos.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (_, index) {
                    final photo = state.photos[index];
                    final isSelected = state.selectedPhotoIds.contains(
                      photo.id,
                    );
                    return UiCard(
                      title: photo.title ?? '',
                      url: photo.thumbnailUrl ?? '',
                      selected: isSelected,
                      onToggle: () => _cubit.toggleSelection(photo.id!),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
