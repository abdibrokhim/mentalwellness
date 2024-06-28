// import 'package:flutter/material.dart';


// class Chips extends StatelessWidget {
//   final List<String> chips;
//   final Function(int) onChipTap;

//   const Chips({
//     this.chips,
//     this.onChipTap,
//     super.key
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child:
//                   Row(
//                     children: chips.map((starter) => Padding(
//                       padding: const EdgeInsets.only(right: 8.0),
//                       child: GestureDetector(
//       onTap: onChipTap(starter),
//       child:
//                       Chip(
//                         label: Text(starter, style: const TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 0, 0, 0)),),
//                       ),
//                       ),
//                     )).toList(),
//                   ),
//                 ),
//                 ),
//               ],
//             );
//   }
// }