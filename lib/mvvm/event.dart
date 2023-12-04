
abstract class Event {
  final String qualifier;

  const Event(this.qualifier);

  @override
  String toString() {
    return 'ViewEvent{qualifier: $qualifier}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Event &&
              runtimeType == other.runtimeType &&
              qualifier == other.qualifier;

  @override
  int get hashCode => super.hashCode;


}