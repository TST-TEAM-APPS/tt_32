import 'package:pp_731/Models/event_model.dart';

class TrekerState {
  final DateTime? currentDateTime;
  final String? currentTag;
  final List<Event> currentEventByDate;
  final List<Event> currentEventByTag;
  final List<Event> event;
  final bool isLoading;
  final String? error;

  TrekerState({
    required this.currentEventByTag,
    this.currentDateTime,
    this.currentTag,
    required this.event,
    required this.currentEventByDate,
    this.isLoading = false,
    this.error,
  });

  factory TrekerState.initial() {
    return TrekerState(
      event: [],
      isLoading: false,
      error: null,
      currentEventByDate: [],
      currentEventByTag: [],
    );
  }

  TrekerState copyWith({
    DateTime? currentDateTime,
    List<Event>? currentEventByDate,
    List<Event>? currentEventByTag,
    String? currentTag,
    List<Event>? event,
    bool? isLoading,
    String? error,
  }) {
    return TrekerState(
      currentDateTime: currentDateTime ?? this.currentDateTime,
      currentEventByDate: currentEventByDate ?? this.currentEventByDate,
      currentEventByTag: currentEventByTag?? this.currentEventByTag,
      currentTag: currentTag ?? this.currentTag,
      event: event ?? this.event,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}


