import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:party_planner/style.dart';
import 'package:intl/intl.dart';
import '../Models/event_model.dart';
import 'edit_event.dart';

class InfoEvent extends StatefulWidget {
  final Event event;
  final String title;
  final String location;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String tag;
  final String description;

  const InfoEvent({
    super.key,
    required this.title,
    required this.location,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.tag,
    required this.description,
    required this.event,
  });

  @override
  State<InfoEvent> createState() => _InfoEventState();
}

class _InfoEventState extends State<InfoEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bgColor,
      appBar: AppBar(
        backgroundColor: Style.bgColor,
        leading: CupertinoButton(
          padding: EdgeInsets.all(6),
          onPressed: () {
            Navigator.of(context).pop();
            ;
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          'Event Details',
          style: Style.textStyle,
        ),
        actions: [
          CupertinoButton(
            padding: EdgeInsets.all(6),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditEvent(
                  event: widget.event,
                  title: widget.event.title,
                  location: widget.event.location,
                  date: widget.event.dueDate,
                  startTime: widget.event.startTime,
                  endTime: widget.event.endTime,
                  tag: widget.event.tag,
                  description: widget.event.description,
                ),
              ));
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                widget.title,
                style: Style.textStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: Colors.black),
              ),
            ),
            widget.location.isNotEmpty
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Location',
                              style: Style.textStyle.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color.fromRGBO(52, 52, 52, 1)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            SvgPicture.asset('Assets/Icons/Primary.svg'),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.location,
                              style: Style.textStyle.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color.fromRGBO(52, 52, 52, 1)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    height: 0,
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                'Date',
                style: Style.textStyle.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color.fromRGBO(52, 52, 52, 1)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('Assets/Icons/calendar-2.svg'),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${widget.startTime}-${widget.endTime}, ${DateFormat('dd MMM yyyy').format(widget.date)}",
                      style: Style.textStyle.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color.fromRGBO(52, 52, 52, 1)),
                    ),
                  ],
                ),
                Container(
                  // width: 64,
                  height: 26,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(240, 134, 122, 1),
                  ),
                  child: Center(
                    child: Text(
                      widget.tag,
                      style: Style.textStyle.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            widget.description.isNotEmpty
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text('About Event',
                                style: Style.textStyle
                                    .copyWith(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.description,
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                style: Style.textStyle.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color.fromRGBO(52, 52, 52, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
