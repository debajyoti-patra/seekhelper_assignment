import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seekhelper_assignment/model/user_model.dart';
import '../../../../core/utils/responsive_helpers.dart';

class UserDetailPage extends StatelessWidget {
  final User user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.name,
          style: TextStyle(
            fontSize: ResponsiveHelper.getTitleTextSize(),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(ResponsiveHelper.getHorizontalPadding()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Header
            _buildProfileHeader(),
            SizedBox(height: 24.h),

            // Contact Information
            _buildSection('Contact Information', [
              _buildInfoRow(Icons.email, 'Email', user.email),
              _buildInfoRow(Icons.phone, 'Phone', user.phone),
              _buildInfoRow(Icons.web, 'Website', user.website),
            ]),
            SizedBox(height: 24.h),

            // Address Information
            _buildSection('Address', [
              _buildInfoRow(
                Icons.home,
                'Street',
                user.address?.street ?? 'N/A',
              ),
              _buildInfoRow(
                Icons.apartment,
                'Suite',
                user.address?.suite ?? 'N/A',
              ),
              _buildInfoRow(
                Icons.location_city,
                'City',
                user.address?.city ?? 'N/A',
              ),
              _buildInfoRow(
                Icons.pin_drop,
                'Zipcode',
                user.address?.zipcode ?? 'N/A',
              ),
            ]),
            SizedBox(height: 24.h),

            // Company Information
            _buildSection('Company', [
              _buildInfoRow(
                Icons.business,
                'Name',
                user.company?.name ?? 'N/A',
              ),
              _buildInfoRow(
                Icons.lightbulb,
                'Catch Phrase',
                user.company?.catchPhrase ?? 'N/A',
              ),
              _buildInfoRow(
                Icons.trending_up,
                'Business',
                user.company?.bs ?? 'N/A',
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.r,
              backgroundColor: Colors.blue,
              child: Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '@${user.username}',
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getTitleTextSize(),
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 16.h),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20.r, color: Colors.grey[600]),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getBodyTextSize(),
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getTitleTextSize(),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
