import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  String inputText;
   Loading({super.key, required this.inputText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      actionsAlignment: MainAxisAlignment.center,
      
      actions: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(strokeWidth: 2,color: Colors.green),
              SizedBox(width: 20,),
              Text(inputText, style: TextStyle(fontSize: 18, color: Colors.white),),
            ],
          ),
        )
      ],
    );
  }
}

class ShowDialog extends StatelessWidget {
  const ShowDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(),);
  }


  static Future<void> show(BuildContext context, String dialogToShow){
    return showDialog(context: context, builder: (context)=>Loading(inputText: dialogToShow));
  }
}

