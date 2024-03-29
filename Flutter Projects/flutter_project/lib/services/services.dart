import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class Database{
  Future<void> createJob(Map<String, dynamic> jobData);
}

class FirestoreDatabase implements Database{
  FirestoreDatabase({required this.uid});
  final String uid;

  Future<void> createJob(Map<String, dynamic> jobData) async {
    final path = '/users/$uid/jobs/job_abc';
    final documentRefrence = FirebaseFirestore.instance.doc(path);
    await documentRefrence.set(jobData);
  }
}