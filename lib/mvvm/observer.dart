import 'event.dart';

abstract class Observer {
  const Observer();

  void notify(Event event);
}
