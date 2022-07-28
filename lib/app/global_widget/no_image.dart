import 'package:flutter/material.dart';

class NoImageWidget extends StatelessWidget {
  const NoImageWidget({Key? key,this.text}) : super(key: key);
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: const Color(0xFFF4F4F4),
                width: 1)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.camera_alt_outlined,
              size: 20,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              '$text',
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w800),
            )
          ],
        ),
      ),
    );
  }
}
