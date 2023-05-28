import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../model/event.dart';
import 'package:intl/intl.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'dairy.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> insertEvent(Event event) async {
    final db = await database;
    await db.insert(
      'addevent',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE addevent(
        Eventid INTEGER PRIMARY KEY,
        Eventtitle TEXT,
        Eventtype TEXT,
        Eventdate TEXT,
        Eventstarttime TEXT,
        Eventendtime TEXT,
        Eventlocation TEXT,
        Eventdetails TEXT
      )
      ''');
  }

  Future<List<Event>> getEventswithoutrepeat() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('addevent');
    return List.generate(maps.length, (index) {
      return Event(
        eventId: maps[index]['Eventid'],
        eventTitle: maps[index]['Eventtitle'],
        eventType: maps[index]['Eventtype'],
        eventDate: maps[index]['Eventdate'],
        eventStartTime: maps[index]['Eventstarttime'],
        eventEndTime: maps[index]['Eventendtime'],
        eventLocation: maps[index]['Eventlocation'],
        eventDetails: maps[index]['Eventdetails'],
      );
    });
  }

  Future<List<Event>> getEventsByDate(String date) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'addevent',
      where: 'Eventdate = ?',
      whereArgs: [date],
    );
    return List.generate(maps.length, (index) {
      return Event(
        eventId: maps[index]['Eventid'],
        eventTitle: maps[index]['Eventtitle'],
        eventType: maps[index]['Eventtype'],
        eventDate: maps[index]['Eventdate'],
        eventStartTime: maps[index]['Eventstarttime'],
        eventEndTime: maps[index]['Eventendtime'],
        eventLocation: maps[index]['Eventlocation'],
        eventDetails: maps[index]['Eventdetails'],
      );
    });
  }

  Future<void> updateEvent(Event event) async {
    final db = await database;
    await db.update(
      'addevent',
      event.toMap(),
      where: 'Eventid = ?',
      whereArgs: [event.eventId],
    );
  }

  // delete event
  Future<void> deleteEvent(int id) async {
    final db = await database;
    await db.delete(
      'addevent',
      where: 'Eventid = ?',
      whereArgs: [id],
    );
  }

  // chain events
  // Future<void> chainEvents(int firstEventId, int secondEventId) async {
  //   final db = await database;
  //   await db.update(
  //     'addevent',
  //     {'NextEventId': secondEventId},
  //     where: 'Eventid = ?',
  //     whereArgs: [firstEventId],
  //   );
  // }

  // repeat the event monthly

  // automaticly add the event to the next every month till next year
  Future<void> insertRepeatEvent(Event event, bool repeat) async {
    final db = await database;
    final batch = db.batch();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    DateTime eventDate = formatter.parse(event.eventDate);
    event.eventDate = formatter.format(eventDate);
    if (repeat) {
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      final DateTime eventDate = formatter.parse(event.eventDate);
      // Retrieve the ID of the last inserted event
      final lastEventId = event.eventId;

      for (int i = 0; i < 12; i++) {
        // final nextDate = eventDate.add(Duration(days: 30 * (i + 1)));
        // final nextDate = eventDate.add(Duration(
        //   days: 30,
        // ));
        final nextDate =
            DateTime(eventDate.year, eventDate.month + i + 1, eventDate.day);
        // add next year in nextdate

        // print(nextDate);
        final repeatedEvent = Event(
          eventId: lastEventId + i + 1,
          eventTitle: event.eventTitle,
          eventType: event.eventType,
          eventDate: formatter.format(nextDate),
          // eventDate: event.eventDate,
          eventStartTime: event.eventStartTime,
          eventEndTime: event.eventEndTime,
          eventLocation: event.eventLocation,
          eventDetails: event.eventDetails,
        );
        batch.insert(
          'addevent',
          repeatedEvent.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    } else {
      batch.insert(
        'addevent',
        event.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<Event>> getEvents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('addevent');
    final List<Event> events = [];

    for (final map in maps) {
      final Event event = Event(
        eventId: map['Eventid'],
        eventTitle: map['Eventtitle'],
        eventType: map['Eventtype'],
        eventDate: map['Eventdate'],
        eventStartTime: map['Eventstarttime'],
        eventEndTime: map['Eventendtime'],
        eventLocation: map['Eventlocation'],
        eventDetails: map['Eventdetails'],
      );

      events.add(event);

      if (map['LinkedEventId'] != null) {
        final List<Event> repeatedEvents =
            await getRepeatedEvents(map['LinkedEventId']);
        events.addAll(repeatedEvents);
      }
    }

    return events;
  }

  Future<List<Event>> getRepeatedEvents(int linkedEventId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'addevent',
      where: 'LinkedEventId = ?',
      whereArgs: [linkedEventId],
    );

    return List.generate(maps.length, (index) {
      return Event(
        eventId: maps[index]['Eventid'],
        eventTitle: maps[index]['Eventtitle'],
        eventType: maps[index]['Eventtype'],
        eventDate: maps[index]['Eventdate'],
        eventStartTime: maps[index]['Eventstarttime'],
        eventEndTime: maps[index]['Eventendtime'],
        eventLocation: maps[index]['Eventlocation'],
        eventDetails: maps[index]['Eventdetails'],
      );
    });
  }
}
