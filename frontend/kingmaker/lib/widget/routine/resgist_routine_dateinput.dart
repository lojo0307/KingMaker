import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class DateInput extends StatefulWidget {
  const DateInput({super.key});

  @override
  State<DateInput> createState() => _DateInput();
}

class _DateInput extends State<DateInput> {
  DateTime? selectedDate;
  var initialdate ='----년 --월 --일';
  @override
  Widget build(BuildContext context) {
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedDate != null)
              Text(DateFormat(
                'MMM dd, yy',
              ).format(selectedDate!)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(13),
                ),

              ),
              onPressed: () async {
                final date = await showDatePickerDialog(
                  context: context,
                  initialDate: DateTime.now(),
                  maxDate: DateTime.now().add(const Duration(days: 365 * 3)),
                  minDate:
                  DateTime.now().subtract(const Duration(days: 365 * 3)),
                );
                if (date != null) {
                  setState(() {
                    initialdate = DateFormat('yyyy년 MM월 dd일').format(date);

                    // selectedDate = date;
                  });
                }
              },
              child: Text(initialdate,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );

  }
}