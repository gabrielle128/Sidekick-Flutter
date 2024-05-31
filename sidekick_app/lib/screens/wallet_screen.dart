import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/screens/wallet/add_expense.dart';
import 'package:sidekick_app/screens/wallet/data.dart';
import 'package:sidekick_app/screens/wallet/stat_screen.dart';
import 'package:sidekick_app/utils/colours.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 30, 0),
              child: IconButton(
                icon: const Icon(
                  Icons.analytics_outlined, // stats icon
                  color: black,
                  size: 40,
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StatScreen() // stats screen
                        )),
              ))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 34.0),
            const Center(
              child: Text(
                "Budget Tracker",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: double.infinity,
              height: 1,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: CustomPaint(
                painter: DottedLinePainter(),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2.5,
              decoration: BoxDecoration(
                  color: moss,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(blurRadius: 4, color: grey, offset: Offset(3, 3))
                  ]),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      'Total Balance',
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(height: 5),
                    Text('₱ 500.00', style: TextStyle(fontSize: 35)),
                    // SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    color: Colors.white30,
                                    shape: BoxShape.circle),
                                child: const Center(
                                  child: Icon(
                                    CupertinoIcons.arrow_down,
                                    size: 12,
                                    color: black,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Income',
                                      style: TextStyle(fontSize: 20)),
                                  Text('₱ 2,500.00',
                                      style: TextStyle(fontSize: 16)),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    color: Colors.white30,
                                    shape: BoxShape.circle),
                                child: const Center(
                                  child: Icon(
                                    CupertinoIcons.arrow_down,
                                    size: 12,
                                    color: red,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Expenses',
                                      style: TextStyle(fontSize: 20)),
                                  Text('₱ 1,500.00',
                                      style: TextStyle(fontSize: 20)),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transactions',
                  style: TextStyle(fontSize: 20, color: black),
                ),
                GestureDetector(
                    onTap: () {
                      // add functionality
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(fontSize: 20, color: grey),
                    )),
              ],
            ),
            const SizedBox(height: 20.0),
            Expanded(
                child: ListView.builder(
                    itemCount: walletData.length,
                    itemBuilder: (context, int i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: walletData[i]['color'],
                                                shape: BoxShape.circle),
                                          ),
                                          walletData[i]['icon']
                                          // Icon(
                                          //   Icons.food_bank,
                                          //   color: white,
                                          // )
                                        ],
                                      ),
                                      SizedBox(width: 12),
                                      Text(walletData[i]['name'],
                                          style: TextStyle(
                                              fontSize: 20, color: black)),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(walletData[i]['totalAmount'],
                                          style: TextStyle(
                                              fontSize: 16, color: black)),
                                      Text(walletData[i]['date'],
                                          style: TextStyle(
                                              fontSize: 16, color: grey)),
                                    ],
                                  )
                                ]),
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: black,
        backgroundColor: yellow,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddExpense();
            },
          );
        },
        child: const Icon(Icons.add),
        shape: const CircleBorder(),
      ),
    );
  }

  // void getUser() {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     userId = user.uid;
  //     userEmail = user.email!;
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getUser();
  // }
}
