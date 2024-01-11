import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../utils/utils.dart';

/// A widget that displays a button for switching to the previous or next month.
class EasyMonthSwitcher extends StatefulWidget {
  const EasyMonthSwitcher({
    super.key,
    required this.locale,
    required this.value,
    this.onMonthChange,
    this.firstDateMonth,
    this.style,
  });

  /// A `String` that represents the locale code to use for formatting the month name in the switcher.
  final String locale;

  /// The currently selected month.
  final EasyMonth? value;

  /// A callback function that is called when the selected month changes.
  final OnMonthChangeCallBack? onMonthChange;

  /// The text style applied to the month string.
  final TextStyle? style;

  final DateTime? firstDateMonth;

  @override
  State<EasyMonthSwitcher> createState() => _EasyMonthSwitcherState();
}

class _EasyMonthSwitcherState extends State<EasyMonthSwitcher> {
  List<EasyMonth> _yearMonths = [];
  int _currentMonth = 0;
  bool isNextMonth = false;
   int _currentYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    _yearMonths = EasyDateUtils.getYearMonths(DateTime.now(), widget.locale);
    _currentMonth = widget.value != null ? ((widget.value!.vale - 1)) : 0;
  }

  bool get _isLastMonth => _currentMonth == _yearMonths.length - 1;
  bool get _isFirstMonth => _currentMonth == 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.firstDateMonth!.month != _yearMonths[_currentMonth].vale ?  InkWell(
          onTap: () {
                if (_isFirstMonth) {
                  _currentYear = _currentYear - 1;
                  _currentMonth = 12;
                  _yearMonths = EasyDateUtils.getYearMonths(DateTime(_currentYear), widget.locale);
                  _currentMonth--;
                  widget.onMonthChange?.call(_yearMonths[_currentMonth]);
                } else {
                  _currentMonth--;
                  widget.onMonthChange?.call(_yearMonths[_currentMonth]);
                }
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xCC651C32),
            size: 16,
          ),
        ) : SizedBox(),
        SizedBox(width: 3,),
        Text(
          _yearMonths[_currentMonth].name,
          textAlign: TextAlign.center,
          style: widget.style,
        ),
        SizedBox(width: 3,),
        Text(
          _currentYear.toString(),
          textAlign: TextAlign.center,
          style: widget.style,
        ),
        SizedBox(width: 3,),
        DateTime.now().month != _yearMonths[_currentMonth].vale ?
        InkWell(
          onTap: () {
            if(_currentYear != DateTime.now().year && _currentYear <= DateTime.now().year){
              if (_isLastMonth) {
                _currentYear = _currentYear + 1;
                _currentMonth = -1;
                _yearMonths = EasyDateUtils.getYearMonths(DateTime(_currentYear), widget.locale);
                _currentMonth++;
                widget.onMonthChange?.call(_yearMonths[_currentMonth]);
              } else {
                _currentMonth++;
                widget.onMonthChange?.call(_yearMonths[_currentMonth]);
              }
            }
          },
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Color(0xCC651C32),
          ),
        ) : SizedBox(),
      ],
    );
  }
}
