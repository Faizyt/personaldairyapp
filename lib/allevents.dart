// // import 'package:flutter/material.dart';
// // import 'database/mysql.dart';
// // import 'model/event.dart';

// // class AllEvents extends StatefulWidget {
// //   const AllEvents({super.key});

// //   @override
// //   State<AllEvents> createState() => _AllEventsState();
// // }

// // class _AllEventsState extends State<AllEvents> {
// //   TextEditingController evTitle = TextEditingController(text: '');
// //   TextEditingController evType = TextEditingController(text: '');
// //   TextEditingController evDate = TextEditingController(text: 'Date');
// //   TextEditingController evStartTime = TextEditingController(text: 'Start Time');
// //   TextEditingController evEndTime = TextEditingController(text: 'End Time');
// //   TextEditingController evLocation = TextEditingController(text: '');
// //   TextEditingController evDetails = TextEditingController(text: '');
// //   final List<String> _typelist = [
// //     'Anniversary',
// //     'Birthday',
// //     'Holiday',
// //     'Exams',
// //     'Regular Events'
// //   ];
// //   String _type = 'Regular Events';
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('All Events'),
// //       ),
// //       body: Center(
// //         child: FutureBuilder<List<Event>>(
// //           future: DatabaseHelper.instance.getEvents(),
// //           builder: (context, snapshot) {
// //             if (snapshot.hasData) {
// //               return ListView.builder(
// //                 itemCount: snapshot.data!.length,
// //                 itemBuilder: (context, index) {
// //                   final event = snapshot.data![index];
// //                   return Column(
// //                     children: [
// //                       SizedBox(height: 10),
// //                       Container(
// //                         height: 120,
// //                         width: 300,
// //                         decoration: BoxDecoration(
// //                           color: Colors.blue,
// //                           borderRadius: BorderRadius.circular(10),
// //                         ),
// //                         child: ListTile(

// //                             title: Text(snapshot.data![index].eventTitle),
// //                             subtitle: Column(
// //                               children: [
// //                                 Text("Event Type${event.eventType}"),
// //                                 Text('Date: ${event.eventDate}'),
// //                                 Text(
// //                                     'Time: ${event.eventStartTime} - ${event.eventEndTime}'),
// //                                 Text('Location: ${event.eventLocation}'),
// //                                 Text('Details: ${event.eventDetails}'),
// //                               ],
// //                             ),
// //                             leading: Column(
// //                               children: [
// //                                 Icon(Icons.event_note_outlined),
// //                                 Text(event.eventDate.substring(0, 2)),
// //                               ],
// //                             ),
// //                             trailing: Column(
// //                               children: [
// //                                 InkWell(
// //                                     onTap: () {
// //                                       showDialog(
// //                                         context: context,
// //                                         builder: (BuildContext context) {
// //                                           return AlertDialog(
// //                                             title: const Text('Edit Event'),
// //                                             content: SingleChildScrollView(
// //                                               child: Column(
// //                                                 children: [
// //                                                   TextField(
// //                                                     controller: evTitle,
// //                                                     decoration:
// //                                                         const InputDecoration(
// //                                                       labelText:
// //                                                           'Event Title',
// //                                                     ),
// //                                                   ),
// //                                                   Container(
// //                                                     width: 300,
// //                                                     height: 50,
// //                                                     decoration: BoxDecoration(
// //                                                       border: Border.all(
// //                                                           color: Colors.grey),
// //                                                       borderRadius:
// //                                                           BorderRadius
// //                                                               .circular(5),
// //                                                     ),
// //                                                     child: DropdownButton(
// //                                                         alignment: Alignment
// //                                                             .centerLeft,
// //                                                         // Initial Value
// //                                                         value: _type,
// //                                                         // Down Arrow Icon
// //                                                         // icon: const Icon(Icons.keyboard_arrow_down),
// //                                                         // Array list of items
// //                                                         items: _typelist.map(
// //                                                             (String items) {
// //                                                           return DropdownMenuItem(
// //                                                             value: items,
// //                                                             child:
// //                                                                 Text(items),
// //                                                           );
// //                                                         }).toList(),
// //                                                         // After selecting the desired option,it will
// //                                                         // change button value to selected value
// //                                                         onChanged: (String?
// //                                                             newValue) async {
// //                                                           setState(() {
// //                                                             _type = newValue!;
// //                                                             evType.text =
// //                                                                 _type;
// //                                                           });
// //                                                         }),
// //                                                   ),
// //                                                   const SizedBox(height: 10),
// //                                                   InkWell(
// //                                                     onTap: () async {
// //                                                       // show date picker
// //                                                       DateTime? picked =
// //                                                           await showDatePicker(
// //                                                         context: context,
// //                                                         initialDate:
// //                                                             DateTime.now(),
// //                                                         firstDate:
// //                                                             DateTime(2015, 8),
// //                                                         lastDate:
// //                                                             DateTime(2101),
// //                                                       );
// //                                                       if (picked != null) {
// //                                                         // update date field
// //                                                         //modify date in dd/mm/yyyy format
// //                                                         String formattedDate =
// //                                                             "${picked.day}/${picked.month}/${picked.year}";
// //                                                         evDate.text =
// //                                                             formattedDate;
// //                                                         setState(() {
// //                                                           evDate.text =
// //                                                               formattedDate
// //                                                                   .toString();
// //                                                           print(evDate.text);
// //                                                         });
// //                                                       }
// //                                                     },
// //                                                     child: Container(
// //                                                       width: 300,
// //                                                       height: 50,
// //                                                       decoration:
// //                                                           BoxDecoration(
// //                                                         border: Border.all(
// //                                                             color:
// //                                                                 Colors.grey),
// //                                                         borderRadius:
// //                                                             BorderRadius
// //                                                                 .circular(5),
// //                                                       ),
// //                                                       child: Align(
// //                                                           alignment: Alignment
// //                                                               .centerLeft,
// //                                                           child: Padding(
// //                                                             padding:
// //                                                                 const EdgeInsets
// //                                                                     .all(9.0),
// //                                                             child: Text(
// //                                                               evDate.text,
// //                                                               style: const TextStyle(
// //                                                                   color: Colors
// //                                                                       .black),
// //                                                             ),
// //                                                           )),
// //                                                     ),
// //                                                   ),
// //                                                   const SizedBox(height: 10),
// //                                                   Container(
// //                                                     width: 300,
// //                                                     height: 50,
// //                                                     decoration: BoxDecoration(
// //                                                       border: Border.all(
// //                                                           color: Colors.grey),
// //                                                       borderRadius:
// //                                                           BorderRadius
// //                                                               .circular(5),
// //                                                     ),
// //                                                     child: InkWell(
// //                                                         onTap: () async {
// //                                                           // show time picker
// //                                                           final TimeOfDay?
// //                                                               picked =
// //                                                               await showTimePicker(
// //                                                             context: context,
// //                                                             initialTime:
// //                                                                 TimeOfDay
// //                                                                     .now(),
// //                                                           );

// //                                                           if (picked !=
// //                                                               null) {
// //                                                             // Modify initial time below
// //                                                             // modify time in hh:mm:00 format
// //                                                             String
// //                                                                 formatTime =
// //                                                                 '${picked.hour}:${picked.minute}:00';
// //                                                             picked.replacing(
// //                                                                 hour: 00,
// //                                                                 minute: 00);

// //                                                             evStartTime.text =
// //                                                                 formatTime;
// //                                                             setState(() {
// //                                                               print(
// //                                                                   evStartTime
// //                                                                       .text);
// //                                                               evStartTime
// //                                                                       .text =
// //                                                                   picked.format(
// //                                                                       context);
// //                                                             });
// //                                                           }
// //                                                         },
// //                                                         child: Align(
// //                                                             alignment: Alignment
// //                                                                 .centerLeft,
// //                                                             child: Padding(
// //                                                               padding:
// //                                                                   const EdgeInsets
// //                                                                           .all(
// //                                                                       9.0),
// //                                                               child: Text(
// //                                                                 evStartTime
// //                                                                     .text,
// //                                                                 style: const TextStyle(
// //                                                                     color: Colors
// //                                                                         .black),
// //                                                               ),
// //                                                             ))),
// //                                                   ),
// //                                                   const SizedBox(
// //                                                     height: 10,
// //                                                   ),
// //                                                   Container(
// //                                                     width: 300,
// //                                                     height: 50,
// //                                                     decoration: BoxDecoration(
// //                                                       border: Border.all(
// //                                                           color: Colors.grey),
// //                                                       borderRadius:
// //                                                           BorderRadius
// //                                                               .circular(5),
// //                                                     ),
// //                                                     child: InkWell(
// //                                                         onTap: () async {
// //                                                           // show time picker
// //                                                           final TimeOfDay?
// //                                                               picked =
// //                                                               await showTimePicker(
// //                                                             context: context,
// //                                                             initialTime:
// //                                                                 TimeOfDay
// //                                                                     .now(),
// //                                                           );

// //                                                           if (picked !=
// //                                                               null) {
// //                                                             // Modify initial time below
// //                                                             // modify time in hh:mm:00 format
// //                                                             String
// //                                                                 formatTime =
// //                                                                 '${picked.hour}:${picked.minute}:00';
// //                                                             // picked.replacing(hour: 00, minute: 00);
// //                                                             // update time field
// //                                                             evEndTime.text =
// //                                                                 formatTime;
// //                                                             setState(() {
// //                                                               print(evEndTime
// //                                                                   .text);
// //                                                               evEndTime.text =
// //                                                                   picked.format(
// //                                                                       context);
// //                                                             });
// //                                                           }
// //                                                         },
// //                                                         child: Align(
// //                                                             alignment: Alignment
// //                                                                 .centerLeft,
// //                                                             child: Padding(
// //                                                               padding:
// //                                                                   const EdgeInsets
// //                                                                           .all(
// //                                                                       9.0),
// //                                                               child: Text(
// //                                                                 evEndTime
// //                                                                     .text,
// //                                                                 style: const TextStyle(
// //                                                                     color: Colors
// //                                                                         .black),
// //                                                               ),
// //                                                             ))),
// //                                                   ),
// //                                                   const SizedBox(height: 10),
// //                                                   TextField(
// //                                                     controller: evLocation,
// //                                                     decoration:
// //                                                         const InputDecoration(
// //                                                       labelText:
// //                                                           'Event Location',
// //                                                     ),
// //                                                   ),
// //                                                 ],
// //                                               ),
// //                                             ),
// //                                             actions: [
// //                                               TextButton(
// //                                                 onPressed: () {
// //                                                   var id = event.eventId;
// //                                                   DatabaseHelper.instance
// //                                                       .updateEvent(Event(
// //                                                           eventId: id,
// //                                                           eventTitle:
// //                                                               evTitle.text,
// //                                                           eventType:
// //                                                               evType.text,
// //                                                           eventDate:
// //                                                               evDate.text,
// //                                                           eventStartTime:
// //                                                               evStartTime
// //                                                                   .text,
// //                                                           eventEndTime:
// //                                                               evEndTime.text,
// //                                                           eventLocation:
// //                                                               evLocation.text,
// //                                                           eventDetails:
// //                                                               evDetails
// //                                                                   .text));
// //                                                   setState(() {});
// //                                                   // Handle button tap
// //                                                   Navigator.of(context)
// //                                                       .pop(); // Close the dialog
// //                                                 },
// //                                                 child: const Text('Submit'),
// //                                               ),
// //                                             ],
// //                                           );
// //                                         },
// //                                       );
// //                                     },
// //                                     child: const Icon(Icons.edit)),
// //                                 InkWell(
// //                                     onTap: () {
// //                                       DatabaseHelper.instance
// //                                           .deleteEvent(event.eventId);
// //                                       setState(() {});
// //                                     },
// //                                     child: const Icon(Icons.delete)),
// //                               ],
// //                             )),
// //                       ),
// //                     ],
// //                   );
// //                 },
// //               );
// //             } else if (snapshot.hasError) {
// //               return const Placeholder();
// //             }
// //             return const Center(
// //               child: CircularProgressIndicator(),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'database/mysql.dart';
// import 'model/event.dart';

// class AllEvents extends StatefulWidget {
//   const AllEvents({Key? key});

//   @override
//   State<AllEvents> createState() => _AllEventsState();
// }

// class _AllEventsState extends State<AllEvents> {
//   TextEditingController evTitle = TextEditingController(text: '');
//   TextEditingController evType = TextEditingController(text: '');
//   TextEditingController evDate = TextEditingController(text: 'Date');
//   TextEditingController evStartTime = TextEditingController(text: 'Start Time');
//   TextEditingController evEndTime = TextEditingController(text: 'End Time');
//   TextEditingController evLocation = TextEditingController(text: '');
//   TextEditingController evDetails = TextEditingController(text: '');
//   final List<String> _typelist = [
//     'Anniversary',
//     'Birthday',
//     'Holiday',
//     'Exams',
//     'Regular Events'
//   ];
//   String _type = 'Regular Events';
//   Set<int> selectedTiles = Set<int>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('All Events'),
//       ),
//       body: Center(
//         child: FutureBuilder<List<Event>>(
//           future: DatabaseHelper.instance.getEvents(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   final event = snapshot.data![index];
//                   final isSelected = selectedTiles.contains(index);

//                   return Column(children: [
//                     SizedBox(height: 10),
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           if (isSelected) {
//                             selectedTiles.remove(index);
//                           } else {
//                             selectedTiles.add(index);
//                           }
//                         });
//                       },
//                       child: Container(
//                         height: 120,
//                         width: 300,
//                         decoration: BoxDecoration(
//                           color: isSelected
//                               ? Colors.blue.withOpacity(0.5)
//                               : Colors.blue,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: ListTile(
//                           title: Text(snapshot.data![index].eventTitle),
//                           subtitle: Column(
//                             children: [
//                               Text("Event Type${event.eventType}"),
//                               Text('Date: ${event.eventDate}'),
//                               Text(
//                                   'Time: ${event.eventStartTime} - ${event.eventEndTime}'),
//                               Text('Location: ${event.eventLocation}'),
//                               Text('Details: ${event.eventDetails}'),
//                             ],
//                           ),
//                           leading: Column(
//                             children: [
//                               Icon(Icons.event_note_outlined),
//                               Text(event.eventDate.substring(0, 2)),
//                             ],
//                           ),
//                           trailing: Column(
//                             children: [
//                               InkWell(
//                                 onTap: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return AlertDialog(
//                                         title: const Text('Edit Event'),
//                                         content: SingleChildScrollView(
//                                           child: Column(
//                                             children: [
//                                               TextField(
//                                                 controller: evTitle,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                   labelText: 'Event Title',
//                                                 ),
//                                               ),
//                                               Container(
//                                                 width: 300,
//                                                 height: 50,
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.grey),
//                                                   borderRadius:
//                                                       BorderRadius.circular(5),
//                                                 ),
//                                                 child: DropdownButton(
//                                                   alignment:
//                                                       Alignment.centerLeft,
//                                                   value: _type,
//                                                   items: _typelist.map(
//                                                     (String items) {
//                                                       return DropdownMenuItem(
//                                                         value: items,
//                                                         child: Text(items),
//                                                       );
//                                                     },
//                                                   ).toList(),
//                                                   onChanged:
//                                                       (String? newValue) async {
//                                                     setState(() {
//                                                       _type = newValue!;
//                                                       evType.text = _type;
//                                                     });
//                                                   },
//                                                 ),
//                                               ),
//                                               const SizedBox(height: 10),
//                                               InkWell(
//                                                 onTap: () async {
//                                                   DateTime? picked =
//                                                       await showDatePicker(
//                                                     context: context,
//                                                     initialDate: DateTime.now(),
//                                                     firstDate:
//                                                         DateTime(2015, 8),
//                                                     lastDate: DateTime(2101),
//                                                   );
//                                                   if (picked != null) {
//                                                     String formattedDate =
//                                                         "${picked.day}/${picked.month}/${picked.year}";
//                                                     evDate.text = formattedDate;
//                                                     setState(() {
//                                                       evDate.text =
//                                                           formattedDate
//                                                               .toString();
//                                                       print(evDate.text);
//                                                     });
//                                                   }
//                                                 },
//                                                 child: Container(
//                                                   width: 300,
//                                                   height: 50,
//                                                   decoration: BoxDecoration(
//                                                     border: Border.all(
//                                                         color: Colors.grey),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5),
//                                                   ),
//                                                   child: Align(
//                                                     alignment:
//                                                         Alignment.centerLeft,
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               9.0),
//                                                       child: Text(
//                                                         evDate.text,
//                                                         style: const TextStyle(
//                                                           color: Colors.black,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               const SizedBox(height: 10),
//                                               Container(
//                                                 width: 300,
//                                                 height: 50,
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.grey),
//                                                   borderRadius:
//                                                       BorderRadius.circular(5),
//                                                 ),
//                                                 child: InkWell(
//                                                   onTap: () async {
//                                                     final TimeOfDay? picked =
//                                                         await showTimePicker(
//                                                       context: context,
//                                                       initialTime:
//                                                           TimeOfDay.now(),
//                                                     );

//                                                     if (picked != null) {
//                                                       String formatTime =
//                                                           '${picked.hour}:${picked.minute}:00';
//                                                       picked.replacing(
//                                                           hour: 00, minute: 00);

//                                                       evStartTime.text =
//                                                           formatTime;
//                                                       setState(() {
//                                                         print(evStartTime.text);
//                                                         evStartTime.text =
//                                                             picked.format(
//                                                                 context);
//                                                       });
//                                                     }
//                                                   },
//                                                   child: Align(
//                                                     alignment:
//                                                         Alignment.centerLeft,
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               9.0),
//                                                       child: Text(
//                                                         evStartTime.text,
//                                                         style: const TextStyle(
//                                                           color: Colors.black,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               const SizedBox(
//                                                 height: 10,
//                                               ),
//                                               Container(
//                                                 width: 300,
//                                                 height: 50,
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colors.grey),
//                                                   borderRadius:
//                                                       BorderRadius.circular(5),
//                                                 ),
//                                                 child: InkWell(
//                                                   onTap: () async {
//                                                     final TimeOfDay? picked =
//                                                         await showTimePicker(
//                                                       context: context,
//                                                       initialTime:
//                                                           TimeOfDay.now(),
//                                                     );

//                                                     if (picked != null) {
//                                                       String formatTime =
//                                                           '${picked.hour}:${picked.minute}:00';
//                                                       evEndTime.text =
//                                                           formatTime;
//                                                       setState(() {
//                                                         print(evEndTime.text);
//                                                         evEndTime.text = picked
//                                                             .format(context);
//                                                       });
//                                                     }
//                                                   },
//                                                   child: Align(
//                                                     alignment:
//                                                         Alignment.centerLeft,
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               9.0),
//                                                       child: Text(
//                                                         evEndTime.text,
//                                                         style: const TextStyle(
//                                                           color: Colors.black,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               const SizedBox(height: 10),
//                                               TextField(
//                                                 controller: evLocation,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                   labelText: 'Event Location',
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         actions: [
//                                           TextButton(
//                                             onPressed: () {
//                                               var id = event.eventId;
//                                               DatabaseHelper.instance
//                                                   .updateEvent(
//                                                 Event(
//                                                   eventId: id,
//                                                   eventTitle: evTitle.text,
//                                                   eventType: evType.text,
//                                                   eventDate: evDate.text,
//                                                   eventStartTime:
//                                                       evStartTime.text,
//                                                   eventEndTime: evEndTime.text,
//                                                   eventLocation:
//                                                       evLocation.text,
//                                                   eventDetails: evDetails.text,
//                                                 ),
//                                               );
//                                               setState(() {});
//                                               Navigator.of(context).pop();
//                                             },
//                                             child: const Text('Submit'),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                 },
//                                 child: const Icon(Icons.edit),
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   DatabaseHelper.instance
//                                       .deleteEvent(event.eventId);
//                                   setState(() {});
//                                 },
//                                 child: const Icon(Icons.delete),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ]);
//                 },
//               );
//             } else if (snapshot.hasError) {
//               return const Placeholder();
//             }
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'database/mysql.dart';
import 'model/event.dart';

class AllEvents extends StatefulWidget {
  const AllEvents({super.key});

  @override
  State<AllEvents> createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
  TextEditingController evTitle = TextEditingController(text: '');
  TextEditingController evType = TextEditingController(text: '');
  TextEditingController evDate = TextEditingController(text: 'Date');
  TextEditingController evStartTime = TextEditingController(text: 'Start Time');
  TextEditingController evEndTime = TextEditingController(text: 'End Time');
  TextEditingController evLocation = TextEditingController(text: '');
  TextEditingController evDetails = TextEditingController(text: '');
  final List<String> _typelist = [
    'Anniversary',
    'Birthday',
    'Holiday',
    'Exams',
    'Regular Events'
  ];
  String _type = 'Regular Events';
  List<int> selectedIndices = [];
  List<int> id = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Events'),
      ),
      body: Center(
        child: FutureBuilder<List<Event>>(
          future: DatabaseHelper.instance.getEvents(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final event = snapshot.data![index];
                  final isSelected = selectedIndices.contains(index);

                  return Column(
                    children: [
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedIndices.remove(index);
                            } else {
                              selectedIndices.add(index);
                              // store event ids in a list

                              id.add(snapshot.data![index].eventId);
                              // show floating action button
                            }
                          });
                        },
                        child: Container(
                          height: 120,
                          width: 300,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.grey : Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(snapshot.data![index].eventTitle),
                            subtitle: Column(
                              children: [
                                Text("Event Type${event.eventType}"),
                                Text('Date: ${event.eventDate}'),
                                Text(
                                    'Time: ${event.eventStartTime} - ${event.eventEndTime}'),
                                Text('Location: ${event.eventLocation}'),
                                Text('Details: ${event.eventDetails}'),
                              ],
                            ),
                            leading: Column(
                              children: [
                                Icon(Icons.event_note_outlined),
                                Text(event.eventDate.substring(0, 2)),
                              ],
                            ),
                            trailing: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Edit Event'),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                TextField(
                                                  controller: evTitle,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Event Title',
                                                  ),
                                                ),
                                                Container(
                                                  width: 300,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: DropdownButton(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    value: _type,
                                                    items: _typelist
                                                        .map((String items) {
                                                      return DropdownMenuItem(
                                                        value: items,
                                                        child: Text(items),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String?
                                                        newValue) async {
                                                      setState(() {
                                                        _type = newValue!;
                                                        evType.text = _type;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                InkWell(
                                                  onTap: () async {
                                                    DateTime? picked =
                                                        await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate:
                                                          DateTime(2015, 8),
                                                      lastDate: DateTime(2101),
                                                    );
                                                    if (picked != null) {
                                                      String formattedDate =
                                                          "${picked.day}/${picked.month}/${picked.year}";
                                                      evDate.text =
                                                          formattedDate;
                                                      setState(() {
                                                        evDate.text =
                                                            formattedDate
                                                                .toString();
                                                        print(evDate.text);
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 300,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(9.0),
                                                        child: Text(
                                                          evDate.text,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Container(
                                                  width: 300,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      final TimeOfDay? picked =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime:
                                                            TimeOfDay.now(),
                                                      );

                                                      if (picked != null) {
                                                        String formatTime =
                                                            '${picked.hour}:${picked.minute}:00';
                                                        picked.replacing(
                                                            hour: 00,
                                                            minute: 00);

                                                        evStartTime.text =
                                                            formatTime;
                                                        setState(() {
                                                          print(
                                                              evStartTime.text);
                                                          evStartTime.text =
                                                              picked.format(
                                                                  context);
                                                        });
                                                      }
                                                    },
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(9.0),
                                                        child: Text(
                                                          evStartTime.text,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  width: 300,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      final TimeOfDay? picked =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime:
                                                            TimeOfDay.now(),
                                                      );

                                                      if (picked != null) {
                                                        String formatTime =
                                                            '${picked.hour}:${picked.minute}:00';

                                                        evEndTime.text =
                                                            formatTime;
                                                        setState(() {
                                                          print(evEndTime.text);
                                                          evEndTime.text =
                                                              picked.format(
                                                                  context);
                                                        });
                                                      }
                                                    },
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(9.0),
                                                        child: Text(
                                                          evEndTime.text,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                TextField(
                                                  controller: evLocation,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Event Location',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                var id = event.eventId;
                                                DatabaseHelper.instance
                                                    .updateEvent(Event(
                                                  eventId: id,
                                                  eventTitle: evTitle.text,
                                                  eventType: evType.text,
                                                  eventDate: evDate.text,
                                                  eventStartTime:
                                                      evStartTime.text,
                                                  eventEndTime: evEndTime.text,
                                                  eventLocation:
                                                      evLocation.text,
                                                  eventDetails: evDetails.text,
                                                ));
                                                setState(() {});
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Submit'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(Icons.edit),
                                ),
                                InkWell(
                                  onTap: () {
                                    DatabaseHelper.instance
                                        .deleteEvent(event.eventId);
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Placeholder();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     DatabaseHelper.instance.chainEvents(id[0], id[1]);
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
