import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seekhelper_assignment/app/constants/app_constants.dart';
import 'package:seekhelper_assignment/model/user_model.dart';
import '../../../../core/utils/responsive_helpers.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding() / 2,
        vertical: 8.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
      ),
      child: InkWell(
        onTap: () {
          context.pushNamed('user-detail', extra: user);
        },
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        child: Padding(
          padding: EdgeInsets.all(ResponsiveHelper.getCardPadding()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Avatar and Name
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundColor: AppConstants.primaryColor,
                    child: Text(
                      user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getTitleTextSize(),
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '@${user.username}',
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getBodyTextSize(),
                            color: Colors.grey[600],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Email
              Row(
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: 16.r,
                    color: Colors.grey[600],
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      user.email,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getBodyTextSize(),
                        color: Colors.grey[700],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              // Phone
              Row(
                children: [
                  Icon(
                    Icons.phone_outlined,
                    size: 16.r,
                    color: Colors.grey[600],
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      user.phone,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getBodyTextSize(),
                        color: Colors.grey[700],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              // Company
              Row(
                children: [
                  Icon(
                    Icons.business_outlined,
                    size: 16.r,
                    color: Colors.grey[600],
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      user.company?.name ?? 'N/A',
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getBodyTextSize(),
                        color: Colors.grey[700],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
