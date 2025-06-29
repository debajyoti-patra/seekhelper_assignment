import 'package:go_router/go_router.dart';
import 'package:seekhelper_assignment/core/utils/page_animations.dart';
import 'package:seekhelper_assignment/model/user_model.dart';
import 'package:seekhelper_assignment/views/pages/add_user_page.dart';
import 'package:seekhelper_assignment/views/pages/home_page.dart';
import 'package:seekhelper_assignment/views/pages/user_detail_page.dart';

class AppRouter {
  static const String home = '/';
  static const String userDetail = '/user-detail';
  static const String addUser = '/add-user';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: userDetail,
        name: 'user-detail',
        pageBuilder: (context, state) {
          final user = state.extra as User;
          return PageAnimations.sharedAxisScaled(
            UserDetailPage(user: user),
            state.pageKey,
          );
        },
      ),
      GoRoute(
        path: addUser,
        name: 'add-user',
        pageBuilder:
            (context, state) => PageAnimations.slideFromRight(
              const AddUserPage(),
              state.pageKey,
            ),
      ),
    ],
  );
}
