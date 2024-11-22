import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pp_731/BLOC/Bloc_treker/bloc_treker.dart';
import 'package:pp_731/BLOC/Bloc_treker/event_treker.dart';
import 'package:pp_731/Models/event_model.dart';
import 'package:pp_731/Widgets/bottom_navigation_bar.dart';
import 'package:pp_731/style.dart';
import 'package:pull_down_button/pull_down_button.dart';
class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  bool _lights = false;

  List<DateTime?> _dates = [];

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final TextEditingController _tagsController =
      TextEditingController(text: 'Birthdays');

  void _onMenuItemSelected(String tag) {
    _tagsController.text = tag;
    _updateButtonState();
  }



  Future<void> _addTask(BuildContext context) async {
    final title = _titleController.text;
    final dueDate = DateTime.tryParse(_dateController.text);
    final description = _descriptionController.text;
    final startFormatTime = _startTimeController.text;
    final endFormatTime = _endTimeController.text;
    final tag = _tagsController.text;
    final location = _locationController.text;

    if (title.isNotEmpty &&
        dueDate != null &&
        startFormatTime.isNotEmpty &&
        endFormatTime.isNotEmpty) {
      final event = Event(
        title: title,
        dueDate: dueDate,
        description: description,
        startTime: startFormatTime,
        endTime: endFormatTime,
        tag: tag,
        location: location,
      );
      context.read<TrekerBloc>().add(AddEvent(event));
      await Future.delayed(Duration(milliseconds: 100));
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChangeBodies(),
        ),
      );
      _titleController.clear();
      _descriptionController.clear();
      _dateController.clear();
      _startTimeController.clear();
      _endTimeController.clear();
      _tagsController.clear();
      _locationController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пожалуйста, заполните все поля корректно.')),
      );
    }
  }

  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  bool _isButtonEnabled = false;

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _titleController.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty &&
          _tagsController.text.isNotEmpty &&
          _endTimeController.text.isNotEmpty &&
          _startTimeController.text.isNotEmpty &&
          _isValidDate(_dateController.text);
    });
  }

  bool _isValidDate(String date) {
    try {
      DateFormat('yyyy-MM-dd').parseStrict(date);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.bgColor,
        title: Text(
          'Create Event',
          style: Style.textStyle,
        ),
      ),
      backgroundColor: Style.bgColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
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
            Expanded(
              child: TextField(
                controller: _titleController,
                onChanged: (value) => _updateButtonState(),
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(241, 242, 246, 1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  hintText: 'Title',
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
            Expanded(
              child: TextField(
                controller: _descriptionController,
                onChanged: (value) => _updateButtonState(),
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(241, 242, 246, 1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.black, // Черная рамка
                      width: 2.0, // Ширина рамки
                    ),
                  ),
                  hintText: 'Description',
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
            Expanded(
              child: TextField(
                controller: _dateController,
                onChanged: (value) => _updateButtonState(),
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
                  hintText: 'Date',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
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
                          onChanged: (value) => _updateButtonState(),
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
                              child:
                                  SvgPicture.asset('Assets/Icons/calendar.svg'),
                            ),
                            hintText: 'Start Time',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
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
                          onChanged: (value) => _updateButtonState(),
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
                              child:
                                  SvgPicture.asset('Assets/Icons/calendar.svg'),
                            ),
                            hintText: 'End Time',
                          ),
                        ),
                      ],
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
                    onChanged: (value) => _updateButtonState(),
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
                      hintText: 'Date of project fulfilment',
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
            Expanded(
              child: TextField(
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
                    onPressed: () {

                    },
                    child: SvgPicture.asset('Assets/Icons/search.svg'),
                  ),
                  hintText: 'location',
                ),
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.symmetric(
                vertical: 40,
              ),
              onPressed: _isButtonEnabled ? () => _addTask(context) : null,
              child: Container(
                width: 225,
                height: 48,
                decoration: BoxDecoration(
                  color: Style.textStyle.color,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Text(
                    'Create Task',
                    style: Style.textStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
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
    final TimeOfDay? picked = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.inputOnly,
      context: context,
      initialTime: selectedStartTime,
    );

    if (picked != null && picked != selectedStartTime) {
      setState(() {
        selectedStartTime = picked;
        _startTimeController.text =
        '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.inputOnly,
      context: context,
      initialTime: selectedEndTime,
    );

    if (picked != null && picked != selectedEndTime) {
      // Convert selected times to DateTime for comparison
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
    }
  }

}