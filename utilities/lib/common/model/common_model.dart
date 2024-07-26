class KeyValuePair<T, R> {
  KeyValuePair({
    required this.key,
    required this.value,
    this.path,
  });

  final T key;
  final R value;
  final String? path;
}
