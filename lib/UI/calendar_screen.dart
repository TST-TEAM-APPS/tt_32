import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp_731/BLOC/Bloc_treker/bloc_treker.dart';
import 'package:pp_731/BLOC/Bloc_treker/event_treker.dart';
import 'package:pp_731/BLOC/Bloc_treker/state_treker.dart';

import '../Models/event_widget_model.dart';
import '../style.dart';

class CalendarScreen extends StatelessWidget {
  CalendarScreen({super.key});

  List<DateTime?> _dates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bgColor,
      appBar: AppBar(
        backgroundColor: Style.bgColor,
        // leading: CupertinoButton(
        //   padding: EdgeInsets.all(6),
        //   onPressed: () {
        //     // Navigator.of(context).pop();
        //   },
        //   child: Container(
        //     width: 40,
        //     height: 40,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(15),
        //       color: Colors.white,
        //     ),
        //     child: Icon(
        //       Icons.arrow_back,
        //       color: Colors.black,
        //     ),
        //   ),
        // ),
        title: Text(
          'Schedule',
          style: Style.textStyle,
        ),
      ),
      body: BlocBuilder<TrekerBloc, TrekerState>(
          builder: (context, state) {
          return Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
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
                    _dates = date;
                    if (_dates.isNotEmpty) {
                      context.read<TrekerBloc>().add(FilledEvent(date.first));
                    }
                  },

                ),
              ),
              state.currentEventByDate.isEmpty
                  ? Expanded(child: Container(child: Center(child: Image.asset('Assets/Icons/cal_page.png'))))
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
