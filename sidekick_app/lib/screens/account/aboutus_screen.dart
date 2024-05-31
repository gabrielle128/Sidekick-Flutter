import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/reusable_widgets/reusable_widget.dart';
import 'package:sidekick_app/utils/colours.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(
          color: black,
        ),
        backgroundColor: bgcolor,
        // elevation: 5,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.15, 20, 0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  logoWidget("assets/images/workada_logo.png", 100, 100),
                  const Text(
                    "Workada",
                    style: TextStyle(fontSize: 40),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Vision",
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Our vision is to be a leading software solution company in the technology sector and progress in our current position in the market. We want to be known as the technological industry's reliable, innovative, and user-friendly software service provider.",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Mission",
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Gin-Gineers is a standalone group of five computer engineering students. Exceed clients' expectations by going beyond software to provide the best web solutions that transform data into knowledge, enabling them to solve their problems.",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Developers",
                    style: TextStyle(fontSize: 25),
                  ),
                  const DeveloperRow(
                      developerName: 'Gabrielle Batralo',
                      imagePath: 'assets/images/elle.jpg'),
                  const DeveloperRow(
                      developerName: 'Dann Joseph Quisquino',
                      imagePath: 'assets/images/dann.jpg'),
                  const DeveloperRow(
                      developerName: 'John Paul Edit',
                      imagePath: 'assets/images/paul.jpg'),
                  const DeveloperRow(
                      developerName: 'Gabrielle Angelo Almazan',
                      imagePath: 'assets/images/gelo.jpg'),
                  const DeveloperRow(
                      developerName: 'Xypher Kelly Bumatay',
                      imagePath: 'assets/images/xypher.png'),
                ]),
          ),
        ),
      ),
    );
  }
}

class DeveloperRow extends StatelessWidget {
  const DeveloperRow(
      {super.key, required this.developerName, required this.imagePath});

  final String developerName;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 30,
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
            child: Text(
          developerName,
          style: const TextStyle(fontSize: 15),
        ))
      ]),
    );
  }
}
