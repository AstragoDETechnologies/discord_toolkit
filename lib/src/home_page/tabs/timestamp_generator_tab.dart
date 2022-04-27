import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:clipboard/clipboard.dart';

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
  String _dateAsText = "- no date selected -";
  String _timeAsText = "- no time selected -";
  String _output = "";
  String _formattedOutput = "";

  int _selectedSeconds = 0;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  var _dropdownValue = MsgTypes.relative;

  TextEditingController _secondsTextEditingController = TextEditingController();

  void updateText() {
    if (_selectedDate != null) {
      setState(() {
        _dateAsText = DateFormat("EEEE, dd.MM.yyyy").format(_selectedDate!);
      });
    }
    if (_selectedTime != null) {
      TimeOfDay t = _selectedTime!;
      final now = new DateTime.now();
      DateTime _selectedTimeAsDateTime = DateTime(now.year, now.month, now.day, t.hour, t.minute);
      setState(() {
        _timeAsText = DateFormat("HH:mm").format(_selectedTimeAsDateTime);
      });
    }
    if (_selectedDate != null && _selectedTime != null) {
      generateOutput();
    }
  }

  void generateOutput() {
    var _calculatedDate = calculateTimeSum();
    double _calculatedUnix = _calculatedDate.millisecondsSinceEpoch / 1000;
    print(_calculatedUnix);
    if (_dropdownValue == MsgTypes.relative) {
      setState(() {
        _output = "<t:" + _calculatedUnix.toString() + ":R>";
        _formattedOutput = Jiffy(_calculatedDate).fromNow();
      });
    }
    if (_dropdownValue == MsgTypes.shortTime) {
      setState(() {
        _output = "<t:" + _calculatedUnix.toString() + ":t>";
        _formattedOutput = DateFormat("H:mm a").format(_calculatedDate);
      });
    }
    if (_dropdownValue == MsgTypes.longTime) {
      setState(() {
        _output = "<t:" + _calculatedUnix.toString() + ":T>";
        _formattedOutput = DateFormat("H:mm:ss a").format(_calculatedDate);
      });
    }
    if (_dropdownValue == MsgTypes.shortDate) {
      setState(() {
        _output = "<t:" + _calculatedUnix.toString() + ":d>";
        _formattedOutput = DateFormat("M/dd/yy").format(_calculatedDate);
      });
    }
    if (_dropdownValue == MsgTypes.longDate) {
      setState(() {
        _output = "<t:" + _calculatedUnix.toString() + ":D>";
        _formattedOutput = DateFormat("MMMM dd, yyyy").format(_calculatedDate);
      });
    }
    if (_dropdownValue == MsgTypes.longDateWithShortTime) {
      setState(() {
        _output = "<t:" + _calculatedUnix.toString() + ":f>";
        _formattedOutput = DateFormat("MMMM dd, yyyy").format(_calculatedDate) +
            " at " +
            DateFormat("H:mm a").format(_calculatedDate);
      });
    }
    if (_dropdownValue == MsgTypes.longDateWithDayOfWeekAndShortTime) {
      setState(() {
        _output = "<t:" + _calculatedUnix.toString() + ":F>";
        _formattedOutput = DateFormat("EEEE, MMMM dd, yyyy").format(_calculatedDate) +
            " at " +
            DateFormat("H:mm a").format(_calculatedDate);
      });
    }
  }

  DateTime calculateTimeSum() {
    TimeOfDay t = _selectedTime!;
    DateTime _sum = DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day, t.hour,
        t.minute, _selectedSeconds);
    print(_sum);
    print(_secondsTextEditingController.text);
    print(_selectedSeconds);
    return _sum;
  }

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
                            onPressed: () {
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
                              );
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
                            onPressed: () {
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
                              );
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
                // Seconds Field
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Seconds: ",
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: SizedBox(
                          width: 150,
                          child: TextField(
                            autocorrect: false,
                            textAlign: TextAlign.start,
                            controller: _secondsTextEditingController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Seconds',
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(2),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (v) {
                              if (v != "") {
                                if (int.parse(v) >= 60) {
                                  _secondsTextEditingController.text = "59";
                                }
                                _selectedSeconds = int.parse(_secondsTextEditingController.text);
                              } else {
                                _selectedSeconds = 0;
                              }
                              updateText();
                            },
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
                          value: _dropdownValue,
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
                              _dropdownValue = newValue ?? MsgTypes.relative;
                            });
                            updateText();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Spacer
                SizedBox(height: 50),
                //Generated Text
                GestureDetector(
                  onTap: () {
                    FlutterClipboard.copy(_output);
                  },
                  child: Text(
                    _output,
                    style: GoogleFonts.sourceCodePro().copyWith(fontSize: 50),
                  ),
                ),
                // Spacer
                SizedBox(height: 10),
                // Generated Readable Text
                Text(_formattedOutput)
              ],
            ),
          )
        ],
      ),
    );
  }
}
