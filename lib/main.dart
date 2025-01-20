
import 'package:expenses_app/views/add_expense.dart';
import 'package:expenses_app/views/user_expenses_listed.dart';
import 'package:expenses_app/views/login_page.dart';
import 'package:expenses_app/views/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    //home: AddExpense(),
    initialRoute: LoginPage.id,
    routes: {
        AddExpense.id: (context) =>AddExpense(),
        UserExpenses.id: (context) => UserExpenses(),
        LoginPage.id: (context) => LoginPage(),
        SignUp.id:(context) => SignUp(),
    }
    //
    );
  }
}


