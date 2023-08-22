import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_verse/features/home/home_screen.dart';
import 'package:book_verse/utils/move_screen.dart';
import 'package:book_verse/utils/show_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CodeRedemptionScreen extends StatefulWidget {
  final String code;
  const CodeRedemptionScreen({Key? key, this.code = ''}) : super(key: key);

  @override
  State<CodeRedemptionScreen> createState() => _CodeRedemptionScreenState();
}

class _CodeRedemptionScreenState extends State<CodeRedemptionScreen> {
  final TextEditingController _codeController = TextEditingController();
  late ConfettiController _confettiController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.code != '') _codeController.text = widget.code;
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _codeController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _redeemCode() async {
    final String enteredCode = _codeController.text;
    setState(() {
      _isLoading = true;
    });

    final DocumentReference codeDocRef =
        FirebaseFirestore.instance.collection('codes').doc(enteredCode);

    final DocumentSnapshot codeDoc = await codeDocRef.get();

    if (codeDoc.exists && codeDoc['code'] == enteredCode) {
      _confettiController.play();

      // Update user's verseCoins and delete the code document
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final DocumentReference userDocRef =
            FirebaseFirestore.instance.collection('users').doc(currentUser.uid);

        final DocumentSnapshot userDoc = await userDocRef.get();
        if (userDoc.exists) {
          final int currentVerseCoins = int.parse(userDoc['verseCoins'] ?? '0');
          final int updatedVerseCoins = currentVerseCoins + 20;

          await userDocRef.update({'verseCoins': updatedVerseCoins.toString()});
          await codeDocRef.delete();
          moveScreen(context, HomeScreen(), isPushReplacement: true);
        }
      }
    } else {
      // Show error snackbar
      showSnackBar(
          context, "Error!", "Invalid or expired code!", ContentType.failure);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Code Redemption',
          style: GoogleFonts.lato(),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Redeem your code here",
                  style: GoogleFonts.lato(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: _codeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your code',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    await _redeemCode();
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          padding: EdgeInsets.all(10),
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Redeem',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
