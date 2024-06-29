import 'package:flutter/material.dart';

class CardWrapper extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final String description;

  const CardWrapper({
    required this.children,
    required this.title,
    required this.description,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            title: title,
            description: description,
          ),
          const SizedBox(height: 16.0),
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

class Header extends StatelessWidget {
  final String title;
  final String description;

  const Header({
    required this.title,
    required this.description,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
        const SizedBox(height: 4.0),
        Text(description, style: const TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 0, 0, 0)),),
      ],
    );
  }
}
