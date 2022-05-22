import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clipboard/clipboard.dart';

import 'general_tab_description.dart';

class ProfileLinkGenerator extends StatefulWidget {
  const ProfileLinkGenerator({Key? key}) : super(key: key);

  @override
  State<ProfileLinkGenerator> createState() => _ProfileLinkGeneratorState();
}

class _ProfileLinkGeneratorState extends State<ProfileLinkGenerator> {
  TextEditingController _userIDTextEditingController = TextEditingController();
  String _output = "";
  String _previewText = "";

  void _generateOutput() {
    setState(() {
      _output = "https://discordapp.com/users/${_userIDTextEditingController.text}";
    });
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
            title: "Proflile Link Generator",
            description: [
              TextSpan(text: "Generate a link to your Discord profile.\n"),
            ],
          ),
          // Padding
          SizedBox(height: 40),
          // Rows
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 850),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Seconds Field
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "User ID: ",
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: SizedBox(
                          width: 200,
                          child: TextField(
                            autocorrect: false,
                            textAlign: TextAlign.start,
                            controller: _userIDTextEditingController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'User ID',
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(18),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (v) {
                              _generateOutput();
                            },
                          ),
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
                              .copyWith(fontSize: (_size.width / 32 > 28) ? 28 : _size.width / 32),
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
                      }),
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
