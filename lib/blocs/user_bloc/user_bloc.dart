import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seekhelper_assignment/blocs/user_bloc/user_event.dart';
import 'package:seekhelper_assignment/blocs/user_bloc/user_state.dart';
import 'package:seekhelper_assignment/core/network/api_service.dart';
import 'package:seekhelper_assignment/model/user_model.dart';
import 'package:seekhelper_assignment/services/user_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _userService;
  List<User> _allUsers = [];

  UserBloc(this._userService) : super(const UserInitial()) {
    // Event handlers
    on<LoadUsers>(_onLoadUsers);
    on<SearchUsers>(_onSearchUsers);
    on<AddUser>(_onAddUser);
    on<RefreshUsers>(_onRefreshUsers);
  }

  //Handler for load users
  Future<void> _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    emit(const UsersLoading());

    try {
      final users = await _userService.getAllUsers();
      _allUsers = users;

      emit(UsersLoaded(users: users, filteredUsers: users));
    } on ApiException catch (e) {
      emit(UsersError(e.message));
    } catch (e) {
      emit(UsersError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  //Handler for search user
  void _onSearchUsers(SearchUsers event, Emitter<UserState> emit) {
    if (state is UsersLoaded) {
      final currentState = state as UsersLoaded;
      final filteredUsers = _userService.searchUsers(_allUsers, event.query);

      emit(
        currentState.copyWith(
          filteredUsers: filteredUsers,
          searchQuery: event.query,
        ),
      );
    }
  }

  //Handler for add user
  Future<void> _onAddUser(AddUser event, Emitter<UserState> emit) async {
    emit(const UserAdding());

    try {
      final newUser = await _userService.addUser(event.user);
      _allUsers.add(newUser);

      emit(UserAdded(newUser));

      // Refresh the users list
      if (state is UserAdded) {
        final currentQuery =
            state is UsersLoaded ? (state as UsersLoaded).searchQuery : '';
        final filteredUsers = _userService.searchUsers(_allUsers, currentQuery);

        emit(
          UsersLoaded(
            users: _allUsers,
            filteredUsers: filteredUsers,
            searchQuery: currentQuery,
          ),
        );
      }
    } on ApiException catch (e) {
      emit(UserAddError(e.message));
    } catch (e) {
      emit(UserAddError('Failed to add user: ${e.toString()}'));
    }
  }

  //Handler for refresh users
  Future<void> _onRefreshUsers(
    RefreshUsers event,
    Emitter<UserState> emit,
  ) async {
    add(const LoadUsers());
  }
}
