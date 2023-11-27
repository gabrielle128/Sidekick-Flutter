// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/screens/account/account_screen.dart';
import 'package:sidekick_app/sidekick_icons_icons.dart';
import 'package:sidekick_app/utils/colours.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // define variables
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<dynamic>> _events = {};
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String userId;
  late String userEmail;

  // table calendar and account button
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // for account settings
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 90,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 30, 0),
              child: IconButton(
                icon: const Icon(
                  SidekickIcons.account,
                  color: black,
                  size: 50,
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountScreen())),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
              child: TableCalendar(
                locale: "en_US",
                calendarFormat: _calendarFormat,
                focusedDay: _focusedDay,
                firstDay: DateTime.utc(2021, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                rowHeight: 50,
                daysOfWeekHeight: 40,
                onFormatChanged: ((format) => setState(() {
                      _calendarFormat = format;
                      _focusedDay = _focusedDay;
                    })),
                headerStyle: const HeaderStyle(
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      fontSize: 22,
                    ),
                    formatButtonShowsNext: false,
                    headerMargin: EdgeInsets.only(bottom: 15.0),
                    formatButtonTextStyle: TextStyle(fontSize: 12)),
                daysOfWeekStyle: DaysOfWeekStyle(
                    dowTextFormatter: (date, locale) =>
                        DateFormat.E(locale).format(date)[0],
                    weekdayStyle: const TextStyle(fontSize: 18),
                    weekendStyle: const TextStyle(fontSize: 18)),
                calendarStyle: const CalendarStyle(
                    defaultTextStyle: TextStyle(fontSize: 16),
                    weekendTextStyle: TextStyle(fontSize: 16),
                    todayTextStyle: TextStyle(color: white, fontSize: 16),
                    todayDecoration: BoxDecoration(
                        color: Color.fromARGB(255, 111, 134, 172)),
                    selectedTextStyle: TextStyle(color: white, fontSize: 16),
                    selectedDecoration: BoxDecoration(color: navy)),
                startingDayOfWeek: StartingDayOfWeek.sunday,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = DateTime(
                        selectedDay.year, selectedDay.month, selectedDay.day);
                    _focusedDay = focusedDay;
                  });
                },
                eventLoader: (date) {
                  DateTime selectedDate =
                      DateTime(date.year, date.month, date.day);
                  return _events[selectedDate] ?? [];
                },
              ),
            ),
            const Divider(),
            const SizedBox(height: 10),
            _buildEventList(),
            const SizedBox(height: 20),
          ],
        ),
      ),

      floatingActionButton: quickActionButton(),
    );
  }

  // quick action button
  SpeedDial quickActionButton() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      overlayColor: bgcolor,
      overlayOpacity: 0,
      foregroundColor: black,
      backgroundColor: yellow,
      spacing: 12,
      spaceBetweenChildren: 5,
      children: [
        SpeedDialChild(
          child: const Icon(SidekickIcons.toDoList),
          backgroundColor: yellow,
          label: 'To Do',
          onTap: () => showToast('Add To Do...'),
        ),
        SpeedDialChild(
          child: const Icon(SidekickIcons.journal),
          backgroundColor: yellow,
          label: 'Journal',
          onTap: () => showToast('Add Journal...'),
        ),
        SpeedDialChild(
          child: const Icon(SidekickIcons.wallet),
          backgroundColor: yellow,
          label: 'Budget',
          onTap: () => showToast('Add Budget...'),
        ),
        SpeedDialChild(
          child: const Icon(SidekickIcons.event),
          backgroundColor: yellow,
          label: 'Event',
          onTap: () => _showAddEventDialog(context),
        ),
      ],
    );
  }

  // widget to show event under table calendar
  Widget _buildEventList() {
    final selectedEvents = _events[_selectedDay]?.cast<Event>() ?? [];
    final focusedEvents = _events[_focusedDay]?.cast<Event>() ?? [];

    final allEvents = <Event>{...selectedEvents, ...focusedEvents}.toList();

    if (allEvents.isEmpty) {
      return const Center(
        child: Text('No events'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: allEvents
          .map((event) => GestureDetector(
                onTap: () {
                  _showEventDetailsDialog(context, event);
                },
                child: Card(
                  color: bgcolorCV,
                  shadowColor: black,
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ListTile(
                    title: Text(event.title),
                    subtitle: Text(event.description),
                  ),
                ),
              ))
          .toList(),
    );
  }

  // get user id and email from firestore
  void getUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
      userEmail = user.email!;
    }
  }

  // used to check if the widget is still mounted before performing any state updates in asynchronouse operations
  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  // initialize the user and events from firestore
  @override
  void initState() {
    super.initState();
    getUser();
    _getEventsFromFirestore();
  }

  // get events from firestore
  void _getEventsFromFirestore() async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('events')
          .doc(userId)
          .collection(userEmail)
          .get();

      final List<Event> events = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Event(
          id: doc.id,
          title: data['title'],
          description: data['description'],
          date: DateTime.parse(data['date']),
        );
      }).toList();

      if (!_isDisposed) {
        setState(() {
          _events = _groupEventsByDate(events);
        });

        // Check if events for the focused day are present, if not, reload them
        if (_events[_focusedDay] == null) {
          await _getEventsForFocusedDay();
        }
      }
    } catch (e) {
      // Handle error
    }
  }

  // get events on focused day function
  Future<void> _getEventsForFocusedDay() async {
    try {
      if (!_isDisposed) {
        final focusedEventsSnapshot = await _firestore
            .collection('events')
            .doc(userId)
            .collection(userEmail)
            .where('date',
                isGreaterThanOrEqualTo:
                    _focusedDay.toIso8601String().substring(0, 10))
            .where('date',
                isLessThan: _focusedDay
                    .add(const Duration(days: 1))
                    .toIso8601String()
                    .substring(0, 10))
            .get();

        final focusedEvents = focusedEventsSnapshot.docs.map((doc) {
          final data = doc.data();
          return Event(
            id: doc.id,
            title: data['title'],
            description: data['description'],
            date: DateTime.parse(data['date']),
          );
        }).toList();

        if (!_isDisposed) {
          setState(() {
            _events[_focusedDay] = focusedEvents;
          });
        }
      }
    } catch (e) {
      // Handle error
    }
  }

  // group events by date
  Map<DateTime, List<dynamic>> _groupEventsByDate(List<Event> events) {
    Map<DateTime, List<dynamic>> groupedEvents = {};

    for (var event in events) {
      DateTime date =
          DateTime(event.date.year, event.date.month, event.date.day);

      if (groupedEvents[date] == null) {
        groupedEvents[date] = [];
      }
      groupedEvents[date]!
          .insert(0, event); // Insert new events at the beginning of the list
    }

    return groupedEvents;
  }

  // add event function
  Future<void> _addEventToFirestore(
      String title, String description, DateTime date) async {
    final newEventId = Random()
        .nextInt(999999)
        .toString(); // Generate a unique ID for the new event

    await _firestore
        .collection('events')
        .doc(userId)
        .collection(userEmail)
        .doc(newEventId)
        .set({
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
    });

    _getEventsFromFirestore();
  }

  // add event function
  void _showAddEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                  _addEventToFirestore(_titleController.text,
                      _descriptionController.text, _selectedDay);
                  _titleController.clear();
                  _descriptionController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // show event details ui
  void _showEventDetailsDialog(BuildContext context, Event event) {
    TextEditingController _editTitleController =
        TextEditingController(text: event.title);
    TextEditingController _editDescriptionController =
        TextEditingController(text: event.description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Event Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title: ${event.title}'),
              const SizedBox(height: 8),
              Text('Description: ${event.description}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _showEditEventDialog(context, event);
              },
              child: const Text('Edit'),
            ),
            TextButton(
              onPressed: () {
                _deleteEventFromFirestore(event).then((_) {
                  _getEventsFromFirestore();
                  Navigator.of(context).pop();
                });
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // show edit event ui
  void _showEditEventDialog(BuildContext context, Event event) {
    TextEditingController _editTitleController =
        TextEditingController(text: event.title);
    TextEditingController _editDescriptionController =
        TextEditingController(text: event.description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _editTitleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _editDescriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Event updatedEvent = Event(
                  id: event.id,
                  title: _editTitleController.text,
                  description: _editDescriptionController.text,
                  date: event.date,
                );
                _updateEventInFirestore(updatedEvent).then((_) {
                  _getEventsFromFirestore();
                  Navigator.of(context).popUntil(
                      (route) => route.isFirst); // Return to the main screen
                });
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  // update event function
  Future<void> _updateEventInFirestore(Event event) async {
    await FirebaseFirestore.instance
        .collection('events')
        .doc(userId)
        .collection(userEmail)
        .doc(event.id)
        .update({
      'title': event.title,
      'description': event.description,
      'date': event.date.toIso8601String(),
    });
  }

  // delete event function
  Future<void> _deleteEventFromFirestore(Event event) async {
    await FirebaseFirestore.instance
        .collection('events')
        .doc(userId)
        .collection(userEmail)
        .doc(event.id)
        .delete();
  }
}

// Event Model
class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;

  Event(
      {required this.id,
      required this.title,
      required this.description,
      required this.date});
}
