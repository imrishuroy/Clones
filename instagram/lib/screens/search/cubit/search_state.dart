part of 'search_cubit.dart';

enum SearchStatus { initial, loading, loaded, error }

class SearchState extends Equatable {
  final List<AppUser?> users;
  final SearchStatus status;
  final Failure failure;

  const SearchState({
    required this.users,
    required this.status,
    required this.failure,
  });

  factory SearchState.initial() {
    return const SearchState(
      users: [],
      status: SearchStatus.initial,
      failure: Failure(),
    );
  }

  @override
  List<Object> get props => [users, status, failure];

  SearchState copyWith({
    List<AppUser?>? users,
    SearchStatus? status,
    Failure? failure,
  }) {
    return SearchState(
      users: users ?? this.users,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
