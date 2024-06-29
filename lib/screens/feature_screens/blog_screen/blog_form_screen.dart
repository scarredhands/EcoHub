import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecohub/models/blog_model/blog_model.dart';
import 'package:ecohub/screens/feature_screens/blog_screen/blog_screen.dart';
import 'package:flutter/material.dart';

class BlogFormScreen extends StatefulWidget {
  @override
  _BlogFormScreenState createState() => _BlogFormScreenState();
}

class _BlogFormScreenState extends State<BlogFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _imageUrlController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newBlog = Blog(
        id: '',
        title: _titleController.text,
        content: _contentController.text,
        date: DateTime.now(),
        imageUrl: _imageUrlController.text,
      );

      try {
        await FirebaseFirestore.instance
            .collection('blogs')
            .add(newBlog.toMap());
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Blog saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save blog: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill out the form correctly'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text(
          "Blogs",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlogScreen(),
                    ));
              },
              icon: Icon(
                Icons.notes,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.deepPurple.shade300,
                      )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.deepPurple.shade800,
                      )),
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.deepPurple.shade800,
                      )),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _contentController,
                  decoration: InputDecoration(
                      hintText: 'Content',
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple.shade300),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple.shade800),
                          borderRadius: BorderRadius.circular(5)),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple.shade800),
                          borderRadius: BorderRadius.circular(5)),
                      fillColor: const Color.fromARGB(255, 246, 227, 198),
                      filled: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter content';
                    }
                    return null;
                  },
                  maxLines: 10,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _imageUrlController,
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 246, 227, 198),
                    filled: true,
                    hintText: 'Image url',
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepPurple.shade300),
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepPurple.shade800),
                        borderRadius: BorderRadius.circular(5)),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepPurple.shade800),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter an image URL';
                  //   }
                  //   return null;
                  // },
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: _submitForm,
                  child: Container(
                    width: 120,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.pink, Colors.purple
                      ]),
                        
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                        child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
