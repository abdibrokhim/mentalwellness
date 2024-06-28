import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final Map<int, int> ratings; // Key: rating (1-5), Value: count of reviews

  const RatingBar({
    required this.ratings,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    int maxCount = ratings.values.reduce((a, b) => a + b);
    print(maxCount);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ratings.entries
          .map((entry) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.star, size: 24.0, color: Colors.black),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            height: 4.0,
                            color: Colors.grey[300],
                          ),
                          Container(
                            height: 4.0,
                            width: (entry.value / maxCount) * MediaQuery.of(context).size.width,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(entry.key.toString(), style: const TextStyle(fontSize: 14.0, color: Color.fromARGB(255, 0, 0, 0)),),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
