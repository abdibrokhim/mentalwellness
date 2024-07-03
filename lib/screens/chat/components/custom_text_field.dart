import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final bool disable;
  final String? initialMessage;
  final int maxLines;
  final int minLines;

  const CustomTextField({
    required this.hintText,
    required this.onChanged,
    this.disable = false,
    this.initialMessage,
    this.maxLines = 6,
    this.minLines = 1,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialMessage != null) {
      _searchController.text = widget.initialMessage!;
    }
    _searchController.addListener(() {
      widget.onChanged(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            spreadRadius: 2.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                textAlignVertical: TextAlignVertical.top,
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                enabled: !widget.disable,
                autocorrect: false,
                enableSuggestions: false,
                cursorColor: Colors.black,
                controller: _searchController,
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}