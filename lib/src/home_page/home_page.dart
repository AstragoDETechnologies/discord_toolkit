import 'package:flutter/material.dart';

import 'tabs/timestamp_generator_tab.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text("Discord Toolkit"),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.schedule),
                text: "Timestamp Generator",
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                showAboutDialog(
                    context: context,
                    applicationLegalese:
                        "This application was NOT developed by Discord. Discord is a registered Trademark.");
              },
              icon: Icon(Icons.info_outline),
              tooltip: "Information",
            ),
          ],
        ),
        body: TabBarView(
          children: [
            TimestampGeneratorTab(),
          ],
        ),
      ),
    );
  }
}
