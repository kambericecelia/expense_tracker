import 'package:expenses_app/enums/category.dart';
import 'package:expenses_app/constants.dart';
import 'package:expenses_app/components/category_card.dart';
import 'package:expenses_app/expense.dart';
import 'package:expenses_app/views/add_expense.dart';
import 'package:expenses_app/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../services/expense_service.dart';

class Expenses extends StatefulWidget {
  static const String id = 'list_expenses';

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ExpenseService _expenseService = ExpenseService();
  User? user = FirebaseAuth.instance.currentUser;
  String userName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    if (user?.email != null) {
      userName = user!.email!.substring(0, user!.email!.indexOf('@'));
    }
  }


  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print("SignOut Error: $e");
    }
  }
  String messageBasedOnDate(DateTime expenseDate){
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final parsedExpenseDate = DateTime(expenseDate.year, expenseDate.month, expenseDate.day);
    final yesterday = today.subtract(Duration(days:1));
    if (parsedExpenseDate == today){
      return "Today";
    }else if(yesterday == parsedExpenseDate){
      return "Yesterday";
    }else{
      return DateFormat('dd-MM-yyyy').format(expenseDate);
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                      Text(
                        userName,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      signOut();
                      Navigator.pop(context);
                      Navigator.pushNamed(context, LoginPage.id);
                    },
                    child: Icon(
                      Icons.logout,
                      size: 30,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Total Balance",
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "\$ 4000.00",
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Transactions",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  )),
              Expanded(
                child: StreamBuilder(
                    stream: _expenseService.userExpenses(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("Error loading expenses"),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Text(
                            "You do not have any expense yet!",
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      }
                      final expenses = snapshot.data!;
                      return ListView.builder(
                          itemCount: expenses.length,
                          itemBuilder: (context, index) {
                            final expense = expenses[index];
                            return CategoryCard(
                              date: messageBasedOnDate(expense.date),
                                title: expense.category,
                                icon:
                                    Category.getCategoryIcon(expense.category),
                                amount: expense.amount.toString(),
                                color: Category.getCategoryColor(
                                    expense.category));
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_button',
        onPressed: () {
          Navigator.pushNamed(context, AddExpense.id);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
