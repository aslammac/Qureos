import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qureos/constants.dart';
import 'package:qureos/providers/auth.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/unnamed.png',
          fit: BoxFit.contain,
          height: 30,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.grey[300],
      ),
      body:  Column(
        children:  [
          const SizedBox(height: 20),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20) ,child: Text('Hey, '+context.read<AuthProvider>().userName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),),
        ],
      ),
    );
  }
}
