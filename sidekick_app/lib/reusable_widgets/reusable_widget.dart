import 'package:flutter/material.dart';
import 'package:sidekick_app/utils/colours.dart';

// logo
Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 200,
    height: 200,
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
