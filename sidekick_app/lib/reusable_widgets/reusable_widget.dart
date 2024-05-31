import 'package:flutter/material.dart';
import 'package:sidekick_app/utils/colours.dart';

// toast - placeholder for action buttons
class PopUpToast {
  static void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black,
          ),
        ),
        width: 250,
        backgroundColor: Colors.white,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black // Color of the dotted line
      ..strokeWidth = 1 // Width of the dotted line
      ..style = PaintingStyle.stroke;

    const double dotRadius = 0.5; // Radius of each dot
    const double dotSpace = 15; // Space between each dot

    double startX = 0;
    while (startX < size.width) {
      canvas.drawCircle(Offset(startX, 0), dotRadius, paint);
      startX += 2 * dotRadius + dotSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
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
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return Colors.black26;
            }
            return color;
          }),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
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
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return Colors.black26;
            }
            return color;
          }),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
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
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return Colors.black26;
            }
            return color;
          }),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
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
