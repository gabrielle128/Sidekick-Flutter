import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sidekick_app/utils/colours.dart';

// toast - placeholder for action buttons
Future showToast(String message) async {
  await Fluttertoast.cancel();

  Fluttertoast.showToast(msg: message, fontSize: 15);
}

// logo
Image logoWidget(String imageName, double width, double height) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: width,
    height: height,
    color: black,
  );
}

// login text field
Padding reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: TextField(
      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      cursorColor: black,
      textInputAction: TextInputAction.done,
      style: const TextStyle(color: black),
      decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.grey,
          ),
          labelText: text,
          labelStyle: TextStyle(color: grey.withOpacity(0.9)),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Colors.white.withOpacity(0.3),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none))),
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    ),
  );
}

// sign up text field
Padding reusableFormField(
  TextEditingController controller,
  bool isPasswordType,
  IconData icon,
  String label,
  String? Function(String?) validator,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: TextFormField(
      controller: controller,
      cursorColor: black,
      textInputAction: TextInputAction.next,
      obscureText: isPasswordType,
      decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.grey,
          ),
          labelText: label,
          labelStyle: TextStyle(color: grey.withOpacity(0.9)),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Colors.white.withOpacity(0.3),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none))),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    ),
  );
}

// login sign up button
Container loginSignupButton(
    BuildContext context, Color color, String text, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return color;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Text(
        text,
        style: const TextStyle(color: black, fontSize: 20),
      ),
    ),
  );
}

Container accountButton(BuildContext context, Color color, IconData icon,
    String text, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.6,
    height: 40,
    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return color;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: black,
          ),
          const SizedBox(
            width: 30,
          ),
          Text(
            text,
            style: const TextStyle(color: black, fontSize: 20),
          ),
        ],
      ),
      // child: Text(
      //   text,
      //   style: const TextStyle(color: black, fontSize: 20),
      // ),
    ),
  );
}

Container adminButton(
    BuildContext context, Color color, String text, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.7,
    height: 80,
    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return color;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: const TextStyle(color: black, fontSize: 25),
          ),
        ],
      ),
      // child: Text(
      //   text,
      //   style: const TextStyle(color: black, fontSize: 20),
      // ),
    ),
  );
}
