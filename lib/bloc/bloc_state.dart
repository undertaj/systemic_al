
part of 'bloc_cubit.dart';



@immutable
abstract class PageState {}

class PageInitial extends PageState {}

class PageLoading extends PageState {}

class PageLoaded extends PageState {
  final List<int> pages;
  bool startedTimer;
  PageLoaded(this.pages, {this.startedTimer = false});
}

