import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  int amount;
  String category;
  String note;
  DateTime date;
  Expense(
      {required this.amount,
      required this.category,
      required this.note,
      required this.date});

  @override
  String toString() {
    // TODO: implement toString
    return 'Amount: $amount,Category: $category, Note: $note, Date: $date';
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      amount: map['amount'] as int,
      category: map['category'] as String,
      note: map['note'] as String,
      date: (map['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'category': category,
      'note': note,
      'date': date,
    };
  }
}
