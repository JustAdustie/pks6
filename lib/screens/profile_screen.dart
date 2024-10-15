import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String fullName = 'Быков Александр';
  String group = 'ЭВБО-03-22';
  String email = 'bykov@example.com';
  String phoneNumber = '+1238718231';
  bool isEditing = false;

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ФИО: $fullName', style: TextStyle(fontSize: 18)),
            if (isEditing) TextField(onChanged: (value) => fullName = value),
            SizedBox(height: 16),
            Text('Группа: $group', style: TextStyle(fontSize: 18)),
            if (isEditing) TextField(onChanged: (value) => group = value),
            SizedBox(height: 16),
            Text('Почта: $email', style: TextStyle(fontSize: 18)),
            if (isEditing) TextField(onChanged: (value) => email = value),
            SizedBox(height: 16),
            Text('Телефон: $phoneNumber', style: TextStyle(fontSize: 18)),
            if (isEditing) TextField(onChanged: (value) => phoneNumber = value),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: toggleEditing,
              child: Text(isEditing ? 'Сохранить' : 'Редактировать профиль'),
            ),
          ],
        ),
      ),
    );
  }
}
