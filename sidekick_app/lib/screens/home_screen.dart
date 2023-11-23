import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sidekick_app/screens/account/account_screen.dart';
import 'package:sidekick_app/screens/event/add_event.dart';
import 'package:sidekick_app/sidekick_icons_icons.dart';
import 'package:sidekick_app/utils/colours.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  late DateTime _focusedDay = DateTime.now();
  late final DateTime _firstDay =
      DateTime.now().subtract(const Duration(days: 1000));
  late final DateTime _lastDay = DateTime.now().add(const Duration(days: 1000));
  late DateTime _selectedDay = DateTime.now();
  late CalendarFormat _calendarFormat = CalendarFormat.month;

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

        // for quick action button
        floatingActionButton: quickActionButton(),

        // for calendar
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                child: TableCalendar(
                  locale: "en_US",
                  focusedDay: _focusedDay,
                  firstDay: _firstDay,
                  lastDay: _lastDay,
                  calendarFormat: _calendarFormat,
                  onFormatChanged: ((format) => setState(() {
                        _calendarFormat = format;
                        _focusedDay = _focusedDay;
                      })),
                  selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  rowHeight: 60,
                  daysOfWeekHeight: 50,
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
                      weekdayStyle: const TextStyle(fontSize: 20),
                      weekendStyle: const TextStyle(fontSize: 20)),
                  calendarStyle: const CalendarStyle(
                      defaultTextStyle: TextStyle(fontSize: 18),
                      weekendTextStyle: TextStyle(fontSize: 18),
                      todayTextStyle: TextStyle(color: black, fontSize: 18),
                      todayDecoration: BoxDecoration(color: skyblue),
                      selectedTextStyle: TextStyle(color: black, fontSize: 18),
                      selectedDecoration: BoxDecoration(
                          color: Color.fromARGB(255, 190, 188, 188))),
                ),
              )
            ],
          ),
        ));
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
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddEventPage())),
        ),
      ],
    );
  }

  Future showToast(String message) async {
    await Fluttertoast.cancel();

    Fluttertoast.showToast(msg: message, fontSize: 18);
  }
}

// Text(
//   user.email!,
//   style: TextStyle(fontSize: 20, color: black);
// )
