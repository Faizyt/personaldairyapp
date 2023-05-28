import 'package:dairy/addevet.dart';
import 'package:dairy/model/event.dart';
import 'package:flutter/material.dart';
import 'allevents.dart';
import 'database/mysql.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  // section variable for event edit
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
// section variable for event edit end
  int currentIndex = 1;
  int monthIndex = 1;
  int yearIndex = 1;

  // create list of year from 2000 to 2030
  final List<String> years = [
    '2000',
    '2001',
    '2002',
    '2003',
    '2004',
    '2005',
    '2006',
    '2007',
    '2008',
    '2009',
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030',
  ];
  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  // dates for feb will be 1 to 28
  List<String> febdates = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
  ];
  // dates for rest will be 1 to 30
  List<String> midates = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
  ];
  List<String> dates = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
  ];

  void handleButtonPress(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void handleMonthPress(int index) {
    setState(() {
      monthIndex = index;
    });
  }

  void handleYearPress(int index) {
    setState(() {
      yearIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isPressed = false;

    void handlePress() {
      setState(() {
        isPressed = !isPressed;
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Calender'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddEvent();
                }));
              },
              icon: const Icon(Icons.add),
            ),
            // Icon for all events
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AllEvents();
                }));
              },
              icon: const Icon(Icons.event),
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            // show years
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (var year in years)
                    CustomButton(
                      date: year,
                      currentIndex: yearIndex,
                      onPressed: handleYearPress,
                      index: years.indexOf(year),
                    )
                ],
              ),
            ),
            const SizedBox(height: 10),
            // show months
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (var month in months)
                    CustomButton(
                      date: month,
                      currentIndex: monthIndex,
                      onPressed: handleMonthPress,
                      index: months.indexOf(month),
                    )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    // height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Expanded(
                        child: monthIndex == 1
                            ? ListView(
                                children: [
                                  // remove 29, 30, 31 from feb
                                  for (var date in febdates)
                                    CustomButton(
                                      date: date,
                                      currentIndex: currentIndex,
                                      onPressed: handleButtonPress,
                                      index: dates.indexOf(date),
                                    )
                                ],
                              )
                            : (monthIndex == 3 ||
                                    monthIndex == 5 ||
                                    monthIndex == 8 ||
                                    monthIndex == 10)
                                ? ListView(
                                    children: [
                                      // add 29, 30 to apr, jun, sep, nov
                                      for (var date in midates)
                                        CustomButton(
                                          date: date,
                                          currentIndex: currentIndex,
                                          onPressed: handleButtonPress,
                                          index: dates.indexOf(date),
                                        )
                                    ],
                                  )
                                : ListView(
                                    children: [
                                      // add 29, 30, 31 to rest
                                      for (var date in dates)
                                        CustomButton(
                                          date: date,
                                          currentIndex: currentIndex,
                                          onPressed: handleButtonPress,
                                          index: dates.indexOf(date),
                                        )
                                    ],
                                  )),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        FutureBuilder<List<Event>>(
                          future: getEventsbydate(),
                          // future: getEvents(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Expanded(
                                child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final event = snapshot.data![index];
                                    return Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Container(
                                          height: 120,
                                          width: 300,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ListTile(
                                              title: Text(snapshot
                                                  .data![index].eventTitle),
                                              subtitle: Column(
                                                children: [
                                                  Text(
                                                      "Event Type${event.eventType}"),
                                                  Text(
                                                      'Date: ${event.eventDate}'),
                                                  Text(
                                                      'Time: ${event.eventStartTime} - ${event.eventEndTime}'),
                                                  Text(
                                                      'Location: ${event.eventLocation}'),
                                                  Text(
                                                      'Details: ${event.eventDetails}'),
                                                ],
                                              ),
                                              leading: Column(
                                                children: [
                                                  Icon(Icons
                                                      .event_note_outlined),
                                                  Text(event.eventDate
                                                      .substring(0, 2)),
                                                ],
                                              ),
                                              trailing: Column(
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Edit Event'),
                                                              content:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  children: [
                                                                    TextField(
                                                                      controller:
                                                                          evTitle,
                                                                      decoration:
                                                                          const InputDecoration(
                                                                        labelText:
                                                                            'Event Title',
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          300,
                                                                      height:
                                                                          50,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
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
                                                                    const SizedBox(
                                                                        height:
                                                                            10),
                                                                    InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        // show date picker
                                                                        DateTime?
                                                                            picked =
                                                                            await showDatePicker(
                                                                          context:
                                                                              context,
                                                                          initialDate:
                                                                              DateTime.now(),
                                                                          firstDate: DateTime(
                                                                              2015,
                                                                              8),
                                                                          lastDate:
                                                                              DateTime(2101),
                                                                        );
                                                                        if (picked !=
                                                                            null) {
                                                                          // update date field
                                                                          //modify date in dd/mm/yyyy format
                                                                          String
                                                                              formattedDate =
                                                                              "${picked.day}/${picked.month}/${picked.year}";
                                                                          evDate.text =
                                                                              formattedDate;
                                                                          setState(
                                                                              () {
                                                                            evDate.text =
                                                                                formattedDate.toString();
                                                                            print(evDate.text);
                                                                          });
                                                                        }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            300,
                                                                        height:
                                                                            50,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border:
                                                                              Border.all(color: Colors.grey),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
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
                                                                    const SizedBox(
                                                                        height:
                                                                            10),
                                                                    Container(
                                                                      width:
                                                                          300,
                                                                      height:
                                                                          50,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                      ),
                                                                      child: InkWell(
                                                                          onTap: () async {
                                                                            // show time picker
                                                                            final TimeOfDay?
                                                                                picked =
                                                                                await showTimePicker(
                                                                              context: context,
                                                                              initialTime: TimeOfDay.now(),
                                                                            );

                                                                            if (picked !=
                                                                                null) {
                                                                              // Modify initial time below
                                                                              // modify time in hh:mm:00 format
                                                                              String formatTime = '${picked.hour}:${picked.minute}:00';
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
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          300,
                                                                      height:
                                                                          50,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                      ),
                                                                      child: InkWell(
                                                                          onTap: () async {
                                                                            // show time picker
                                                                            final TimeOfDay?
                                                                                picked =
                                                                                await showTimePicker(
                                                                              context: context,
                                                                              initialTime: TimeOfDay.now(),
                                                                            );

                                                                            if (picked !=
                                                                                null) {
                                                                              // Modify initial time below
                                                                              // modify time in hh:mm:00 format
                                                                              String formatTime = '${picked.hour}:${picked.minute}:00';
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
                                                                        height:
                                                                            10),
                                                                    TextField(
                                                                      controller:
                                                                          evLocation,
                                                                      decoration:
                                                                          const InputDecoration(
                                                                        labelText:
                                                                            'Event Location',
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    var id = event
                                                                        .eventId;
                                                                    DatabaseHelper.instance.updateEvent(Event(
                                                                        eventId:
                                                                            id,
                                                                        eventTitle:
                                                                            evTitle
                                                                                .text,
                                                                        eventType:
                                                                            evType
                                                                                .text,
                                                                        eventDate:
                                                                            evDate
                                                                                .text,
                                                                        eventStartTime:
                                                                            evStartTime
                                                                                .text,
                                                                        eventEndTime:
                                                                            evEndTime
                                                                                .text,
                                                                        eventLocation:
                                                                            evLocation
                                                                                .text,
                                                                        eventDetails:
                                                                            evDetails.text));
                                                                    setState(
                                                                        () {});
                                                                    // Handle button tap
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(); // Close the dialog
                                                                  },
                                                                  child: const Text(
                                                                      'Submit'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: const Icon(
                                                          Icons.edit)),
                                                  InkWell(
                                                      onTap: () {
                                                        DatabaseHelper.instance
                                                            .deleteEvent(
                                                                event.eventId);
                                                        setState(() {});
                                                      },
                                                      child: const Icon(
                                                          Icons.delete)),
                                                ],
                                              )),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return const Placeholder();
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Future<List<Event>> getEvents() {
    // get event by date from database

    final events = DatabaseHelper.instance.getEvents();

    return events;
    // return _getAppointmentsFromEvents(events);
  }

  Future<List<Event>> getEventsbydate() {
    var month = getMonthNumber(months[monthIndex]);
    var date = dates[currentIndex];
    var year = years[yearIndex];
    var eventDate = '$date/$month/$year';
    print(eventDate);
    final events = DatabaseHelper.instance.getEventsByDate(eventDate);
    return events;
  }

  // convert month to number
  String getMonthNumber(String month) {
    switch (month) {
      case 'Jan':
        return '01';
      case 'Feb':
        return '02';
      case 'Mar':
        return '03';
      case 'Apr':
        return '04';
      case 'May':
        return '05';
      case 'Jun':
        return '06';
      case 'Jul':
        return '07';
      case 'Aug':
        return '08';
      case 'Sep':
        return '09';
      case 'Oct':
        return '10';
      case 'Nov':
        return '11';
      case 'Dec':
        return '12';
      default:
        return '01';
    }
  }
}

class CustomButton extends StatefulWidget {
  final String date;
  final int currentIndex;
  final int index;
  final ValueChanged<int> onPressed;

  const CustomButton({
    Key? key,
    required this.date,
    required this.currentIndex,
    required this.onPressed,
    required this.index,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final isPressed = widget.currentIndex == widget.index;
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: isPressed ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () {
          widget.onPressed(widget.index);
        },
        child: Text(
          widget.date,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
