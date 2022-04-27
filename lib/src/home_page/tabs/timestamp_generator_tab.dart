import 'package:flutter/material.dart';

import 'general_tab_description.dart';

class TimestampGeneratorTab extends StatefulWidget {
  const TimestampGeneratorTab({Key? key}) : super(key: key);

  @override
  State<TimestampGeneratorTab> createState() => _TimestampGeneratorTabState();
}

class _TimestampGeneratorTabState extends State<TimestampGeneratorTab> {
  String _dateAsText = "DATE";
  String _timeAsText = "TIME";

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
              double _minSize = 750;
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
                // Layout & Generate Btn
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Add Dropdown and Generate Button.
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
