import 'package:flutter/material.dart';

import 'general_tab_description.dart';

enum MsgTypes {
  relative,
  shortTime,
  longTime,
  shortDate,
  longDate,
  longDateWithShortTime,
  longDateWithDayOfWeekAndShortTime,
}

class TimestampGeneratorTab extends StatefulWidget {
  const TimestampGeneratorTab({Key? key}) : super(key: key);

  @override
  State<TimestampGeneratorTab> createState() => _TimestampGeneratorTabState();
}

class _TimestampGeneratorTabState extends State<TimestampGeneratorTab> {
  String _dateAsText = "DATE";
  String _timeAsText = "TIME";

  var dropdownValue = MsgTypes.relative;

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title and Description
          TabDescription(
            title: "Timestamp Generator",
            description: [
              TextSpan(text: "Generate Timestamps of various types to put in your Messages."),
            ],
          ),
          // Padding
          SizedBox(height: 40),
          // Rows
          SizedBox(
            width: () {
              double _minSize = 850;
              double _devisor = 1.1;
              // If the width is bigger than _minSize / _devisor, display the _minSize / _devisor.
              // Else, display the ScreenSize / the devisor
              // --> Create a section with a maximum width.
              if (_size.width / _devisor > _minSize / _devisor) {
                return _minSize / _devisor;
              } else {
                return _size.width / _devisor;
              }
            }(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Date BTN
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "$_dateAsText",
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () => {},
                            child: Text("Select Date"),
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Time Btn
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "$_timeAsText",
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () => {},
                            child: Text("Select Time"),
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Padding
                SizedBox(height: 50),
                // Layout & Generate Btn
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DropdownButton(
                      value: dropdownValue,
                      items: [
                        DropdownMenuItem(
                          child: Text("Relative"),
                          value: MsgTypes.relative,
                        ),
                        DropdownMenuItem(
                          child: Text("short Time"),
                          value: MsgTypes.shortTime,
                        ),
                        DropdownMenuItem(
                          child: Text("long Time"),
                          value: MsgTypes.longTime,
                        ),
                        DropdownMenuItem(
                          child: Text("short Date"),
                          value: MsgTypes.shortDate,
                        ),
                        DropdownMenuItem(
                          child: Text("long Date"),
                          value: MsgTypes.longDate,
                        ),
                        DropdownMenuItem(
                          child: Text("long Date with short Time"),
                          value: MsgTypes.longDateWithShortTime,
                        ),
                        DropdownMenuItem(
                          child: Text("long Date with day of week and short Time"),
                          value: MsgTypes.longDateWithDayOfWeekAndShortTime,
                        ),
                      ],
                      onChanged: (MsgTypes? newValue) {
                        print(newValue);
                        setState(() {
                          dropdownValue = newValue ?? MsgTypes.relative;
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Generate"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
