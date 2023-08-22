import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Info'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader('Inspiration'),
            _buildParagraph(
              'The inspiration behind TheBookVerse app came from our love for reading and the desire to bring people together in a virtual library setting. We wanted to create a platform where friends can connect, read, and share their favorite books no matter where they are.',
            ),
            _buildHeader('Aim'),
            _buildParagraph(
              'Our aim is to provide a unique and immersive reading experience for users by combining the convenience of a digital library with the social aspect of being able to interact with friends while reading. We believe that reading is not just a solitary activity but a shared passion that can strengthen connections.',
            ),
            _buildHeader('Team'),
            _buildParagraph(
              'TheBookVerse app was developed by a dedicated team of passionate developers, designers, and book enthusiasts. Our team members bring a diverse range of skills and experiences to the table, united by the common goal of creating a seamless and enjoyable reading experience for our users.',
            ),
            _buildHeader('Why We Made It'),
            _buildParagraph(
              'We created TheBookVerse app because we wanted to bridge the gap between physical book clubs and the digital age. We believe that reading is a powerful way to learn, grow, and connect with others. Our app allows users to explore new books, discuss them with friends, and earn rewards for their reading journey.',
            ),
            _buildHeader('Steps to Operate'),
            _buildStep('1. Sign Up or Log In to the App.'),
            _buildStep('2. Browse Personalized Book Recommendations.'),
            _buildStep('3. Join or Create a Reading Room with Friends.'),
            _buildStep('4. Select a Book to Read Together.'),
            _buildStep('5. Read, Discuss, and Earn Coins.'),
            _buildStep('6. Claim Your Coins in Your Wallet.'),
            _buildStep('7. Enjoy a Unique Reading Experience!'),
            const SizedBox(height: 20),
            _buildFooter("Made with 💖 by Armaan and  Bishal"),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFooter(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildStep(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, size: 20, color: Colors.green),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GuideScreen(),
  ));
}
