import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:holydiary/controller/user_controller.dart';
import 'package:holydiary/model/diary.dart';
import 'package:intl/intl.dart'; // For date formatting

class DiaryController extends GetxController {
  RxList<Diary> diaryList = RxList<Diary>([]);
  RxList<Diary> diaryMonthList = RxList<Diary>([]);
  RxList<Diary> todayDiary = RxList<Diary>([]);
  RxString pickedImagePath = "".obs;
  UserController userController = Get.put(UserController());

  FirebaseStorage storage = FirebaseStorage.instance;
  CollectionReference diaryCollection =
      FirebaseFirestore.instance.collection("diary");

  @override
  void dispose() {
    Get.delete<DiaryController>();
    super.dispose();
  }

  void changePickedImagePath(String path) {
    pickedImagePath.value = path;
  }

  void getdiaryMonthList(DateTime targetDate) {
    diaryMonthList.value = diaryList
        .where((diary) =>
            diary.createdTime!.toDate().year == targetDate.year &&
            diary.createdTime!.toDate().month == targetDate.month)
        .toList();
    print("diaryMonthList.length");
    print(diaryMonthList.length);
    if (diaryMonthList.length == 0) {
      diaryMonthList.value = RxList<Diary>([]);
    }
    return;
  }

  void gettodayDiary(DateTime thisDay) {
    List<Diary> todaysDiaries = [];
    Timestamp thisdayTimestamp = Timestamp.fromDate(thisDay);
    for (Diary diary in diaryList) {
      if (checkSameDay(diary.createdTime!, thisdayTimestamp)) {
        todaysDiaries.add(diary);
      }
    }
    Future.delayed(Duration(milliseconds: 100), () {
      todayDiary.value = todaysDiaries;
    });
  }

  void onInit() {
    super.onInit();
    diaryCollection.snapshots().listen((QuerySnapshot snapshot) {
      diaryList.value = snapshot.docs
          .map((doc) => Diary(
                userid: doc['userid'],
                content: doc['content'],
                contentGPT: doc['contentGPT'],
                createdTime: doc['createdTime'],
                reference: doc['reference'],
                imageURL: doc['imageURL'],
              ))
          .toList();
    });
  }

  Future<void> addDiary(Diary diary) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = storage.ref().child('images/$imageName.jpg');
    UploadTask uploadTask = ref.putFile(File(pickedImagePath.value));

    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
    String downloadUrl = await snapshot.ref.getDownloadURL();

    DocumentReference reference = diaryCollection.doc();
    await reference.set({
      'userid': userId,
      'content': userController.textController.text,
      'contentGPT': diary.contentGPT,
      'createdTime': FieldValue.serverTimestamp(),
      'imageURL': downloadUrl,
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

  bool checkSameDay(Timestamp timestamp1, Timestamp timestamp2) {
    DateTime date1 = timestamp1.toDate();
    DateTime date2 = timestamp2.toDate();
    print(date1.toString());
    print(date2.toString());

    bool isSameDay = date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;

    if (isSameDay) {
      print('The timestamps have the same day.');
      return true;
    } else {
      print('The timestamps have different days.');
      return false;
    }
  }

  bool checkSameMonth(Timestamp timestamp1, DateTime date1) {
    DateTime date2 = timestamp1.toDate();

    bool isSameMonth = date1.year == date2.year && date1.month == date2.month;

    if (isSameMonth) {
      print('The timestamps have the same month.');
      return true;
    } else {
      print('The timestamps have different months.');
      return false;
    }
  }
}
