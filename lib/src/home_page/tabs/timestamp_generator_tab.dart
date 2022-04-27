import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  String _dateAsText = "- no time selected -";
  String _timeAsText = "- no date selected -";

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  var dropdownValue = MsgTypes.relative;

  void updateText() {
    if (_selectedDate != null) {
      setState(() {
        _dateAsText = DateFormat("EEEE, dd.MM.yyyy").format(_selectedDate!);
      });
    }
    if (_selectedTime != null) {
      TimeOfDay t = _selectedTime!;
      final now = new DateTime.now();
      DateTime _selectedTimeAsText = DateTime(now.year, now.month, now.day, t.hour, t.minute);
      setState(() {
        _timeAsText = DateFormat("HH:mm").format(_selectedTimeAsText);
      });
    }
    if (_selectedDate != null && _selectedTime != null) {
      generateOutput();
    }
  }

  void generateOutput() {}

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
                        "Date: $_dateAsText",
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () => {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(0),
                                lastDate: DateTime(2999, 12, 31),
                              ).then(
                                (pickedDate) {
                                  if (pickedDate != null) {
                                    print("Date Picked!");
                                    print(pickedDate);
                                    _selectedDate = pickedDate;
                                    updateText();
                                  }
                                },
                              ),
                            },
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
                        "Time: $_timeAsText",
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () => {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then(
                                (pickedTime) {
                                  if (pickedTime != null) {
                                    print("Time Picked!");
                                    print(pickedTime);
                                    _selectedTime = pickedTime;
                                    updateText();
                                  }
                                },
                              ),
                            },
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
                // Dropdown
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Message type: ",
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: DropdownButton(
                          value: dropdownValue,
                          items: [
                            DropdownMenuItem(
                              child: Text("relative"),
                              value: MsgTypes.relative,
                            ),
                            DropdownMenuItem(
                              child: Text("short time"),
                              value: MsgTypes.shortTime,
                            ),
                            DropdownMenuItem(
                              child: Text("long time"),
                              value: MsgTypes.longTime,
                            ),
                            DropdownMenuItem(
                              child: Text("short date"),
                              value: MsgTypes.shortDate,
                            ),
                            DropdownMenuItem(
                              child: Text("long date"),
                              value: MsgTypes.longDate,
                            ),
                            DropdownMenuItem(
                              child: Text("long date with short time"),
                              value: MsgTypes.longDateWithShortTime,
                            ),
                            DropdownMenuItem(
                              child: Text("long date with day of week and short time"),
                              value: MsgTypes.longDateWithDayOfWeekAndShortTime,
                            ),
                          ],
                          onChanged: (MsgTypes? newValue) {
                            setState(() {
                              dropdownValue = newValue ?? MsgTypes.relative;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
