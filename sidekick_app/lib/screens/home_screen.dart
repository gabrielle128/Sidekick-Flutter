import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
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
                  onPressed: () => FirebaseAuth.instance.signOut(),
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
                  focusedDay: DateTime.now(),
                  firstDay: DateTime.utc(1950, 1, 1),
                  lastDay: DateTime.utc(2050, 12, 31),
                  rowHeight: 60,
                  daysOfWeekHeight: 50,
                  headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        fontSize: 30,
                      ),
                      headerMargin: EdgeInsets.only(bottom: 15.0)),
                  daysOfWeekStyle: DaysOfWeekStyle(
                      dowTextFormatter: (date, locale) =>
                          DateFormat.E(locale).format(date)[0],
                      weekdayStyle: const TextStyle(fontSize: 18),
                      weekendStyle: const TextStyle(fontSize: 18)),
                  calendarStyle: const CalendarStyle(
                      defaultTextStyle: TextStyle(fontSize: 18),
                      weekendTextStyle: TextStyle(fontSize: 18),
                      todayTextStyle: TextStyle(color: black),
                      todayDecoration: BoxDecoration(
                          color: Color.fromARGB(255, 190, 188, 188))),
                ),
              )
            ],
          ),
        )

        // body: Center(
        //   child: ElevatedButton(
        //     child: const Text("Logout"),
        //     onPressed: () {
        //       FirebaseAuth.instance.signOut().then((value) {
        //         // ignore: avoid_print
        //         print("Signed Out");
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => const WelcomeScreen()));
        //       });
        //     },
        //   ),
        // ),
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
          onTap: () => showToast('Add Event...'),
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
