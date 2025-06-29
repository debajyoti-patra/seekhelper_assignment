import 'package:equatable/equatable.dart';
import 'package:seekhelper_assignment/model/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

//Initial state
class UserInitial extends UserState {
  const UserInitial();
}

//Loading state
class UsersLoading extends UserState {
  const UsersLoading();
}

//Loaded state (After api call successfull)
class UsersLoaded extends UserState {
  final List<User> users;
  final List<User> filteredUsers;
  final String searchQuery;

  const UsersLoaded({
    required this.users,
    required this.filteredUsers,
    this.searchQuery = '',
  });

  @override
  List<Object> get props => [users, filteredUsers, searchQuery];

  UsersLoaded copyWith({
    List<User>? users,
    List<User>? filteredUsers,
    String? searchQuery,
  }) {
    return UsersLoaded(
      users: users ?? this.users,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

//Error state (After api call failed)
class UsersError extends UserState {
  final String message;

  const UsersError(this.message);

  @override
  List<Object> get props => [message];
}

//User Adding state
class UserAdding extends UserState {
  const UserAdding();
}

//User Added state
class UserAdded extends UserState {
  final User user;

  const UserAdded(this.user);

  @override
  List<Object> get props => [user];
}

//User Add Error state
class UserAddError extends UserState {
  final String message;

  const UserAddError(this.message);

  @override
  List<Object> get props => [message];
}
