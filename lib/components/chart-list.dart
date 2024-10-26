import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

class ChartList extends StatefulWidget {
  List<String> options;
  
  ChartList({super.key, required this.options});

  @override
  State<ChartList> createState() => _ChartListState();
}

class _ChartListState extends State<ChartList> {
  List<String> tags=[];
  
  @override
  Widget build(BuildContext context) {
    return ChipsChoice<String>.multiple(
      value: tags, 
      onChanged: (val)=>setState(()=>tags=val),
      choiceItems:C2Choice.listFrom(
      source: widget.options, value:(i,v)=>v, label: (i,v)=>v),
      
      );
  }
}