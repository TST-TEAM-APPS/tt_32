
import '../../Models/event_model.dart';

abstract class TrekerEvent {}

class LoadEvent extends TrekerEvent {}

class AddEvent extends TrekerEvent {
  final Event event;

  AddEvent(this.event);
}

class UpdateEvent extends TrekerEvent {
  final Event event;

  UpdateEvent(this.event);
}

class FilledEvent extends TrekerEvent {
  final DateTime date;

  FilledEvent(this.date);
}

class FilledByTagEvent extends TrekerEvent {
  final String tag;

  FilledByTagEvent(this.tag);
}
class FilledByDateAndTagEvent extends TrekerEvent {
  final String tag;
  final DateTime date;


  FilledByDateAndTagEvent(this.tag, this.date);
}

class SearchEvent extends TrekerEvent {
  final String text;

  SearchEvent(this.text);
}



class DeleteEvent extends TrekerEvent {
  final Event event;

  DeleteEvent(this.event);
}
