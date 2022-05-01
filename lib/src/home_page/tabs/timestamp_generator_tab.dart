import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:clipboard/clipboard.dart';

import 'general_tab_description.dart';

enum MsgStyles {
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
  String _previewText = "";

  int _selectedSeconds = 0;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  var _dropdownValue = MsgStyles.relative;

  TextEditingController _secondsTextEditingController = TextEditingController();

  // Update the displayed Texts.
  void _updateText() {
    // Update Date Test
    if (_selectedDate != null) {
      setState(() {
        _dateAsText = DateFormat("EEEE, dd.MM.yyyy").format(_selectedDate!);
      });
    }
    // Update Time Text
    if (_selectedTime != null) {
      TimeOfDay t = _selectedTime!;
      final now = new DateTime.now();
      DateTime _selectedTimeAsDateTime = DateTime(now.year, now.month, now.day, t.hour, t.minute);
      setState(() {
        _timeAsText = DateFormat("HH:mm").format(_selectedTimeAsDateTime);
      });
    }
    // Generate the output, if both Date and Time are selected
    if (_selectedDate != null && _selectedTime != null) {
      _generateOutput();
    }
  }

  // Generate and Display the output
  void _generateOutput() {
    // Get the selected DateTime
    var _calculatedDate = _calculateTimeSum();
    // Calculate The Unix-Time in Seconds
    double _calculatedUnix = _calculatedDate.millisecondsSinceEpoch / 1000;
    // Calculate the Output and Preview for the selected Option
    if (_dropdownValue == MsgStyles.relative) {
      setState(() {
        _output = "<t:" + _calculatedUnix.toString() + ":R>";
        _previewText = Jiffy(_calculatedDate).fromNow();
      });
    }
    if (_dropdownValue == MsgStyles.shortTime) {
      setState(() {
        _output = "<t:" + _calculatedUnix.toString() + ":t>";
        _previewText = DateFormat("H:mm a").format(_calculatedDate);
      });
    }
    if (_dropdownValue == MsgStyles.longTime) {
      setState(() {
        _output = "<t:" + _calculatedUnix.toString() + ":T>";
        _previewText = DateFormat("H:mm:ss a").format(_calculatedDate);
      });
    }
    if (_dropdownValue == MsgStyles.shortDate) {
      setState(() {
        _output = "<t:" + _calculatedUnix.toString() + ":d>";
        _previewText = DateFormat("M/dd/yy").format(_calculatedDate);
      });
    }
    if (_dropdownValue == MsgStyles.longDate) {
      setState(() {
        _output = "<t:" + _calculatedUnix.toString() + ":D>";
        _previewText = DateFormat("MMMM dd, yyyy").format(_calculatedDate);
      });
    }
    if (_dropdownValue == MsgStyles.longDateWithShortTime) {
      setState(() {
        _output = "<t:" + _calculatedUnix.toString() + ":f>";
        _previewText = DateFormat("MMMM dd, yyyy").format(_calculatedDate) +
            " " +
            DateFormat("H:mm a").format(_calculatedDate);
      });
    }
    if (_dropdownValue == MsgStyles.longDateWithDayOfWeekAndShortTime) {
      setState(() {
        _output = "<t:" + _calculatedUnix.toString() + ":F>";
        _previewText = DateFormat("EEEE, MMMM dd, yyyy").format(_calculatedDate) +
            " " +
            DateFormat("H:mm a").format(_calculatedDate);
      });
    }
  }

  // Convert the selected Date into a DateTime object and return it.
  DateTime _calculateTimeSum() {
    TimeOfDay t = _selectedTime!;
    DateTime _sum = DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day, t.hour,
        t.minute, _selectedSeconds);
    return _sum;
  }

  // Copy the Text of the output to the clipboard
  void _copyOutputToClipboard() {
    FlutterClipboard.copy(_output).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("String copied to clipboard"),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
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
              TextSpan(text: "Generate Timestamps of various styles to put in your Messages."),
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
                                lastDate: DateTime(5999, 12, 31),
                              ).then(
                                (pickedDate) {
                                  if (pickedDate != null) {
                                    _selectedDate = pickedDate;
                                    _updateText();
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
                                    _selectedTime = pickedTime;
                                    _updateText();
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
                              _updateText();
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
                        "Style: ",
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: DropdownButton(
                          value: _dropdownValue,
                          items: [
                            DropdownMenuItem(
                              child: Text("relative"),
                              value: MsgStyles.relative,
                            ),
                            DropdownMenuItem(
                              child: Text("short time"),
                              value: MsgStyles.shortTime,
                            ),
                            DropdownMenuItem(
                              child: Text("long time"),
                              value: MsgStyles.longTime,
                            ),
                            DropdownMenuItem(
                              child: Text("short date"),
                              value: MsgStyles.shortDate,
                            ),
                            DropdownMenuItem(
                              child: Text("long date"),
                              value: MsgStyles.longDate,
                            ),
                            DropdownMenuItem(
                              child: Text("long date with short time"),
                              value: MsgStyles.longDateWithShortTime,
                            ),
                            DropdownMenuItem(
                              child: Text("long date with day of week and short time"),
                              value: MsgStyles.longDateWithDayOfWeekAndShortTime,
                            ),
                          ],
                          onChanged: (MsgStyles? newValue) {
                            setState(() {
                              _dropdownValue = newValue ?? MsgStyles.relative;
                            });
                            _updateText();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Spacer
                SizedBox(height: 50),
                //Generated Text
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Text
                      GestureDetector(
                        onTap: _copyOutputToClipboard,
                        child: Text(
                          _output,
                          style: GoogleFonts.sourceCodePro()
                              .copyWith(fontSize: (_size.width / 13 > 60) ? 60 : _size.width / 13),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // Button
                      Builder(builder: (context) {
                        if (_output != "") {
                          return IconButton(
                            onPressed: _copyOutputToClipboard,
                            icon: Icon(Icons.copy),
                          );
                        } else {
                          // Dummy Item
                          return SizedBox();
                        }
                      })
                    ],
                  ),
                ),

                // Spacer
                SizedBox(height: 10),
                // Generated Readable Text
                Text(
                  _previewText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans()
                      .copyWith(fontSize: (_size.width / 32 > 16) ? 16 : _size.width / 32),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
