import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_tracker_flutter_course/app/home/models/job.dart';
import 'package:time_tracker_flutter_course/services/api_path.dart';

abstract class Database {
  Future<void> createJob(Job job);
}

class FireStoreDataBase implements Database {
  FireStoreDataBase({required this.uid}) : assert(uid != null);

  final String uid;

  Future<void> createJob(Job job) async {
    final path = APIPath.job(uid, 'job_abc');
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.set(job.toMap());
  }
}
