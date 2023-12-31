class ResultApi<T> {
  final T value;
  final bool isError;
  ResultApi({
    required this.isError,
    required this.value,
  });
}
