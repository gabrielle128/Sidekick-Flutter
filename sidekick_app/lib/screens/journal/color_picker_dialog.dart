import 'package:flutter/material.dart';
import 'package:sidekick_app/utils/sidekick_icons_icons.dart';
import 'package:sidekick_app/utils/colours.dart';

class CustomBlockPicker extends StatefulWidget {
  final Color pickerColor;
  final List<Color> availableColors;
  final ValueChanged<Color> onColorChanged;

  const CustomBlockPicker({
    required this.pickerColor,
    required this.availableColors,
    required this.onColorChanged,
    Key? key,
  }) : super(key: key);

  @override
  _CustomBlockPickerState createState() => _CustomBlockPickerState();
}

class _CustomBlockPickerState extends State<CustomBlockPicker> {
  late Color selectedColor;

  @override
  void initState() {
    selectedColor = widget.pickerColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: widget.availableColors.map((Color color) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedColor = color;
              });
              widget.onColorChanged(color);
            },
            child: Container(
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selectedColor == color ? Colors.black : Colors.black,
                  width: 1.0,
                ),
              ),
              width: 50.0,
              height: 50.0,
              child: selectedColor == color
                  ? Icon(Icons.check, color: Colors.black)
                  : null,
            ),
          );
        }).toList(),
      ),
    );
  }
}

Future<void> showColorPickerDialog(BuildContext context, Color pickerColor,
    ValueChanged<Color> onColorChanged) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: const Text(
                  'Pick a color!',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              CustomBlockPicker(
                pickerColor: pickerColor, // default color
                availableColors: const [
                  color1,
                  color2,
                  color3,
                  color4,
                  color5,
                  color6,
                  color7,
                  color8,
                  color9,
                  color10,
                  color11,
                  color12,
                  color13,
                  color14,
                  color15,
                  color16,
                ],
                onColorChanged: onColorChanged,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(SidekickIcons.save),
            color: Colors.black,
            onPressed: () async {
              Navigator.of(context).pop(); // Dismiss the color picker
            },
          ),
          // ElevatedButton(
          //   child: const Text('DONE'),
          //   onPressed: () {
          //     Navigator.of(context).pop(); // Dismiss the color picker
          //   },
          // ),
        ],
      );
    },
  );
}
