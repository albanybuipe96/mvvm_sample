import 'observer.dart';
import 'event.dart';

abstract class EventViewModel {
  final List<Observer> _observers = List.empty(growable: true);

  void subscribe(Observer o) {
    if (_observers.contains(o)) return;
    _observers.add(o);
  }

  bool unsubscribe(Observer o) {
    if (_observers.contains(o)) return _observers.remove(o);
    return false;
  }

  void notify(Event event) {
    for (var observer in _observers) {
      observer.notify(event);
    }
  }
}
