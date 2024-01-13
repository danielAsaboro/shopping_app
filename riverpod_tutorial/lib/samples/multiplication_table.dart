import 'package:flutter/material.dart';

class MultiplicationTable extends StatefulWidget {
  const MultiplicationTable({Key? key}) : super(key: key);

  @override
  State<MultiplicationTable> createState() => _MultiplicationTableState();
}

class _MultiplicationTableState extends State<MultiplicationTable> {
  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];

    for (int i = 1; i <= 12; i++) {
      List<Widget> rowChildren = [];

      for (int j = 1; j <= 12; j++) {
        int product = i * j;
        rowChildren.add(
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Text("$i x $j = $product"),
          ),
        );
      }

      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rowChildren,
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: rows,
        ),
      ),
    );
  }
}
