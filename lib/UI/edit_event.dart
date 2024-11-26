import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:party_planner/BLOC/Bloc_treker/state_treker.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:intl/intl.dart';
import '../BLOC/Bloc_treker/bloc_treker.dart';
import '../BLOC/Bloc_treker/event_treker.dart';
import '../Models/event_model.dart';
import '../Widgets/bottom_navigation_bar.dart';
import '../style.dart';

class EditEvent extends StatefulWidget {
  final Event event;
  final String title;
  final String location;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String tag;
  final String description;

  const EditEvent({
    super.key,
    required this.event,
    required this.title,
    required this.location,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.tag,
    required this.description,
  });

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  bool _lights = false;

  List<DateTime?> _dates = [];

  late final TextEditingController _dateController;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _startTimeController;
  late final TextEditingController _endTimeController;
  late final TextEditingController _locationController;
  late final TextEditingController _tagsController;

  @override
  void initState() {
    _dateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(widget.date));
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);
    _startTimeController = TextEditingController(text: widget.startTime);
    _endTimeController = TextEditingController(text: widget.endTime);
    _locationController = TextEditingController(text: widget.location);
    _tagsController = TextEditingController(text: widget.tag);
    super.initState();
  }

  void _onMenuItemSelected(String tag) {
    _tagsController.text = tag;
  }

  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.bgColor,
        title: Text(
          'Edit Event',
          style: Style.textStyle,
        ),
        actions: [
          CupertinoButton(
            padding: EdgeInsets.all(6),
            onPressed: () {
              context.read<TrekerBloc>().add(DeleteEvent(widget.event));
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ChangeBodies(),
                ),
              );
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Icon(
                Icons.delete,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Style.bgColor,
      body: BlocBuilder<TrekerBloc, TrekerState>(builder: (context, state) {
        return Expanded(
          child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Title',
                  style: Style.textStyle.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                controller: _titleController,
                maxLines: null,
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(241, 242, 246, 1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Description',
                  style: Style.textStyle.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                controller: _descriptionController,
                maxLines: null,
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(241, 242, 246, 1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Date',
                  style: Style.textStyle.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                controller: _dateController,
                readOnly: true,
                onTap: () async {
                  await _selectDate(context);
                },
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(241, 242, 246, 1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    // Округленные края
                    borderSide: BorderSide(
                      color: Colors.black, // Черная рамка
                      width: 2.0, // Ширина рамки
                    ),
                  ),
                  suffixIcon: CupertinoButton(
                    onPressed: () async {
                      await _selectDate(context);
                    },
                    child: SvgPicture.asset('Assets/Icons/calendar.svg'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start Time',
                              style: Style.textStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _startTimeController,
                              readOnly: true,
                              onTap: () => _selectStartTime(context),
                              decoration: InputDecoration(
                                fillColor: Color.fromRGBO(241, 242, 246, 1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                suffixIcon: CupertinoButton(
                                  onPressed: () => _selectStartTime(context),
                                  child: SvgPicture.asset(
                                      'Assets/Icons/calendar.svg'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'End Time',
                              style: Style.textStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              onTap: () => _selectEndTime(context),
                              readOnly: true,
                              controller: _endTimeController,
                              decoration: InputDecoration(
                                // filled: true,
                                fillColor: Color.fromRGBO(241, 242, 246, 1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  // Округленные края
                                  borderSide: BorderSide(
                                    color: Colors.black, // Черная рамка
                                    width: 2.0, // Ширина рамки
                                  ),
                                ),
                                suffixIcon: CupertinoButton(
                                  onPressed: () => _selectEndTime(context),
                                  child: SvgPicture.asset(
                                      'Assets/Icons/calendar.svg'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Repetition',
                      style: Style.textStyle,
                    ),
                    CupertinoSwitch(
                        thumbColor: _lights == true
                            ? Colors.white
                            : Color.fromRGBO(240, 134, 122, 1),
                        activeColor: Color.fromRGBO(240, 134, 122, 1),
                        value: _lights,
                        onChanged: (bool value) {
                          setState(() {
                            _lights = value;
                          });
                        })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Tags',
                  style: Style.textStyle.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: PullDownButton(
                  itemBuilder: (context) => [
                    PullDownMenuItem(
                      title: 'Family',
                      onTap: () => _onMenuItemSelected(
                        'Family',
                      ),
                    ),
                    PullDownMenuItem(
                      title: 'Friends',
                      onTap: () => _onMenuItemSelected(
                        'Friends',
                      ),
                    ),
                    PullDownMenuItem(
                      title: 'Holidays',
                      onTap: () => _onMenuItemSelected(
                        'Holidays',
                      ),
                    ),
                    PullDownMenuItem(
                      title: 'Birthdays',
                      onTap: () => _onMenuItemSelected(
                        'Birthdays',
                      ),
                    ),
                    PullDownMenuItem(
                      title: 'Sports',
                      onTap: () => _onMenuItemSelected(
                        'Sports',
                      ),
                    ),
                    PullDownMenuItem(
                      title: 'Travel',
                      onTap: () => _onMenuItemSelected(
                        'Travel',
                      ),
                    ),
                    PullDownMenuItem(
                      title: 'Workshops',
                      onTap: () => _onMenuItemSelected(
                        'Workshops',
                      ),
                    ),
                  ],
                  buttonBuilder: (context, showMenu) => CupertinoButton(
                    onPressed: showMenu,
                    padding: EdgeInsets.zero,
                    child: TextField(
                      controller: _tagsController,
                      onTap: showMenu,
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(241, 242, 246, 1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Add location (optional)',
                  style: Style.textStyle.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(241, 242, 246, 1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  suffixIcon: CupertinoButton(
                    onPressed: () {},
                    child: SvgPicture.asset('Assets/Icons/search.svg'),
                  ),
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.symmetric(
                  vertical: 40,
                ),
                onPressed: () {
                  String dateString = _dateController.text;
                  print(dateString);
                  DateFormat format = DateFormat('yyyy-MM-dd');
                  DateTime dueDate = format.parse(dateString);
                  print('sad');
                  context.read<TrekerBloc>().add(
                        AddEvent(
                          widget.event.copyWith(
                            title: _titleController.text.isNotEmpty
                                ? _titleController.text
                                : widget.title,
                            description: _descriptionController.text.isNotEmpty
                                ? _descriptionController.text
                                : widget.description,
                            dueDate: _dateController.text.isNotEmpty
                                ? dueDate
                                : widget.date,
                            startTime: _startTimeController.text.isNotEmpty
                                ? _startTimeController.text
                                : widget.startTime,
                            endTime: _endTimeController.text.isNotEmpty
                                ? _endTimeController.text
                                : widget.endTime,
                            location: _locationController.text.isNotEmpty
                                ? _locationController.text
                                : widget.location,
                            tag: _tagsController.text.isNotEmpty
                                ? _tagsController.text
                                : widget.tag,
                          ),
                        ),
                      );
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => ChangeBodies(),
                    ),
                        (Route<dynamic> route) => false,
                  );

                },
                child: Container(
                  width: 225,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Style.textStyle.color,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text(
                      'Save',
                      style: Style.textStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    var results = await showCalendarDatePicker2Dialog(
      context: context,
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
      dialogSize: const Size(357, 326),
      value: _dates,
      borderRadius: BorderRadius.circular(15),
    );

    if (results != null && results.isNotEmpty) {
      setState(() {
        _dates = results;
        _dateController.text =
            _dates[0]?.toLocal().toString().split(' ')[0] ?? '';
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showCupertinoModalPopup<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        TimeOfDay selectedTime = selectedStartTime;

        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: CupertinoTimerPicker(
                initialTimerDuration: Duration(
                  hours: selectedTime.hour,
                  minutes: selectedTime.minute,
                ),
                onTimerDurationChanged: (Duration newDuration) {
                  selectedTime = TimeOfDay(
                    hour: newDuration.inHours,
                    minute: newDuration.inMinutes.remainder(60),
                  );
                },
                mode: CupertinoTimerPickerMode.hm,
              ),
            ),
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedStartTime = picked;
        _startTimeController.text =
        '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      });
    } else {
      setState(() {
        _startTimeController.text =
        '${selectedStartTime.hour.toString().padLeft(2, '0')}:${selectedStartTime.minute.toString().padLeft(2, '0')}';
      });
    }
  }



  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showCupertinoModalPopup<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        TimeOfDay selectedTime = selectedEndTime;

        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: CupertinoTimerPicker(
                initialTimerDuration: Duration(
                  hours: selectedTime.hour,
                  minutes: selectedTime.minute,
                ),
                onTimerDurationChanged: (Duration newDuration) {
                  selectedTime = TimeOfDay(
                    hour: newDuration.inHours,
                    minute: newDuration.inMinutes.remainder(60),
                  );
                },
                mode: CupertinoTimerPickerMode.hm,
              ),
            ),
          ),
        );
      },
    );

    if (picked != null) {
      final DateTime selectedStartDateTime = DateTime(0, 1, 1, selectedStartTime.hour, selectedStartTime.minute);
      final DateTime selectedEndDateTime = DateTime(0, 1, 1, picked.hour, picked.minute);

      if (selectedEndDateTime.isBefore(selectedStartDateTime)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid Time'),
              content: Text('End time cannot be earlier than or equal to start time.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          selectedEndTime = picked;
          _endTimeController.text =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
        });
      }
    } else {
      setState(() {
        _endTimeController.text =
        '${selectedEndTime.hour.toString().padLeft(2, '0')}:${selectedEndTime.minute.toString().padLeft(2, '0')}';
      });
    }
  }
}
