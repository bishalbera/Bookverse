import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../common/bottom_navigation_bar.dart';

void main() {
  runApp(MaterialApp(
    home: ChooseBooksScreen(),
    theme: ThemeData(
      primaryColor: Colors.blue,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue,
      ),
    ),
  ));
}

class ChooseBooksScreen extends StatefulWidget {
  @override
  _ChooseBooksScreenState createState() => _ChooseBooksScreenState();
}

class _ChooseBooksScreenState extends State<ChooseBooksScreen> {
  TextEditingController _searchController = TextEditingController();
  int _limit = 10;
  List<dynamic> _books = [];
  bool _isLoading = false;

  Future<void> _searchBooks() async {
    String query = _searchController.text;
    if (query.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      try {
        var response = await http.get(Uri.parse(
            'https://www.googleapis.com/books/v1/volumes?q=$query&maxResults=$_limit'));
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          setState(() {
            _books = data['items'];
          });
        }
      } catch (error) {
        // Handle error here
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyCustomBottomNavigationBar(),
      appBar: AppBar(
        title: Text(
          'Book Search',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for books',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                suffixIcon: _isLoading
                    ? CircularProgressIndicator()
                    : IconButton(
                        icon: Icon(Icons.search),
                        onPressed: _searchBooks,
                      ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Limit:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton<int>(
                value: _limit,
                onChanged: (int? newValue) {
                  setState(() {
                    _limit = newValue!;
                  });
                },
                items: [10, 20, 30].map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(
                      value.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Set the number of columns here
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: _books.length,
              itemBuilder: (context, index) {
                var book = _books[index]['volumeInfo'];
                return GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailsScreen(book: book),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          alignment: Alignment.center,
                          child: CachedNetworkImage(
                            imageUrl: book['imageLinks']?['thumbnail'] ?? '',
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            book['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BookDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> book;

  const BookDetailsScreen({
    Key? key,
    required this.book,
  }) : super(key: key);

  void _launchURL() async {
    if (book['previewLink'] != null) {
      String url = book['previewLink'];
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        // Handle error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          book['title'],
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Text(
                'Author(s): ${book['authors']?.join(', ') ?? 'Unknown Author'}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Published Date: ${book['publishedDate'] ?? 'Unknown Date'}',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Description: ${book['description'] ?? 'N/A'}',
              ),
            ),
            if (book['previewLink'] != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _launchURL,
                  child: Text(
                    'Read the Book',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}