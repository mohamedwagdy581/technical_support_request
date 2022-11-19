import 'package:flutter/material.dart';
import 'package:technical_requests/modules/all_requests/archived_requests/archived_requests_screen.dart';
import 'package:technical_requests/modules/all_requests/done_requests/done_requests_screen.dart';

import '../../shared/components/components.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100.0,),
            customCard(
              onTap: () {
                navigateTo(context, const DoneRequestsScreen());
              },
              title: 'Done Requests',
            ),
            customCard(
              onTap: () {
                navigateTo(context, const ArchivedRequestsScreen());
              },
              title: 'Archived Requests',
            ),
          ],
        ),
      ),
    );
  }
}
