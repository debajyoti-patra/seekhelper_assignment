import 'package:equatable/equatable.dart';
import '../../model/user_model.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

//Event for load users from api
class LoadUsers extends UserEvent {
  const LoadUsers();
}

//Event for search users
class SearchUsers extends UserEvent {
  final String query;

  const SearchUsers(this.query);

  @override
  List<Object> get props => [query];
}

//Event for add user
class AddUser extends UserEvent {
  final User user;

  const AddUser(this.user);

  @override
  List<Object> get props => [user];
}

//Event for refresh users
class RefreshUsers extends UserEvent {
  const RefreshUsers();
}
