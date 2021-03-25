part of 'main_bloc.dart';

enum MainStatus {initial,loading, loaded}

class MainState extends Equatable{
  final List<MusicListModel> lists;
  final MainStatus status;

  const MainState({
    this.lists = const <MusicListModel> [],
    this.status = MainStatus.initial,
  });

  MainState copyWith({
    MainStatus status,
    List<MusicListModel> lists,
  }){
    return MainState(
      status: status ?? this.status,
      lists : lists ?? this.lists,
    );
  }

  @override
  List<Object> get props => [lists, status];
}

