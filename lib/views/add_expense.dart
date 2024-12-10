import 'package:expenses_app/constants.dart';
import 'package:expenses_app/enums/category.dart';
import 'package:expenses_app/expense.dart';
import 'package:expenses_app/services/expense_service.dart';

import 'package:expenses_app/views/expenses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/expense_card.dart';

class AddExpense extends StatefulWidget {
  static const String id = 'home_page';

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final ExpenseService expenseService = ExpenseService();
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  IconData currentIcon = Icons.category;
  final FocusNode dropdownFocusNode = FocusNode();
  String? dropdownValue;
  int amount = 0;
  String category = '';
  String note = '';
  DateTime date = DateTime.now();
  Expense? expense;

  Future<void> _handleExpenseSaving(Expense expense) async {
    await expenseService.saveExpense(expense);
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (pickedDate != null && pickedDate != date) {
      setState(() {
        date = pickedDate;
        dateController.text = DateFormat('dd-MM-yyyy').format(date);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownFocusNode.addListener(() {
      if (dropdownFocusNode.hasFocus) {
        dropdownFocusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    dropdownFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            // Back Arrow
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.grey),
                    onPressed: () {
                      Navigator.pushNamed(context, Expenses.id);
                    },
                  ),
                ],
              ),
            ),
            // Form Content
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      Text(
                        "Add Expense",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 30),
                        child: TextFormField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "0",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      DropdownMenu<String>(
                        initialSelection: dropdownValue,
                        leadingIcon: Icon(currentIcon),
                        hintText: "Category",
                        focusNode: dropdownFocusNode,
                        width: 310,
                        menuStyle: MenuStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white)),
                        inputDecorationTheme: InputDecorationTheme(
                            filled: true,
                            fillColor: dropdownValue != null
                                ? Category.getCategoryColor(dropdownValue!)
                                : Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onSelected: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                            currentIcon =
                                Category.getCategoryIcon(dropdownValue!);
                          });
                        },
                        dropdownMenuEntries: Category.values.map((category) {
                          return DropdownMenuEntry<String>(
                            style: MenuItemButton.styleFrom(
                              backgroundColor:
                                  Category.getCategoryColor(category.name),
                              shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                      color: Colors.white, width: 1)
                              ),
                            ),
                            value: category.name,
                            label: category.name,
                            leadingIcon:
                                Icon(Category.getCategoryIcon(category.name)),
                            //Icon(Icons.add),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10),
                      ExpenseDetails(
                        readOnly: false,
                        onTap: null,
                        textController: noteController,
                        hintText: "Note",
                        prefixIcon: Icon(Icons.note),
                      ),
                      ExpenseDetails(
                        readOnly: true,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          _selectDate(context);
                        },
                        textController: dateController,
                        hintText: "Date",
                        prefixIcon: Icon(Icons.date_range),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                        ),
                        child: SizedBox(
                          width: 350,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                amount =
                                    int.tryParse(amountController.text) ?? 0;
                                note = noteController.text.trim();
                                if (amount > 0 && note.isNotEmpty) {
                                  expense = Expense(
                                    amount: amount,
                                    category: dropdownValue ?? 'Category',
                                    note: note,
                                    date: date,
                                  );
                                  _handleExpenseSaving(expense!);
                                  print('Object: $expense');
                                  amountController.clear();
                                  noteController.clear();
                                  dateController.clear();
                                }
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              'SAVE',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.black),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
