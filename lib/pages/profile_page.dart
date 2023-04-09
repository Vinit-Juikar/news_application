import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  late TextEditingController _nameController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'John Doe');
    _dateController = TextEditingController(text: '01/01/1990');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  

  Future<void> _editName() async {
    final newName = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Name'),
          content: TextField(
            controller: TextEditingController(text: _nameController.text),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(_nameController.text),
              child: const Text('SAVE'),
            ),
          ],
        );
      },
    );

    if (newName != null) {
      setState(() {
        _nameController.text = newName;
      });
    }
  }

  Future<void> _editDate() async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (newDate != null) {
      setState(() {
        _dateController.text =
            '${newDate.month}/${newDate.day}/${newDate.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: const Color.fromARGB(255, 40, 39, 39),
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(255, 40, 39, 39),
        title: Center(child: const Text('Make Your Profile')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Container(
  width: 100,
  height: 100,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    image: DecorationImage(
      fit: BoxFit.fill,
      image:  const AssetImage('assets/images/profile.png') ,
    ),
  ),
  child: GestureDetector(
  
    child: const Icon(
      Icons.edit,
      color: Colors.white,
    ),
  ),
),
    const SizedBox(height: 16),
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Name: ',
            style: TextStyle(
              fontSize: 30,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: _editName,
            child: Container(
                 height: 50,
            width: 150.w,
            decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white)),
              child: Center(
                child: Text(
                  
                  _nameController.text,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    const SizedBox(height: 8),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Date of Birth: ',
          style: TextStyle(
            fontSize: 25,
            color: Colors.grey,
          ),
        ),
        GestureDetector(
          onTap: _editDate,
          child: Container(
            height: 32.h,
            width: 170.w,
             decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.white)),
            child: Center(
              child: Text(
                _dateController.text,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,color: Colors.white
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ], // add this closing bracket
), // and this one as well

      ),
    );
  }
}
