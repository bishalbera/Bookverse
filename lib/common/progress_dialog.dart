import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  String message;

  ProgressDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.greenAccent,
      child: Container(
        margin: const EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              const SizedBox(
                width: 3.0,
              ),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
              const SizedBox(
                width: 22.0,
              ),
              Text(
                message,
                style: const TextStyle(color: Colors.black, fontSize: 8.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
