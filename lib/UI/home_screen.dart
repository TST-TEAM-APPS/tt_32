import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp_731/BLOC/Bloc_treker/bloc_treker.dart';
import 'package:pp_731/BLOC/Bloc_treker/state_treker.dart';
import 'package:pp_731/Models/upcoming_model.dart';
import 'package:pp_731/style.dart';
import '../BLOC/Bloc_treker/event_treker.dart';
import '../Models/event_filter.dart';
import '../Models/event_widget_model.dart';
import 'calendar_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bgColor,
      body: BlocBuilder<TrekerBloc, TrekerState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Today is',
                      style: Style.textStyle.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color.fromRGBO(52, 52, 52, 1),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('dd, MMMM').format(DateTime.now()).toString(),
                      style: Style.textStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color.fromRGBO(52, 52, 52, 1),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: EasyDateTimeLine(
                  initialDate: DateTime.now(),
                  onDateChange: (date) {
                    context.read<TrekerBloc>().add(FilledEvent(date));
                  },
                  headerProps: EasyHeaderProps(
                    showHeader: false,
                  ),
                  dayProps: const EasyDayProps(
                    inactiveDayStyle: DayStyle(
                        borderRadius: 15.0,
                        dayStrStyle: TextStyle(
                          color: Color.fromRGBO(240, 134, 122, 1),
                        )),
                    width: 40,
                    height: 52,
                    dayStructure: DayStructure.dayStrDayNum,
                    activeDayStyle: DayStyle(
                        borderRadius: 25.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color.fromRGBO(240, 134, 122, 1),
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Upcoming Events',
                      style: Style.textStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CalendarScreen()));
                      },
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Text(
                            'View all',
                            style: Style.textStyle.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Style.textStyle.color,
                            size: 18,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              state.currentEventByDate.isEmpty
                  ? Container(
                      height: 180,
                      child: Image.asset('Assets/Icons/upcoming.png'))
                  : Container(
                      height: 180,
                      child: Expanded(
                        child: UpcomingModel(
                          filteredEvents: state.currentEventByDate,
                        ),
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Events',
                    style: Style.textStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  CupertinoButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: Row(
                      children: [
                        Text(
                          'View all',
                          style: Style.textStyle.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Style.textStyle.color,
                          size: 18,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                height: 57,
                child: Expanded(
                  child: FilterModel(),
                ),
              ),
              state.currentEventByTag.isEmpty
                  ? Expanded(
                    child: Container(
                        child:
                            Center(child: Image.asset('Assets/Icons/events.png'))),
                  )
                  : Expanded(
                    child: EventWidgetModel(
                      filteredEvents: state.currentEventByTag,
                    ),
                  ),
            ],
          ),
        );
      }),
    );
  }
}
