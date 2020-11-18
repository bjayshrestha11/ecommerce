// import 'package:flutter/material.dart';
// import 'package:foodly_dashboard/models/message.dart';

// class Notifications extends StatelessWidget {

//   final List<Message> messagesList;

//   const Notifications({Key key,@required this.messagesList}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Notifications"),
//       ),
//       body: ListView.builder(
//         itemCount: null == messagesList ? 0 : messagesList.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Card(
//             child: Padding(
//               padding: EdgeInsets.all(10.0),
//               child: Text(
//                 messagesList[index].message,
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }