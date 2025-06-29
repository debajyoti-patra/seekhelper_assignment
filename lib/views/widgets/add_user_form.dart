import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seekhelper_assignment/blocs/user_bloc/user_bloc.dart';
import 'package:seekhelper_assignment/blocs/user_bloc/user_event.dart';
import 'package:seekhelper_assignment/core/utils/app_utils.dart';
import 'package:seekhelper_assignment/model/user_model.dart';
import '../../../../core/utils/responsive_helpers.dart';

class AddUserForm extends StatefulWidget {
  const AddUserForm({super.key});

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _websiteController = TextEditingController();
  final _streetController = TextEditingController();
  final _suiteController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipcodeController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _catchPhraseController = TextEditingController();
  final _bsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    _streetController.dispose();
    _suiteController.dispose();
    _cityController.dispose();
    _zipcodeController.dispose();
    _companyNameController.dispose();
    _catchPhraseController.dispose();
    _bsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(ResponsiveHelper.getHorizontalPadding()),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Personal Information',
              style: TextStyle(
                fontSize: ResponsiveHelper.getTitleTextSize(),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),

            // Name Field
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),

            // Username Field
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.alternate_email),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a username';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),

            // Email Field
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                if (!AppUtils.isValidEmail(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),

            // Phone Field
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                }
                if (!AppUtils.isValidPhone(value)) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),

            // Website Field
            TextFormField(
              controller: _websiteController,
              decoration: const InputDecoration(
                labelText: 'Website',
                prefixIcon: Icon(Icons.web),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
            ),
            SizedBox(height: 24.h),

            Text(
              'Address Information',
              style: TextStyle(
                fontSize: ResponsiveHelper.getTitleTextSize(),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),

            // Street Field
            TextFormField(
              controller: _streetController,
              decoration: const InputDecoration(
                labelText: 'Street',
                prefixIcon: Icon(Icons.home),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a street address';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),

            // Suite Field
            TextFormField(
              controller: _suiteController,
              decoration: const InputDecoration(
                labelText: 'Suite/Apartment',
                prefixIcon: Icon(Icons.apartment),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.h),

            // City Field
            TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'City',
                prefixIcon: Icon(Icons.location_city),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a city';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),

            // Zipcode Field
            TextFormField(
              controller: _zipcodeController,
              decoration: const InputDecoration(
                labelText: 'Zipcode',
                prefixIcon: Icon(Icons.pin_drop),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a zipcode';
                }
                return null;
              },
            ),
            SizedBox(height: 24.h),

            Text(
              'Company Information',
              style: TextStyle(
                fontSize: ResponsiveHelper.getTitleTextSize(),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),

            // Company Name Field
            TextFormField(
              controller: _companyNameController,
              decoration: const InputDecoration(
                labelText: 'Company Name',
                prefixIcon: Icon(Icons.business),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a company name';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),

            // Catch Phrase Field
            TextFormField(
              controller: _catchPhraseController,
              decoration: const InputDecoration(
                labelText: 'Catch Phrase',
                prefixIcon: Icon(Icons.lightbulb),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.h),

            // Business Field
            TextFormField(
              controller: _bsController,
              decoration: const InputDecoration(
                labelText: 'Business',
                prefixIcon: Icon(Icons.trending_up),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32.h),

            // Submit Button
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Add User',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getTitleTextSize(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch,
        name: _nameController.text,
        username: _usernameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        website:
            _websiteController.text.isEmpty ? 'N/A' : _websiteController.text,
        address: Address(
          street: _streetController.text,
          suite: _suiteController.text.isEmpty ? 'N/A' : _suiteController.text,
          city: _cityController.text,
          zipcode: _zipcodeController.text,
        ),
        company: Company(
          name: _companyNameController.text,
          catchPhrase:
              _catchPhraseController.text.isEmpty
                  ? 'N/A'
                  : _catchPhraseController.text,
          bs: _bsController.text.isEmpty ? 'N/A' : _bsController.text,
        ),
      );

      context.read<UserBloc>().add(AddUser(user));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User added successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      context.pop();
    }
  }
}
