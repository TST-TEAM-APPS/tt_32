import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:party_planner/BLOC/Bloc_treker/bloc_treker.dart';
import 'package:party_planner/BLOC/Bloc_treker/event_treker.dart';
import 'package:party_planner/Repo/event_repo.dart';

class FilterModel extends StatefulWidget {
  FilterModel({super.key});

  @override
  State<FilterModel> createState() => _FilterModelState();
}

class _FilterModelState extends State<FilterModel> {
  final EventRepository eventRepository = EventRepository();
  final List<String> filters = [
    'Family',
    'Friends',
    'Holidays',
    'Birthdays',
    'Sports',
    'Travel',
    'Workshops',
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (selectedIndex == index) {
                    selectedIndex = -1;
                    context.read<TrekerBloc>().add(LoadEvent());
                  } else {
                    selectedIndex = index;
                    context.read<TrekerBloc>().add(FilledByTagEvent(filters[index]));
                  }
                });
              },
              child: Container(
                width: 101,
                height: 37,
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? Color.fromRGBO(240, 134, 122, 1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                child: Text(
                  filters[index],
                  style: TextStyle(
                    color: selectedIndex == index ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
