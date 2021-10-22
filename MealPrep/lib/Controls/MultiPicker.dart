import 'package:flutter/material.dart';

class MultiPickerController {
  late List<String> currentOptions;

  MultiPickerController({List<String>? initialOptions}){
    if (initialOptions != null){
      currentOptions = initialOptions;
    }
    else{
      currentOptions = [];
    }
  }

}


class MultiPicker extends StatefulWidget{
  final List<String> options;
  final MultiPickerController controller;
  final double itemWidth;

  MultiPicker({required this.options, required this.controller, this.itemWidth = 100});
  
  @override
  State<StatefulWidget> createState() {
    return _MultiPickerState();
  }


}

class _MultiPickerState extends State<MultiPicker> {

  void onCheckBoxChanged(bool? newValue, String optionChanged){
    if (newValue == true){
      this.widget.controller.currentOptions.add(optionChanged);
    }
    else{
      this.widget.controller.currentOptions.remove(optionChanged);
    }

    setState(() {
      
    });
    
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> checkBoxes = [ ];

    for(var option in this.widget.options){
      bool isSelected = this.widget.controller.currentOptions.contains(option);

      checkBoxes.add(
        Container(width: this.widget.itemWidth,
          child: Row(children: [
          Checkbox(value: isSelected, onChanged: (bool? newValue){
              onCheckBoxChanged(newValue, option);
            }
          ),
          Text(option)
          ])
        )
      );
    }

    return Container(
      child: Wrap(
        children: checkBoxes,
      )
    );

  }
}