import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Database {
  Future<void> createJob(Map<String, dynamic> jobData);
}

class FireStoreDataBase implements Database {
  FireStoreDataBase({required this.uid}) : assert(uid != null);

  final String uid;

  Future<void> createJob(Map<String, dynamic> jobData) async {
    final path = '/users/$uid/jobs/job_abc';
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.set(jobData);
  }
}
