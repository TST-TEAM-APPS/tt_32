import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:party_planner/BLOC/Bloc_treker/event_treker.dart';
import 'package:party_planner/BLOC/Bloc_treker/state_treker.dart';
import 'package:party_planner/style.dart';

import '../BLOC/Bloc_treker/bloc_treker.dart';
import '../Models/event_widget_model.dart';

class AllEvents extends StatefulWidget {
  const AllEvents({super.key});

  @override
  State<AllEvents> createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
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
    return BlocBuilder<TrekerBloc, TrekerState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Style.bgColor,
        appBar: AppBar(
          backgroundColor: Style.bgColor,
          title: Text(
            'Events',
            style: Style.textStyle,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                dropdownColor: Colors.white,
                icon: Icon(Icons.more_horiz, color: Colors.black),
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });

                  if (selectedValue == 'All') {
                    context.read<TrekerBloc>().add(LoadEvent());
                  } else {
                    context
                        .read<TrekerBloc>()
                        .add(FilledByTagEvent(selectedValue!));
                  }
                },
                items: options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: Style.textStyle,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        body: state.currentEventByTag.isEmpty
            ? Center(
                child: Image.asset('Assets/Icons/events.png'),
              )
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: EventWidgetModel(
                      filteredEvents: state.currentEventByTag,
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
