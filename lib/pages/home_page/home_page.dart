import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit = PhotoCubit()..getPhotos();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        _cubit.getPhotos(loadMore: true);
      }
    });
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
              if (state.selectedPhotoIds.isEmpty) {
                return const SizedBox.shrink();
              }
              return Row(
                children: [
                  Text('${state.selectedPhotoIds.length}'),
                  IconButton(
                    onPressed: () => _cubit.clearSelections(),
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ),
          Expanded(
            child: BlocBuilder<PhotoCubit, PhotoState>(
              bloc: _cubit,
              builder: (_, state) {
                if (state.photos.isEmpty && state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (state.photos.isEmpty && !state.isLoading) {
                  return const Center(child: Text('Fotos nao encontradas'));
                }
                return ListView.separated(
                  controller: _scrollController,
                  itemCount: state.photos.length,
                  separatorBuilder: (_, __) => const Gap(10),
                  itemBuilder: (_, index) {
                    final photo = state.photos[index];
                    final isSelected = state.selectedPhotoIds.contains(
                      photo.id,
                    );
                    return UiCard(
                      title: photo.title ?? '',
                      url: photo.url ?? '',
                      selected: isSelected,
                      onToggle: () => _cubit.toggleSelection(photo.id!),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
