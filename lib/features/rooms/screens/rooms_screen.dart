import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import '../../room_preview/room_preview_screen.dart';

class RoomsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rooms'),
      ),
      body: RoomList(),
    );
  }
}

class RoomList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('rooms').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final roomDocs = snapshot.data!.docs;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          itemCount: roomDocs.length,
          itemBuilder: (context, index) {
            final roomData = roomDocs[index].data() as Map<String, dynamic>;
            final roomId = roomDocs[index].id;
            final roomName = roomData['name'];
            final randomEmoji = _getRandomEmoji();

            return RoomCard(
              roomName: roomName,
              emoji: randomEmoji,
              onPressed: () {
                _joinRoom(context, roomId);
              },
            );
          },
        );
      },
    );
  }

  void _joinRoom(BuildContext context, String roomId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('rooms').doc(roomId).update({
        'participants': FieldValue.arrayUnion([user.uid]),
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RoomPreviewScreen(roomCode: roomId),
        ),
      );
    }
  }

  String _getRandomEmoji() {
    final emojis = ['🎉', '🚀', '🌟', '🎈', '🔥', '🎊'];
    return emojis[Random().nextInt(emojis.length)];
  }
}

class RoomCard extends StatefulWidget {
  final String roomName;
  final String emoji;
  final VoidCallback onPressed;

  const RoomCard({
    required this.roomName,
    required this.emoji,
    required this.onPressed,
  });

  @override
  _RoomCardState createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: InkWell(
        onTap: widget.onPressed,
        child: Container(
          height: 400,
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotationTransition(
                  turns: _animation,
                  child: Text(
                    widget.emoji,
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  widget.roomName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 2),
                ElevatedButton(
                  onPressed: widget.onPressed,
                  child: Text('Join'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
