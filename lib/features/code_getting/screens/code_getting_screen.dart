import 'dart:math';

import 'package:book_verse/features/code_redeem/code_redeemtion_screen.dart';
import 'package:book_verse/features/database/controllers/database_controller.dart';
import 'package:book_verse/utils/appBar.dart';
import 'package:book_verse/utils/move_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class CodeGettingScreen extends StatefulWidget {
  const CodeGettingScreen({Key? key}) : super(key: key);

  @override
  State<CodeGettingScreen> createState() => _CodeGettingScreenState();
}

class _CodeGettingScreenState extends State<CodeGettingScreen> {
  late String generatedCode; // Declare as late

  @override
  void initState() {
    super.initState();
    generatedCode = _generateRandomCode();
  }

  String _generateRandomCode() {
    final Random random = Random();
    const String characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    const int codeLength = 6;

    String code = '';
    for (int i = 0; i < codeLength; i++) {
      final int randomIndex = random.nextInt(characters.length);
      code += characters[randomIndex];
    }

    return code;
  }

  double containerMargin = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeAppBar(context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Center(
                child:
                    Text("Get your code here!", style: TextStyle(fontSize: 24)),
              ),
              const SizedBox(
                height: 20,
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                margin: EdgeInsets.only(top: containerMargin),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Generated Code:',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Text(
                        generatedCode,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    containerMargin = containerMargin == 0.0 ? 20.0 : 0.0;
                  });
                  // Redeem code logic here
                  //logic is here
                  DataBaseController controller = DataBaseController();
                  controller.createCodeInFirebase(context, generatedCode);
                  moveScreen(
                      context,
                      CodeRedemptionScreen(
                        code: generatedCode,
                      ));
                },
                child: Text('Redeem this code'),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
