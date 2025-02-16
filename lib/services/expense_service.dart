import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../expense.dart';

class ExpenseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveExpense(Expense expense) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('expenses')
          .add({
        'amount': expense.amount,
        'category': expense.category,
        'note': expense.note,
        'date': expense.date,
        'userId': user.uid
      });
    }
  }


  Stream<List<Expense>> userExpenses() {
    final user = _auth.currentUser;
    if (user != null) {
      return _firestore
          .collection('users')
          .doc(user.uid)
          .collection('expenses')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Expense.fromMap(doc.data()))
            .toList();
      });
    } else {
      return Stream.value([]);
    }
  }
}
