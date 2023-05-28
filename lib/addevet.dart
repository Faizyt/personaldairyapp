import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'database/mysql.dart';
import 'model/event.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController evTitle = TextEditingController(text: '');
  TextEditingController evType = TextEditingController(text: '');
  TextEditingController evDate = TextEditingController(text: 'Date');
  TextEditingController evStartTime = TextEditingController(text: 'Start Time');
  TextEditingController evEndTime = TextEditingController(text: 'End Time');
  TextEditingController evLocation = TextEditingController(text: '');
  TextEditingController evDetails = TextEditingController(text: '');
  TextEditingController evImage = TextEditingController(text: '');

  final List<String> _typelist = [
    'Anniversary',
    'Birthday',
    'Holiday',
    'Exams',
    'Regular Events'
  ];
  String _type = 'Regular Events';
  final List<String> _typelistrepeat = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12"
  ];
  String _typeRepeat = '1';
  var repeatevent = false;
  String repeatcheck = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // create filed for event name
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  //make text filed small and add border
                  controller: evTitle,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // const Text('Select Type'),
              Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton(
                    alignment: Alignment.centerLeft,
                    // Initial Value
                    value: _type,
                    // Down Arrow Icon
                    // icon: const Icon(Icons.keyboard_arrow_down),
                    // Array list of items
                    items: _typelist.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) async {
                      setState(() {
                        _type = newValue!;
                        evType.text = _type;
                      });
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  // show date picker
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2015, 8),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    // update date field
                    //modify date in dd/mm/yyyy format
                    String formattedDate =
                        "${picked.day}/${picked.month}/${picked.year}";
                    evDate.text = formattedDate;
                    setState(() {
                      evDate.text = formattedDate.toString();
                      print(evDate.text);
                    });
                  }
                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Text(
                          evDate.text,
                          style: const TextStyle(color: Colors.black),
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                    onTap: () async {
                      // show time picker
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (picked != null) {
                        // Modify initial time below
                        // modify time in hh:mm:00 format
                        String formatTime =
                            '${picked.hour}:${picked.minute}:00';
                        picked.replacing(hour: 00, minute: 00);

                        evStartTime.text = formatTime;
                        setState(() {
                          print(evStartTime.text);
                          evStartTime.text = picked.format(context);
                        });
                      }
                    },
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Text(
                            evStartTime.text,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ))),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                    onTap: () async {
                      // show time picker
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (picked != null) {
                        // Modify initial time below
                        // modify time in hh:mm:00 format
                        String formatTime =
                            '${picked.hour}:${picked.minute}:00';
                        // picked.replacing(hour: 00, minute: 00);
                        // update time field
                        evEndTime.text = formatTime;
                        setState(() {
                          print(evEndTime.text);
                          evEndTime.text = picked.format(context);
                        });
                      }
                    },
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Text(
                            evEndTime.text,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ))),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: evLocation,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Venue',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: evDetails,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
              ),
              // add button to save event
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Checkbox(
                      value: repeatevent,
                      onChanged: (bool? value) {
                        setState(() {
                          repeatevent = value!;
                        });
                      }),
                  const Text('Repeat check box'),
                  // Container(
                  //   width: 100,
                  //   height: 50,
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey),
                  //     borderRadius: BorderRadius.circular(5),
                  //   ),
                  //   child: DropdownButton(
                  //       alignment: Alignment.centerLeft,
                  //       // Initial Value
                  //       value: _typeRepeat,
                  //       // Down Arrow Icon
                  //       // icon: const Icon(Icons.keyboard_arrow_down),
                  //       // Array list of items
                  //       items: _typelistrepeat.map((String items) {
                  //         return DropdownMenuItem(
                  //           value: items,
                  //           child: Text(items),
                  //         );
                  //       }).toList(),
                  //       // After selecting the desired option,it will
                  //       // change button value to selected value
                  //       onChanged: (String? newValue) async {
                  //         setState(() {
                  //           _typeRepeat = newValue!;
                  //           repeatcheck = _typeRepeat;
                  //         });
                  //       }),
                  // ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // save event
                  int id = Random().nextInt(100);
                  print(id);
                  final event = Event(
                      eventTitle: evTitle.text,
                      eventId: id,
                      eventDate: evDate.text,
                      eventDetails: evDetails.text,
                      eventEndTime: evStartTime.text,
                      eventLocation: evLocation.text,
                      eventType: evType.text,
                      eventStartTime: evEndTime.text);
                  if (repeatevent == false) {
                    DatabaseHelper.instance.insertRepeatEvent(event, false);
                  } else {
                    DatabaseHelper.instance.insertRepeatEvent(event, true);
                  }
                  // navigate back
                  Navigator.pop(context);
                },
                child: const Text('Add Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
