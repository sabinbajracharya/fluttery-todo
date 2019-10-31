import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';

import 'package:todo/utils/color_utils.dart';

class ColorPickerBuilder extends StatelessWidget {
  final Color color;
  final ValueChanged<Color> onColorChanged;

  ColorPickerBuilder({@required this.color, @required this.onColorChanged});

  @override
  Widget build(BuildContext context) {
    //https://stackoverflow.com/questions/45424621/inkwell-not-showing-ripple-effect
    return ClipOval(
      child: Container(
        height: 32.0,
        width: 32.0,
        child: Material(
          color: color,
          child: InkWell(
            borderRadius: BorderRadius.circular(50.0),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Select a color'),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        availableColors: ColorUtils.defaultColors,
                        pickerColor: color,
                        onColorChanged: onColorChanged,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}