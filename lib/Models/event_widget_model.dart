import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pp_731/style.dart';
import 'package:intl/intl.dart';
import '../Repo/event_repo.dart';
import '../UI/event_info.dart';
import 'event_model.dart';

class EventWidgetModel extends StatefulWidget {
  final List<Event> filteredEvents;

  const EventWidgetModel({super.key, required this.filteredEvents});

  @override
  State<EventWidgetModel> createState() => _EventWidgetModelState();
}

class _EventWidgetModelState extends State<EventWidgetModel> {
  final EventRepository eventRepository = EventRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Event>>(
        future: eventRepository.getEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tasks available.'));
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: widget.filteredEvents.length,
            itemBuilder: (context, index) {
              final event = widget.filteredEvents[index];
              return Container(
                width: double.infinity,
                height: 143,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${DateFormat('MMM').format(event.dueDate)}',
                            style: Style.textStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            event.dueDate.day.toString(),
                            style: Style.textStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${DateFormat('dd, MMM, yyyy').format(event.dueDate)}',
                            style: Style.textStyle.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: double.infinity,
                            height: 104,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          event.title,
                                          maxLines: 2, 
                                          overflow: TextOverflow.ellipsis,
                                          style: Style.textStyle,
                                        ),
                                      ),
                                      CupertinoButton(
                                        child: SvgPicture.asset(
                                            'Assets/Icons/more.svg'),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => InfoEvent(
                                              event: event,
                                              title: event.title,
                                              location: event.location,
                                              date: event.dueDate,
                                              startTime: event.startTime,
                                              endTime: event.endTime,
                                              tag: event.tag,
                                              description: event.description,
                                            ),
                                          ));
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'Assets/Icons/часы.svg'),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              '${event.startTime.toString()} - ${event.endTime.toString()}'),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        height: 26,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(240, 134, 122, 1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: Text(
                                            event.tag,
                                            style: Style.textStyle.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
