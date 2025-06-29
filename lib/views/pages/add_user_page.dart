import 'package:flutter/material.dart';
import '../../../../core/utils/responsive_helpers.dart';
import '../widgets/add_user_form.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New User',
          style: TextStyle(
            fontSize: ResponsiveHelper.getTitleTextSize(),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const AddUserForm(),
    );
  }
}
