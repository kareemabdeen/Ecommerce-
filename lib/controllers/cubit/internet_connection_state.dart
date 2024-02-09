part of 'internet_connection_cubit.dart';

sealed class InternetConnectionState {}

final class InternetConnectionInitial extends InternetConnectionState {}

final class IternetConnectedState extends InternetConnectionState {
  final String internetState;

  IternetConnectedState({required this.internetState});
}

final class IternetNotConnectedState extends InternetConnectionState {
  final String internetState;

  IternetNotConnectedState({required this.internetState});
}
