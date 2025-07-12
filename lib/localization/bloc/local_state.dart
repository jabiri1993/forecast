part of 'local_bloc.dart';

class LocalState extends Equatable {
  final Locale locale;

  const LocalState(this.locale);

  @override
  List<Object?> get props => [locale];
}
