import 'package:flutter/material.dart';

class TimestampGeneratorTab extends StatelessWidget {
  const TimestampGeneratorTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Timestamp Generator"),
          ],
        ),
      ),
    );
  }
}
