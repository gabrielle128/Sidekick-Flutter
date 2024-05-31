// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/screens/wallet/chart.dart';
import 'package:sidekick_app/utils/colours.dart';

class StatScreen extends StatelessWidget {
  const StatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: black,
        ),
        backgroundColor: bgcolor,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: 16.0), // Add margin to the left and right
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // SizedBox(height: 50.0),
            Center(
              child: Text(
                "Transactions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              width: double.infinity,
              height: 2, // Increase the height to make the dotted line visible
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: CustomPaint(
                painter: DottedLinePainter(),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                  child: const MyChart(),
                )
                // color: red,
                )
          ],
        ),
      ),
    );

    // return const SafeArea(
    //   child: Padding(
    //     padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
    //     child: Column(
    //       children: [
    //         Text(
    //           'Transactions',
    //           style: TextStyle(fontSize: 20, color: black),
    //         ),
    //         SizedBox(
    //           height: 20,
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
