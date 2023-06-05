import 'package:cloud_firestore/cloud_firestore.dart';

class Diary {
  final String? userid;
  final String? content;
  final String? contentGPT;
  final Timestamp? createdTime;
  final DocumentReference? reference;
  final String? imageURL;

  Diary({
    this.userid,
    this.content,
    this.contentGPT,
    this.createdTime,
    this.reference,
    this.imageURL,
  });
}
