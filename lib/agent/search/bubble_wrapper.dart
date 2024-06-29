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
          ...List.generate(children.length, (index) {
            return Column(
              children: [
                children[index],
                if (index < children.length - 1) const SizedBox(height: 16.0),
              ],
            );
          }),
        ],
      ),
    );
  }
}