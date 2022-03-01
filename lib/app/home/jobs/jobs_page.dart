import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/empty_content.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/job_list_tiles.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/list_items_builder.dart';
import 'package:time_tracker_flutter_course/app/home/models/job.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/database.dart';

import '../../../services/auth.dart';
import 'edit_job_page.dart';

class JobsPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    );
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  void _createJob(BuildContext context) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.setJob(Job(name: 'Blogging', ratePerHour: 10));
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context, title: 'Operation failed', exception: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        //onPressed: () => _createJob(context),
        onPressed: () => EditJobPage.show(context),
        child: Icon(Icons.add),
      ),
      body: _buildContents(context),
    );
  }

  _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final jobs = snapshot.data;
          return ListItemsBuilder<Job>(
            snapshot: snapshot,
            itemBuilder: (context, job) =>
                JobListTile(job: job, onTap: () => EditJobPage.show(context, job: job)),
          );
          // if (jobs!.isNotEmpty) {
          //   final children = jobs
          //       .map((job) => JobListTile(
          //             job: job!,
          //             onTap: () => EditJobPage.show(context, job: job),
          //           ))
          //       .toList();
          //   return ListView(children: children);
          // }
          // return EmptyContent();
        }
        if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
