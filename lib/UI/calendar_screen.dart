import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp_731/BLOC/Bloc_treker/bloc_treker.dart';
import 'package:pp_731/BLOC/Bloc_treker/event_treker.dart';
import 'package:pp_731/BLOC/Bloc_treker/state_treker.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../Models/event_widget_model.dart';
import '../style.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<DateTime?> _dates = [];

  String? selectedValue;

  final List<String> options = [
    'All',
    'Family',
    'Friends',
    'Holidays',
    'Birthdays',
    'Sports',
    'Travel',
    'Workshops',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bgColor,
      appBar: AppBar(
        backgroundColor: Style.bgColor,
        title: Text(
          'Schedule',
          style: Style.textStyle,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PullDownButton(
              buttonBuilder: (context, showMenu) => CupertinoButton(
                padding: EdgeInsets.zero,
                minSize: 1,
                child: Icon(Icons.more_horiz, color: Colors.black),
                onPressed: showMenu,
              ),
              itemBuilder: (context) => options.map<PullDownMenuItem>((value) {
                return PullDownMenuItem.selectable(
                  onTap: () {
                    setState(() {
                      selectedValue = value;
                    });
                    if (_dates.isNotEmpty) {
                      if (selectedValue == 'All') {
                        context
                            .read<TrekerBloc>()
                            .add(FilledEvent(_dates.first!));
                      } else {
                        context.read<TrekerBloc>().add(FilledByDateAndTagEvent(
                            selectedValue!, _dates.first!));
                      }
                    }
                  },
                  title: value,
                  selected: selectedValue == value,
                );
              }).toList(),
            ),
          ),
        ],
      ),
      body: BlocBuilder<TrekerBloc, TrekerState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(13.0),
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                height: 316,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: CalendarDatePicker2(
                  config: CalendarDatePicker2WithActionButtonsConfig(
                    dayTextStyle: Style.textStyle.copyWith(
                      fontSize: 14,
                    ),
                    selectedDayTextStyle: Style.textStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    selectedDayHighlightColor: Color.fromRGBO(240, 134, 122, 1),
                  ),
                  value: _dates,
                  onValueChanged: (date) {
                    setState(() {
                      _dates = date;
                    });
                    if (_dates.isNotEmpty) {
                      if (selectedValue == 'All' || selectedValue == null) {
                        context.read<TrekerBloc>().add(FilledEvent(date.first));
                      } else if (selectedValue != null) {
                        context.read<TrekerBloc>().add(FilledByDateAndTagEvent(
                            selectedValue!, date.first));
                      }
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              state.currentEventByDate.isEmpty
                  ? Expanded(
                      child: Container(
                        child: Center(
                          child: Image.asset('Assets/Icons/cal_page.png'),
                        ),
                      ),
                    )
                  : Expanded(
                      child: EventWidgetModel(
                        filteredEvents: state.currentEventByDate,
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }
}
