import 'package:flutter/material.dart';

class SinglePickerController {
  late String? currentOption;

  SinglePickerController({String? initialOption}){
    currentOption = initialOption;
  }
}


class SinglePicker extends StatefulWidget{
  final List<String> options;
  final SinglePickerController controller;
  final double itemWidth;

  SinglePicker({required this.options, required this.controller, this.itemWidth = 100});
  
  @override
  State<StatefulWidget> createState() {
    return _SinglePickerState();
  }
}

class _SinglePickerState extends State<SinglePicker> {

  void onCheckBoxChanged(String? newValue){
    setState(() { 
      this.widget.controller.currentOption = newValue;
    });    
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> radios = [ ];

    for(var option in this.widget.options){
      radios.add(
        Container(width: this.widget.itemWidth,
          child: Row(children: [
          Radio<String>(value: option, toggleable: true, groupValue: this.widget.controller.currentOption, 
            onChanged: onCheckBoxChanged
          ),
          Text(option)
          ])
        )
      );
    }

    return Container(
      child: Wrap(
        children: radios,
      )
    );

  }
}