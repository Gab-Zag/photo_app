import 'package:flutter/material.dart';

import '../../domain/entities/photo.dart';

class SelecetedPhotosPages extends StatelessWidget {
  final List<Photo> selectedPhotos;

  const SelecetedPhotosPages({super.key, required this.selectedPhotos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritas')),
      body:
          selectedPhotos.isEmpty
              ? const Center(child: Text('Nenhuma foto selecionada'))
              : ListView.separated(
                itemCount: selectedPhotos.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final photo = selectedPhotos[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: Image.network(
                          photo.thumbnailUrl ?? '',
                          width: 50,
                          height: 50,
                          errorBuilder:
                              (_, __, ___) => const Icon(Icons.broken_image),
                        ),
                        title: Text(photo.title ?? ''),
                      ),
                    ],
                  );
                },
              ),
    );
  }
}
