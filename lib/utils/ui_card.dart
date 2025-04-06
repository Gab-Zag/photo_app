import 'package:flutter/material.dart';
import '../pages/photo_details/photo_details_page.dart';

class UiCard extends StatefulWidget {
  final String title;
  final String url;
  const UiCard({super.key, required this.title, required this.url});

  @override
  State<UiCard> createState() => _UiCardState();
}

class _UiCardState extends State<UiCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (value) {
                  isChecked = value ?? false;
                  setState(() {});
                },
              ),
              Expanded(
                child: Text(
                  widget.title,
                  softWrap: true,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PhotoDetailsPage(photoId: 0,)), // Replace 0 with the correct photo ID if available
                  );
                },
                icon: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
