import 'package:flutter/material.dart';
import 'package:photo_app/pages/photo_details/photo_details_page.dart';

class UiCard extends StatelessWidget{
  final String title;
  final String url;
  final bool selected;
  final VoidCallback onToggle;
  const UiCard({
    super.key,
    required this.title,
    required this.url,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 2,
            offset: const Offset(2, 3),
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 2,
            offset: const Offset(0, -1),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Checkbox(value: selected, onChanged: (_) => onToggle()),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              url,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(Icons.image),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16),
              softWrap: true,
            ),
          ),
          IconButton(
            onPressed: () { 
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PhotoDetailsPage(photoId: int.tryParse(url) ?? 0)));
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}