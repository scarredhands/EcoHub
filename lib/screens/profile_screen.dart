import 'dart:io';

import 'package:ecohub/screens/settings_screen.dart';
import 'package:ecohub/widgets/button.dart';
import 'package:ecohub/widgets/input_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _phoneController.text = prefs.getString('phone') ?? '';
      _passwordController.text = prefs.getString('password') ?? '';
      _bioController.text = prefs.getString('bio') ?? '';
      String? imagePath = prefs.getString('profileImage');
      if (imagePath != null && imagePath.isNotEmpty) {
        _profileImage = File(imagePath);
      }
    });
  }

  Future<void> _saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('password', _passwordController.text);
    await prefs.setString('bio', _bioController.text);
    if (_profileImage != null) {
      await prefs.setString('profileImage', _profileImage!.path);
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage == null
                        ? AssetImage('assets/user_photo.jpeg')
                        : FileImage(_profileImage!) as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _bioController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: 'Bio',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    hintText: 'Write something about yourself...',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: InputTextWidget('Name', false, _nameController),
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: InputTextWidget('Email', false, _emailController),
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: InputTextWidget('Phone', false, _phoneController),
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: InputTextWidget('Password', true, _passwordController),
              ),
              SizedBox(height: 10),
              Button(
                  text: 'Save Profile',
                  onPressed: () {
                    _saveProfileData();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Profile Updated'),
                    ));
                  }),
              SizedBox(height: 13),
              Button(text: 'Logout', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
