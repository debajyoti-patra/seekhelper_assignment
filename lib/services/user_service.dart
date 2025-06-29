import 'dart:convert';
import '../core/network/api_service.dart';
import '../core/utils/conectivity_helper.dart';
import '../model/user_model.dart';

class UserService {
  final ApiService _apiService = ApiService();
  final ConnectivityHelper _connectivityHelper = ConnectivityHelper();

  // Fetches all users from the API
  Future<List<User>> getAllUsers() async {
    try {
      // Check internet connectivity
      final isConnected = await _connectivityHelper.isConnected();
      if (!isConnected) {
        throw ApiException('No internet connection');
      }

      final response = await _apiService.get('/users');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<User> apiUsers =
            jsonData.map((json) => User.fromJson(json)).toList();
        final allUsers = [...apiUsers];
        return allUsers;
      } else {
        throw ApiException('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException('Error fetching users: ${e.toString()}');
    }
  }

  // Adds a new user
  Future<User> addUser(User user) async {
    try {
      // Generate unique ID for local user
      final newId = DateTime.now().millisecondsSinceEpoch;
      final newUser = user.copyWith(id: newId);

      return newUser;
    } catch (e) {
      throw ApiException('Error adding user: ${e.toString()}');
    }
  }

  // Searches for users based on the provided query
  List<User> searchUsers(List<User> users, String query) {
    if (query.isEmpty) return users;

    final lowerQuery = query.toLowerCase();
    return users.where((user) {
      return user.name.toLowerCase().contains(lowerQuery) ||
          user.email.toLowerCase().contains(lowerQuery) ||
          user.username.toLowerCase().contains(lowerQuery) ||
          user.phone.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
