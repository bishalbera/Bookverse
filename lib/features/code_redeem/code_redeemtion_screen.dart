import 'package:flutter/material.dart';

class CodeRedemptionScreen extends StatefulWidget {
  const CodeRedemptionScreen({super.key});

  @override
  State<CodeRedemptionScreen> createState() => _CodeRedemptionScreenState();
}

class _CodeRedemptionScreenState extends State<CodeRedemptionScreen> {
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Redemption'),
      ),
      body: const Center(
        child: Column(
          children: [
            Text("Redeem your code here"),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your code',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
