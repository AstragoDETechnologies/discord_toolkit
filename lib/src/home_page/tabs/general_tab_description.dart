import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabDescription extends StatelessWidget {
  final title;
  final description;
  const TabDescription(
      {Key? key, required String this.title, required List<TextSpan> this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Padding
        SizedBox(height: 15),
        // Title
        Text(
          title,
          style: GoogleFonts.mavenPro().copyWith(fontSize: 35, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        // Spacer / Padding
        SizedBox(
          height: 15,
        ),
        // Description
        Text.rich(
          TextSpan(
            style: GoogleFonts.openSans(),
            children: description,
          ),
          textAlign: TextAlign.center,
        ),
        // Padding
        SizedBox(height: 10),
      ],
    );
  }
}
