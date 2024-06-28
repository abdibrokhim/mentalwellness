import 'package:flutter/material.dart';

class CustomChatInput extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final bool disable;
  final String? initialMessage;

  const CustomChatInput({
    required this.hintText,
    required this.onChanged,
    this.disable = false,
    this.initialMessage,
    super.key,
    });

  @override
  State<CustomChatInput> createState() => _CustomChatInputState();
}

class _CustomChatInputState extends State<CustomChatInput> {
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
      width: MediaQuery.of(context).size.width - 32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10000.0),
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