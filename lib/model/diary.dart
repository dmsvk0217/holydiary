import 'package:cloud_firestore/cloud_firestore.dart';

class Diary {
  final String? userid;
  final String? content;
  final String? contentGPT;
  final Timestamp? createdTime;
  final DocumentReference? reference;

  Diary({
    this.userid,
    this.content,
    this.contentGPT,
    this.createdTime,
    this.reference,
  });

  // Map<String, Object?> toMap() {
  //   return {
  //     GroupQuestionFirestoreFieldName.answersFieldName:
  //         answers.map((answer) => answer.toMap()).toList(),
  //     GroupQuestionFirestoreFieldName.questionFieldName: question.toMap(),
  //     GroupQuestionFirestoreFieldName.groupQuestionIdFieldName: groupQuestionId,
  //     GroupQuestionFirestoreFieldName.createdTimeFieldName: createdTime,
  //     GroupQuestionFirestoreFieldName.isVisibleFieldName: isVisible,
  //     GroupQuestionFirestoreFieldName.questionOrderFieldName: questionOrder,
  //     GroupQuestionFirestoreFieldName.rewardTreeXpFieldName: rewardTreeXp,
  //     GroupQuestionFirestoreFieldName.visualizableTimeFieldName: visualizedTime,
  //   };
  // }
}

// class GroupQuestionFirestoreFieldName {
//   static const String questionFieldName = 'question';
//   static const String groupQuestionIdFieldName = 'group-question-id';
//   static const String createdTimeFieldName = 'created-time';
//   static const String isVisibleFieldName = 'are-answers-visible';
//   static const String visualizableTimeFieldName = 'answers-visualized-time';
//   static const String questionOrderFieldName = 'question-order';
//   static const String rewardTreeXpFieldName = 'reward-tree-xp';
//   static const String answersFieldName = 'answers';
// }
