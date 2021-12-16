import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

DateTime selectedtime = DateTime.now();

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;

  @override
  BookAppointmentState createState() => BookAppointmentState();
}

class BookAppointmentState extends State<BookAppointment> {
  bool selected=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Book an appointment in a bit")
        ],
      ),
      // body: Column(
      //   children: [
      //     SizedBox(
      //         width: 300,
      //         height: 40,
      //         child: ListTile(
      //             tileColor: Colors.grey,
      //             autofocus: true,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(30),
      //             ),
      //             title: Text(selectedtime.toString()),
      //             trailing: PickDate())),
      //     SizedBox(
      //       width: 300,
      //       height: 40,
      //       child: ListTile(
      //           tileColor: Colors.blue,
      //           autofocus: true,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(30),
      //           ),
      //           title: Text(
      //             "Please pick a time for this date",
      //             style: TextStyle(color: Colors.white),
      //           ),
      //           trailing: IconButton(
      //               onPressed: () {
      //                 showTimePicker(
      //                     context: context, initialTime: TimeOfDay.now());
      //               },
      //               icon: FaIcon(FontAwesomeIcons.solidClock))),
      //     ),
      //     Text(
      //       "Services you would like to have",
      //       style: TextStyle(color: Colors.black),
      //     ),
      //     Wrap(
      //       children: [
      //         CheckboxListTile(
      //           title:Text("Hair Cut"),
      //             value: selected,
      //             onChanged: (state) {
      //               setState(() {
      //                 selected = state!;
      //               });
      //             }),
      //             CheckboxListTile(
      //           title:Text("Beard"),
      //             value: selected,
      //             onChanged: (state) {
      //               setState(() {
      //                 selected = state!;
      //               });
      //             }),
      //             CheckboxListTile(
      //           title:Text("Shape Up"),
      //             value: selected,
      //             onChanged: (state) {
      //               setState(() {
      //                 selected = state!;
      //               });
      //             }),
      //       ],
      //     )
      //   ],
      // ),
    );
  }
}

class PickDate extends StatefulWidget {
  const PickDate({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;

  @override
  PickDateState createState() => PickDateState();
}

class PickDateState extends State<PickDate> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime(2021));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2022, 1, 1),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        // time = DateTime(_selectedDate.value.year, _selectedDate.value.month,
        //     _selectedDate.value.day);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FloatingActionButton.extended(
      heroTag: "date",
      onPressed: () {
        _restorableDatePickerRouteFuture.present();
      },
      label: const Text('Date'),
      icon: Icon(Icons.calendar_today),
    ));
  }
}
