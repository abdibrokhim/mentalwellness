import 'package:flutter/material.dart';

class BubbleCardWrapper extends StatelessWidget {
  final List<Widget> children;

  const BubbleCardWrapper({
    required this.children,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...children,
        ],
      ),
    );
  }
}