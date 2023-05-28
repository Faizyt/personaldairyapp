import 'package:flutter/material.dart';

class Event {
  int eventId;
  String eventTitle;
  String eventType;
  String eventDate;
  String eventStartTime;
  String eventEndTime;
  String eventLocation;
  String eventDetails;

  Event({
    required this.eventId,
    required this.eventTitle,
    required this.eventType,
    required this.eventDate,
    required this.eventStartTime,
    required this.eventEndTime,
    required this.eventLocation,
    required this.eventDetails,
  });

  Map<String, dynamic> toMap() {
    return {
      'Eventid': eventId,
      'Eventtitle': eventTitle,
      'Eventtype': eventType,
      'Eventdate': eventDate,
      'Eventstarttime': eventStartTime,
      'Eventendtime': eventEndTime,
      'Eventlocation': eventLocation,
      'Eventdetails': eventDetails,
    };
  }
}
