import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:photo_app/utils/ui_card.dart';

import '../../domain/entities/photo.dart';
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
    _cubit = PhotoCubit()..getPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('teste'),),
      body: BlocBuilder<PhotoCubit, PhotoState>(
        bloc: _cubit,
        builder: (_, state) {
          if (state.photos.isEmpty && state.isLoading == false) {
            return Text('Fotos nao encontradas');
          }
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            itemCount: state.photos.length,
            separatorBuilder: (_, index) => const Gap(10),
            itemBuilder: (_, index) {
              Photo photo = state.photos[index];
              return UiCard(
                title: photo.title ?? '',
                url: photo.url ?? '',
              );
            },
          );
        },
      ),
    );
  }
}
