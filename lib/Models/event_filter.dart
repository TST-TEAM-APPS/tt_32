import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp_731/BLOC/Bloc_treker/bloc_treker.dart';
import 'package:pp_731/BLOC/Bloc_treker/event_treker.dart';
import 'package:pp_731/BLOC/Bloc_treker/state_treker.dart';
import 'package:pp_731/Models/event_model.dart';
import 'package:pp_731/Repo/event_repo.dart';

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
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index; // Update the selected index
                });
                context
                    .read<TrekerBloc>()
                    .add(FilledByTagEvent(filters[index]));
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