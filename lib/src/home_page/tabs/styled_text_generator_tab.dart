import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

class StyledTextGeneratorTab extends StatelessWidget {
  const StyledTextGeneratorTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // START: Coming Soon Snippit
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Coming Soon",
              style: GoogleFonts.amaticSc().copyWith(
                fontSize: 70,
                fontWeight: FontWeight.bold,
              ),
            ),
            AutoSizeText(
              "implementation might take several Weeks.\n(Development is delayed due to Klausurenphase)",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: GoogleFonts.amaticSc().copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      // END: Coming Soon Snippit
    );
  }
}
