import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_connection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  InternetConnectionCubit() : super(InternetConnectionInitial());

  StreamSubscription<ConnectivityResult>? subscription;
  void checkInternetConnectivityStatus() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!

      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        emit(IternetConnectedState(internetState: "Internet is connected"));
      } else {
        emit(
          IternetNotConnectedState(internetState: "Internet Not connected"),
        );
      }
    });
  }

//super.close(); and super.dispose();
//In summary, dispose() is a more general method used for cleanup in Flutter,
// while .cancel() is a specific method used to cancel a subscription to a stream.
// Both are used to release resources and perform cleanup,
// but they are used in different contexts.
  @override
  Future<void> closeSubscribtion() {
    log('ana b2ffffl');
    subscription?.cancel();
    return super.close();
  }
}
