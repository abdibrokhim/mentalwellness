import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final Function(int) onRatingChanged;
  final int initialRating;

  StarRating({required this.onRatingChanged, this.initialRating = 0});

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int _rating = 0;
  final List<Color> _colors = [
    Colors.grey[400]!,
    Colors.grey[500]!,
    Colors.grey[600]!,
    Colors.grey[700]!,
    Colors.grey[800]!,
    Colors.black,
  ];

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  void _handleRating() {
    setState(() {
      _rating = (_rating + 1) % 6; // Cycle the rating from 0 to 5
    });
    widget.onRatingChanged(_rating);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        GestureDetector(
          onTap: _handleRating,
          child: Icon(
            Icons.star_rate_rounded,
            size: 36.0, // Large size for the star
            color: _colors[_rating],
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Tap to rate',
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}
