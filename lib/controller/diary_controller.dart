import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:holydiary/model/diary.dart';
import 'package:intl/intl.dart'; // For date formatting

class DiaryController extends GetxController {
  RxList<Diary> diaryList = RxList<Diary>([]);
  RxList<Diary> diaryMonthList = RxList<Diary>([]);
  Rx<Diary> thisDiary = Rx<Diary>(Diary());
  final diaryCollection = FirebaseFirestore.instance.collection("diary");

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

  void getthisDiary(DateTime thisDay) {
    Timestamp thisdayTimestamp = Timestamp.fromDate(thisDay);
    thisDiary.value = diaryList.firstWhere(
      (diary) {
        print("--------------");
        print(diary.createdTime!);
        print(thisdayTimestamp);
        return checkSameDay(diary.createdTime!, thisdayTimestamp);
      },
      orElse: () => Diary(),
    );
    print("thisDiary : ${thisDiary.value.content}");
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
              ))
          .toList();
    });
    getthisDiary(DateTime.now());
    getdiaryMonthList(DateTime.now());
  }

  Future<void> addDiary(Diary diary) async {
    print("[adddiary] start");
    print("[adddiary]1 $diary");

    // final userId = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference reference = diaryCollection.doc();

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
