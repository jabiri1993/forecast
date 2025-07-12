import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../localization/bloc/local_bloc.dart';

class FunctionUtils {
  static changeLanguage(BuildContext context) {
    final localeBloc = context.read<LocalBloc>();
    localeBloc.add(ChangeLocaleEvent(
        localeBloc.state.locale.languageCode == 'en' ? 'fr' : 'en'));
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600;
  }
}
