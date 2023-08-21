import 'dart:math';

import 'package:book_verse/features/room_preview/widgets/animated_btn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/stylish_drawer.dart';
import '../../utils/appBar.dart';

class RoomPreviewScreen extends StatefulWidget {
  const RoomPreviewScreen({Key? key}) : super(key: key);

  @override
  State<RoomPreviewScreen> createState() => _RoomPreviewScreenState();
}

class _RoomPreviewScreenState extends State<RoomPreviewScreen> {
  String selectedImageUrl = "";
  int selectedThemeIndex = 0;

  String _anyRandomImage =
      "https://images.unsplash.com/photo-1576506542790-51244b486a6b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c3R1ZHl8ZW58MHwxfDB8fHww&auto=format&fit=crop&w=600&q=60"; // Default image URL

  List<String> images = [
    "https://images.unsplash.com/photo-1576506542790-51244b486a6b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c3R1ZHl8ZW58MHwxfDB8fHww&auto=format&fit=crop&w=600&q=60",
    "https://images.unsplash.com/photo-1532153955177-f59af40d6472?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8c3R1ZHl8ZW58MHwxfDB8fHww&auto=format&fit=crop&w=600&q=60",
    "https://images.unsplash.com/photo-1548393488-ae8f117cbc1c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8c3R1ZHl8ZW58MHwxfDB8fHww&auto=format&fit=crop&w=600&q=60",
    "https://images.unsplash.com/photo-1528716321680-815a8cdb8cbe?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHN0dWR5fGVufDB8MXwwfHx8MA%3D%3D&auto=format&fit=crop&w=600&q=60",
    // Add more image URLs as needed
  ];

  Color fontColor = Colors.white;

  List<String> themeNames = [
    'Classic',
    'Modern',
    'Advanced',
    'Special',
  ];

  String roomName = "Untitled Room";
  TextEditingController roomNameController = TextEditingController();

  List<Person> people = [
    Person("John Doe", "john@example.com", "Ready"),
    Person("Jane Smith", "jane@example.com", "Ready"),
    // Add more people as needed
  ];

  void getRandomImageUrl({int index = 0}) {
    if (index != 0) {
      selectedImageUrl = images.isEmpty ? _anyRandomImage : images[index];
    } else if (index == 50) {
      selectedImageUrl = images.isEmpty ? _anyRandomImage : images[0];
    } else {
      selectedImageUrl = images.isEmpty
          ? _anyRandomImage
          : images[Random().nextInt(images.length)];
    }
  }

  @override
  void initState() {
    super.initState();
    getRandomImageUrl();
    roomNameController.text = roomName;
  }

  void editRoomName() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Room Name"),
          content: TextField(
            controller: roomNameController,
            decoration: InputDecoration(hintText: "Enter new room name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  roomName = roomNameController.text;
                });
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void selectTheme(int index) {
    setState(() {
      if (selectedThemeIndex == 0) {
        fontColor = Colors.white;
      } else if (selectedThemeIndex == 1) {
        fontColor = Colors.black;
      } else {
        fontColor = Colors.white;
      }

      selectedThemeIndex = index;
      getRandomImageUrl(index: index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildStylishDrawer(context),
      appBar: makeAppBar(context,
          bgColor: selectedThemeIndex == 1 ? Colors.white : Colors.black,
          fontColor: selectedThemeIndex == 1 ? Colors.black : Colors.white),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.88,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(selectedImageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: editRoomName,
                      child: Icon(
                        Icons.edit,
                        color: fontColor,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      roomName,
                      style: GoogleFonts.barriecito(
                        color: fontColor,
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Please Choose a study room theme",
                style: GoogleFonts.ptSans(
                  color: fontColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      themeNames.length,
                      (index) => GestureDetector(
                        onTap: () => selectTheme(index),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedThemeIndex == index
                                    ? Colors.green
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 120,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: NetworkImage(images[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    themeNames[index],
                                    style: GoogleFonts.poppins(
                                      color: selectedThemeIndex == index
                                          ? Colors.green
                                          : Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.lightBlue.shade100, Colors.blue.shade900],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: people.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      tileColor: Colors.grey,
                      title: Text(
                        people[index].name,
                        style: GoogleFonts.poppins(
                          color: fontColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        people[index].email,
                        style: GoogleFonts.poppins(
                          color: fontColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        people[index].status,
                        style: GoogleFonts.poppins(
                          color: fontColor,
                          fontSize: 14,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  elevation: 13,
                  shadowColor: Colors.deepPurpleAccent.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 16,
                  ),
                ),
                child: Text(
                  'Invite your friends',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              MyAnimatedButton(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Person {
  final String name;
  final String email;
  final String status;

  Person(this.name, this.email, this.status);
}
