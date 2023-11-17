import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/provider/regist_provider.dart';
import 'package:provider/provider.dart';
class DateInput extends StatefulWidget {
  const DateInput({super.key, required this.type});
  final String type;
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: WHITE_COLOR,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                final date = await showDatePickerDialog(
                  // barrierColor: Colors.transparent,
                  disbaledCellColor: BLUE_BLACK_COLOR,
                  enabledCellTextStyle: TextStyle(fontSize: 12),
                  currentDateTextStyle: TextStyle(fontSize: 12, color: DARKER_BLUE_COLOR),
                  currentDateDecoration: BoxDecoration(color: Colors.transparent, shape: BoxShape.circle, border: Border.all(color: DARKER_BLUE_COLOR)),
                  selectedCellTextStyle: TextStyle(fontSize: 12),
                  selectedCellDecoration: BoxDecoration(color: BLUE_COLOR, shape: BoxShape.circle),
                  padding: EdgeInsets.symmetric(horizontal: 48),
                  leadingDateTextStyle: TextStyle(color: DARKEST_BLUE_COLOR, fontFamily: 'EsamanruMedium', fontSize: 16),
                  contentPadding: EdgeInsets.all(24),
                  daysNameTextStyle: TextStyle(fontSize: 11, color: DARKER_GREY_COLOR),
                  slidersColor: DARKER_GREY_COLOR,
                  context: context,
                  initialDate: DateTime.now(),
                  maxDate: DateTime.now().add(const Duration(days: 365 * 3)),
                  minDate:
                  DateTime.now().subtract(const Duration(days: 365 * 3)),
                );
                if (date != null) {
                  setState(() {
                    if (widget.type == 'start'){
                      Provider.of<RegistProvider>(context, listen: false).setStart(DateFormat('yyyy-MM-ddT').format(date));
                    } else {
                      Provider.of<RegistProvider>(context, listen: false).setEnd(DateFormat('yyyy-MM-ddT').format(date));
                    }
                    initialdate = DateFormat('yyyy년 MM월 dd일').format(date);
                    // selectedDate = date;
                  });
                }
              },
              child: Text(initialdate,
                style: TextStyle(
                  color: BLUE_BLACK_COLOR,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        );

  }
}