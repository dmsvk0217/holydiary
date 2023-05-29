import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:holydiary/model/diary.dart';

class DiaryController extends GetxController {
  RxList<Diary> diaryList = RxList<Diary>([]);
  final db = FirebaseFirestore.instance.collection("diary");

  void onInit() {
    super.onInit();
    db.snapshots().listen((QuerySnapshot snapshot) {
      diaryList.value = snapshot.docs
          .map((doc) => Diary(
                userid: doc['userid'],
                content: doc['content'],
                contentGPT: doc['contentGPT'],
                createdTime: doc['createdTime'],
                reference: doc['reference'],
              ))
          .toList();
    });
  }

  Future<void> addDiary(Diary diary) async {
    print("[adddiary] start");
    print("[adddiary]1 $diary");

    // final userId = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference reference = db.doc();

    await reference.set({
      'userid': "diary.userid",
      'content': diary.content,
      'contentGPT': diary.contentGPT,
      'createdTime': FieldValue.serverTimestamp(),
      "reference": reference,
    });
    print("[adddiary] done");
  }

  Future<void> updatediary(Diary diary) async {
    final reference = diary.reference;
    final updates = <String, dynamic>{
      'userid': diary.userid,
      'content': diary.content,
      'contentGPT': diary.contentGPT,
    };

    reference!.update(updates).then(
        (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

  Future<void> deleteDiary(Diary diary) async {
    await diary.reference!.delete();
  }
}
