
part of 'local_bloc.dart';

abstract class LocaleEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeLocaleEvent extends LocaleEvent {
  final String languageCode;

  ChangeLocaleEvent(this.languageCode);

  @override
  List<Object?> get props => [languageCode];
}
