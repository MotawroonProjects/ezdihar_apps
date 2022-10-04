import 'package:flutter/material.dart';

import '../widgets/tab_title_widget.dart';

class ProviderOrdersScreen extends StatelessWidget {
  const ProviderOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
      ),
      body: Column(
        children: [
          Row(
            children: [
            TabTitleWidget(text:"New" ,index: 0,),
            TabTitleWidget(text:"current" ,index: 1,),
            TabTitleWidget(text:"Completed" ,index: 2,),
            TabTitleWidget(text:"Refused" ,index: 3,),
          ],)
        ],
      ),
    );
  }
}
