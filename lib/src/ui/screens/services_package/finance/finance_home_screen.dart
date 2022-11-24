import 'package:flutter/material.dart';

class FinanceHomeScreen extends StatefulWidget {
  static const routeName = "/FinanceHomeScreen";
  const FinanceHomeScreen({Key? key}) : super(key: key);
  @override
  _FinanceHomeScreenState createState() => _FinanceHomeScreenState();
}

class _FinanceHomeScreenState extends State<FinanceHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Text("finance"),
    );
  }
}
