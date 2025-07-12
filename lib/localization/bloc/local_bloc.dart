import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'local_event.dart';

part 'local_state.dart';

class LocalBloc extends Bloc<LocaleEvent, LocalState> {
  LocalBloc() : super(const LocalState(Locale('en'))) {
    on<ChangeLocaleEvent>((event, emit) {
      emit(LocalState(Locale(event.languageCode)));
    });
  }
}
