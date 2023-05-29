import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holydiary/model/diary.dart';

class DiaryService {
  final CollectionReference _diaryCollection =
      FirebaseFirestore.instance.collection('diary');

  Future<void> createDiary(Diary diary) async {
    try {
      await _diaryCollection.add({
        'userid': diary.userid,
        'content': diary.content,
        'contentGPT': diary.contentGPT,
        'createdTime': diary.createdTime,
      });
    } catch (e) {
      print('Error creating diary: $e');
    }
  }

  Stream<List<Diary>> getDiary() {
    try {
      return _diaryCollection.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return Diary(
            userid: doc['userid'],
            content: doc['content'],
            contentGPT: doc['contentGPT'],
            createdTime: doc['createdTime'],
            reference: doc.reference,
          );
        }).toList();
      });
    } catch (e) {
      print('Error getting diary: $e');
      return Stream.value([]);
    }
  }

  Future<void> updateDiary(Diary diary) async {
    try {
      await diary.reference?.update({
        'userid': diary.userid,
        'content': diary.content,
        'contentGPT': diary.contentGPT,
        'createdTime': diary.createdTime,
      });
    } catch (e) {
      print('Error updating diary: $e');
    }
  }

  Future<void> deleteDiary(Diary diary) async {
    try {
      await diary.reference?.delete();
    } catch (e) {
      print('Error deleting diary: $e');
    }
  }
}
