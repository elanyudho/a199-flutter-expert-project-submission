import 'package:equatable/equatable.dart';

abstract class DefaultState extends Equatable {}

class EmptyState extends DefaultState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends DefaultState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends DefaultState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class HasListDataState<T> extends DefaultState {
  final List<T> result;

  HasListDataState(this.result);

  @override
  List<Object> get props => [result];
}

class HasObjectDataState<T> extends DefaultState {
  final T result;

  HasObjectDataState(this.result);

  @override
  List<Object> get props => [result as Object];
}

class HasBoolDataState extends DefaultState {
  final bool result;

  HasBoolDataState(this.result);

  @override
  List<Object?> get props => [result];
}

class HasMessageDataState extends DefaultState {
  final String result;

  HasMessageDataState(this.result);

  @override
  List<Object?> get props => [result];
}
