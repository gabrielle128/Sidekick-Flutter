// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/screens/account/account_screen.dart';
import 'package:sidekick_app/screens/event/event_model.dart';
import 'package:sidekick_app/screens/journal/add_journal.dart';
import 'package:sidekick_app/screens/todo/add_task_dialog.dart';
import 'package:sidekick_app/screens/wallet/add_expense.dart';
import 'package:sidekick_app/utils/sidekick_icons_icons.dart';
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
        automaticallyImplyLeading: false,
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
                      fontSize: 26,
                    ),
                    formatButtonShowsNext: false,
                    headerMargin: EdgeInsets.only(bottom: 15.0),
                    formatButtonTextStyle: TextStyle(fontSize: 12)),
                daysOfWeekStyle: DaysOfWeekStyle(
                    dowTextFormatter: (date, locale) =>
                        DateFormat.E(locale).format(date)[0],
                    weekdayStyle: const TextStyle(fontSize: 24),
                    weekendStyle: const TextStyle(fontSize: 24)),
                calendarStyle: const CalendarStyle(
                    defaultTextStyle: TextStyle(fontSize: 20),
                    weekendTextStyle: TextStyle(fontSize: 20),
                    todayTextStyle: TextStyle(color: white, fontSize: 20),
                    todayDecoration: BoxDecoration(
                        color: Color.fromARGB(255, 111, 134, 172)),
                    selectedTextStyle: TextStyle(color: white, fontSize: 20),
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
            const Divider(
              color: Colors.grey,
            ),
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
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AddTaskAlertDialog();
              },
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(SidekickIcons.journal),
          backgroundColor: yellow,
          label: 'Journal',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddJournalScreen()));
          },
        ),
        SpeedDialChild(
          child: const Icon(SidekickIcons.wallet),
          backgroundColor: yellow,
          label: 'Budget',
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AddExpense();
              },
            );
          },
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

    List<Event> allEvents = [];

    if (_selectedDay != _focusedDay) {
      // Display events for selected day only if it's different from focused day
      allEvents.addAll(selectedEvents);
    } else {
      // Display events for focused day or selected day if it's the same
      allEvents.addAll(focusedEvents);
    }

    if (allEvents.isEmpty) {
      // Show a message if there are no events for the focused day when it's selected
      return const Center(
        child: Text('No events'),
      );
    }

    if (_selectedDay != _focusedDay) {
      // Remove events for focused day from the list when selected day is not focused day
      allEvents.removeWhere((event) => event.date == _focusedDay);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: allEvents
          .map(
            (event) => GestureDetector(
              onTap: () {
                _showEventDetailsDialog(context, event);
              },
              child: Card(
                color: offWhite,
                shadowColor: black,
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.only(left: 30.0, right: 30.0),
                  leading: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.title, size: 20.0), // Icon for title
                      SizedBox(height: 4),
                      Icon(Icons.description,
                          size: 20.0), // Icon for description
                    ],
                  ),
                  title: Text(event.title),
                  subtitle: Text(event.description),
                ),
              ),
            ),
          )
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

  @override
  void initState() {
    super.initState();
    getUser();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    await _getEventsFromFirestore();
    if (!_isDisposed && _events[_focusedDay] == null) {
      await _getEventsForFocusedDay();
      if (!_isDisposed) {
        setState(() {
          _selectedDay = _focusedDay;
        });
      }
    }
  }

  Future<void> _getEventsFromFirestore() async {
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
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _getEventsForFocusedDay() async {
    try {
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
      // ignore: avoid_print
      print('Fetching events for focused day...');
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

  // method to add an event in firestore
  Future<void> _addEventToFirestore(
      String title, String description, DateTime date) async {
    final newEventId = Random()
        .nextInt(999999)
        .toString(); // Generate a unique ID for the new event

    // Update local events first
    setState(() {
      if (_events[date] == null) {
        _events[date] = [];
      }
      _events[date]!.add(Event(
        id: newEventId,
        title: title,
        description: description,
        date: date,
      ));
    });

    // Add the event to Firestore
    try {
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
    } catch (e) {
      // Handle error
      // If there's an error adding the event to Firestore, remove it from local events to keep consistency
      setState(() {
        _events[date]!.removeWhere((event) => event.id == newEventId);
      });
      return; // Exit function if Firestore update fails
    }

    // Trigger UI refresh by calling setState after local state update
    setState(() {});

    // Don't call _getEventsFromFirestore() here to avoid re-fetching events immediately after adding a new event
  }

  // method to update an event in firestore
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

  // method to delete an event in firestore
  Future<void> _deleteEventFromFirestore(Event event) async {
    await FirebaseFirestore.instance
        .collection('events')
        .doc(userId)
        .collection(userEmail)
        .doc(event.id)
        .delete();
  }

  // add event function
  void _showAddEventDialog(BuildContext context) {
    bool _isTitleError = false;
    bool _isDescriptionError = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Create Event', textAlign: TextAlign.center),
              backgroundColor: offWhite,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      errorText: _isTitleError ? 'Title is required' : null,
                      suffixIcon: _isTitleError
                          ? const Icon(
                              Icons.error,
                              color: Colors.red,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      errorText: _isDescriptionError
                          ? 'Description is required'
                          : null,
                      suffixIcon: _isDescriptionError
                          ? const Icon(
                              Icons.error,
                              color: Colors.red,
                            )
                          : null,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isTitleError = _titleController.text.isEmpty;
                      _isDescriptionError = _descriptionController.text.isEmpty;
                    });
                    if (_titleController.text.isNotEmpty &&
                        _descriptionController.text.isNotEmpty) {
                      _addEventToFirestore(
                        _titleController.text,
                        _descriptionController.text,
                        _selectedDay,
                      );
                      _titleController.clear();
                      _descriptionController.clear();
                      Navigator.of(context).pop();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(navy),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(color: white),
                  ),
                ),
              ],
            );
          },
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
          title: const Text('Event Details', textAlign: TextAlign.center),
          backgroundColor: offWhite,
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
          title: const Text('Edit Event', textAlign: TextAlign.center),
          backgroundColor: offWhite,
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
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
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
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(navy),
              ),
              child: const Text(
                'Update',
                style: TextStyle(color: white),
              ),
            ),
          ],
        );
      },
    );
  }
}
