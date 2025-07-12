extension StringExtensions on String {
  String get capitalize {
    if (isEmpty) {
      return this;
    }
    return split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1)}'
            : '')
        .join(' ');
  }
}
