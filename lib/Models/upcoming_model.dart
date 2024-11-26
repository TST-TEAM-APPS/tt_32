import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:party_planner/style.dart';
import 'package:intl/intl.dart';
import '../Repo/event_repo.dart';
import '../UI/event_info.dart';
import 'event_model.dart';

class UpcomingModel extends StatefulWidget {
  final List<Event> filteredEvents;

  UpcomingModel({super.key, required this.filteredEvents});

  @override
  State<UpcomingModel> createState() => _UpcomingModelState();
}

class _UpcomingModelState extends State<UpcomingModel> {
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
            scrollDirection: Axis.horizontal,
            itemCount: widget.filteredEvents.length,
            itemBuilder: (context, index) {
              final event = widget.filteredEvents[index];
              return Container(
                width: 270,
                height: 146,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(240, 134, 122, 1),
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: EdgeInsets.all(16),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          event.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 2, // Set the maximum number of lines
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Date: ${DateFormat('dd, MMM, yyyy').format(event.dueDate)}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                // width: 59,
                                height: 26,
                                // margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    event.tag,
                                    style: Style.textStyle.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: CupertinoButton(
                        child: SvgPicture.asset(
                          'Assets/Icons/more.svg',
                          color: Colors.white,
                          width: 20,
                          height: 20,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
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
                        padding: EdgeInsets.zero,
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
