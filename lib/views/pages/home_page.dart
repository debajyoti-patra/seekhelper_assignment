import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seekhelper_assignment/blocs/user_bloc/user_event.dart';
import 'package:seekhelper_assignment/blocs/user_bloc/user_state.dart';
import 'package:seekhelper_assignment/model/user_model.dart';
import '../../../../core/utils/responsive_helpers.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../blocs/user_bloc/user_bloc.dart';
import '../widgets/user_card.dart';
import '../widgets/user_search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final List<User> _allUsers = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Load users on startup
    context.read<UserBloc>().add(LoadUsers());
    _animationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
          style: TextStyle(
            fontSize: ResponsiveHelper.getTitleTextSize(),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<UserBloc>().add(LoadUsers());
            },
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Search Bar
            UserSearchBar(
              controller: _searchController,
              onChanged: (query) {
                context.read<UserBloc>().add(SearchUsers(query));
              },
            ),
            // Users List
            Expanded(
              child: BlocBuilder<UserBloc, UserState>(
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) {
                  if (state is UsersLoading) {
                    return const LoadingWidget(message: 'Loading users...');
                  } else if (state is UsersError) {
                    return CustomErrorWidget(
                      message: state.message,
                      onRetry: () {
                        context.read<UserBloc>().add(LoadUsers());
                      },
                    );
                  } else if (state is UsersLoaded) {
                    if (state.filteredUsers.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64.r,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'No users found',
                              style: TextStyle(
                                fontSize: ResponsiveHelper.getTitleTextSize(),
                                color: Colors.grey[600],
                              ),
                            ),
                            if (_searchController.text.isNotEmpty) ...[
                              SizedBox(height: 8.h),
                              Text(
                                'Try adjusting your search',
                                style: TextStyle(
                                  fontSize: ResponsiveHelper.getBodyTextSize(),
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    }

                    return _buildUserGrid(state.filteredUsers);
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.pushNamed('add-user');
        },
        icon: const Icon(Icons.add),
        label: const Text('Add User'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildUserGrid(List<User> users) {
    final crossAxisCount = ResponsiveHelper.getGridColumns(context);

    return RefreshIndicator(
      onRefresh: () async => context.read<UserBloc>().add(LoadUsers()),
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(ResponsiveHelper.getHorizontalPadding()),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: ResponsiveHelper.isMobile(context) ? 1.2 : 1.0,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
        ),
        itemCount: users.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Interval(
                    (index * 0.1).clamp(0.0, 1.0),
                    ((index * 0.1) + 0.3).clamp(0.0, 1.0),
                    curve: Curves.easeOut,
                  ),
                ),
              );

              return Transform.scale(
                scale: animation.value,
                child: UserCard(user: users[index]),
              );
            },
          );
        },
      ),
    );
  }
}
