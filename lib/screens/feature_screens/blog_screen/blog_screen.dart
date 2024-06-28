import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/blog_model/blog_model.dart';
import 'blog_detail_screen.dart';
import 'blog_form_screen.dart';

class BlogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BlogFormScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('blogs').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<Blog> blogs = snapshot.data!.docs.map((doc) {
            return Blog.fromMap(doc.data() as Map<String, dynamic>, doc.id);
          }).toList();

          return ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              Blog blog = blogs[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlogDetailScreen(blog: blog),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image, only if imageUrl is provided
                          if (blog.imageUrl != null &&
                              blog.imageUrl!.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                blog.imageUrl!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[200],
                                    width: double.infinity,
                                    height: 200,
                                    child: Icon(
                                      Icons.broken_image,
                                      color: Colors.grey[400],
                                      size: 100,
                                    ),
                                  );
                                },
                              ),
                            ),
                          if (blog.imageUrl != null &&
                              blog.imageUrl!.isNotEmpty)
                            SizedBox(
                                height:
                                    10), // Add space only if image is displayed
                          // Title
                          Text(
                            blog.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 10),
                          // Date
                          Text(
                            'Published on: ${DateFormat('yyyy-MM-dd – kk:mm').format(blog.date)}', // Formatting the date
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 10),
                          // Content
                          Text(
                            blog.content,
                            maxLines: 3, // Limit the content to 3 lines
                            overflow: TextOverflow
                                .ellipsis, // Show ellipsis if text is too long
                          ),
                          SizedBox(height: 10),
                          // Read More link
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Read more',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
