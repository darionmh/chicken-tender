import 'package:chickentender/Constants.dart';
import 'package:chickentender/Shared/Button.dart';
import 'package:chickentender/Shared/SharedCard.dart';
import 'package:chickentender/styles.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  FocusNode _name = new FocusNode();
  FocusNode _date = new FocusNode();
  FocusNode _time = new FocusNode();
  FocusNode _city = new FocusNode();
  FocusNode _state = new FocusNode();
  TextEditingController _dateController = new TextEditingController();
  TextEditingController _timeController = new TextEditingController();
  MaskTextInputFormatter _dateMaskFormatter;
  MaskTextInputFormatter _timeMaskFormatter;

  String _amPm = 'AM';

  _changeAmPm(val) {
    setState(() {
      _amPm = val;
    });
  }

  _back() {
    Navigator.of(context).pop();
  }

  _buildTile() {
    return SharedCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Seomthing', style: cardBody),
          Switch(
            value: true,
            onChanged: (val) => debugPrint('flick'),
            activeColor: GREEN,
          ),
        ],
      ),
    );
  }

  String _validateDate(value) {
    if (value.isEmpty) {
      return null;
    }
    final components = value.split("/");

    var month;
    var day;
    var year;

    if(components.length > 0) {
      month = int.tryParse(components[0]);
      if(components[0].length == 2 && (month <= 0 || month > 12)) {
        return "invalid date";
      } else if(components.length == 1) {
        return null;
      }
    }

    if(components.length > 1) {
      day = int.tryParse(components[1]);
      if(components[1].length == 2 && (day <= 0 || day > 31)) {
        return "invalid date";
      } else if(components.length == 2) {
        return null;
      }
    }

    if(components.length > 2) {
      year = int.tryParse(components[2]);
    }

    if (components.length == 3) {
      if (day != null && month != null && year != null) {
        final date = DateTime(year, month, day);
        if (date.year == year && date.month == month && date.day == day) {
          return null;
        }
      }
    }
    return "invalid date";
  }

  String _validateTime(value) {
    if (value.isEmpty) {
      return null;
    }
    final components = value.split(":");
    if (components.length > 0) {
      final hour = int.tryParse(components[0]);
      final minute = components.length > 1 ? int.tryParse(components[1]) : null;

      if (components[0].length > 1 && hour != null && hour <= 12 && hour >= 1) {
        if (minute == null) {
          return null;
        } else if (minute != null && minute >= 0 && minute < 60) {
          return null;
        }
      } else if (hour == null || components[0].length == 1) {
        return null;
      }
    }
    return "invalid time";
  }

  @override
  void initState() {
    _name.addListener(() => setState(() {}));
    _date.addListener(() => setState(() {}));
    _time.addListener(() => setState(() {}));
    _city.addListener(() => setState(() {}));
    _state.addListener(() => setState(() {}));

    _dateMaskFormatter = new MaskTextInputFormatter(
        mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

    _timeMaskFormatter = new MaskTextInputFormatter(
      mask: '##:##',
      filter: {"#": RegExp(r'[0-9]')},
    );

    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _date.dispose();
    _time.dispose();
    _city.dispose();
    _dateController.dispose();
    _timeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PURPLE,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: PADDING),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 60, bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Button(
                        onPressed: _back,
                        isPrimary: false,
                        text: 'back',
                      ),
                      Row(
                        children: [
                          Button(
                            onPressed: () => debugPrint('something'),
                            color: GREEN,
                            text: 'create',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  focusNode: _name,
                  textAlign: TextAlign.start,
                  style: cardBody,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: WHITE, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: TRANSPARENT_WHITE, width: 2)),
                    labelText: 'Event Name',
                    labelStyle: _name.hasFocus ? subBody : body,
                  ),
                ),
                SizedBox(height: PADDING),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        focusNode: _date,
                        controller: _dateController,
                        inputFormatters: [_dateMaskFormatter],
                        validator: _validateDate,
                        autovalidateMode: AutovalidateMode.always,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.number,
                        style: cardBody,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: WHITE, width: 2)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: RED, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: TRANSPARENT_WHITE, width: 2)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: RED, width: 2)),
                            labelText: 'Date',
                            labelStyle: _date.hasFocus ? subBody : body,
                            hintText: 'mm/dd/yyyy'),
                      ),
                    ),
                    SizedBox(width: PADDING),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        focusNode: _time,
                        controller: _timeController,
                        inputFormatters: [_timeMaskFormatter],
                        validator: _validateTime,
                        autovalidateMode: AutovalidateMode.always,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.number,
                        style: cardBody,
                        decoration: InputDecoration(
                            suffix: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () => _changeAmPm('AM'),
                                  child: Text('AM',
                                      style: _amPm == 'AM'
                                          ? cardBody
                                          : cardSubtext),
                                ),
                                Text(' / ', style: cardBody),
                                GestureDetector(
                                  onTap: () => _changeAmPm('PM'),
                                  child: Text('PM',
                                      style: _amPm == 'PM'
                                          ? cardBody
                                          : cardSubtext),
                                ),
                              ],
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: WHITE, width: 2)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: RED, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: TRANSPARENT_WHITE, width: 2)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: RED, width: 2)),
                            labelText: 'Time',
                            labelStyle: _time.hasFocus ? subBody : body,
                            hintText: 'hh:mm'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: PADDING),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        focusNode: _city,
                        textAlign: TextAlign.start,
                        style: cardBody,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: WHITE, width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: TRANSPARENT_WHITE, width: 2)),
                          labelText: 'City',
                          labelStyle: _city.hasFocus ? subBody : body,
                        ),
                      ),
                    ),
                    SizedBox(width: PADDING),
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField(
                          onTap: () => FocusScope.of(context)
                              .requestFocus(new FocusNode()),
                          style: cardBody,
                          iconEnabledColor: WHITE,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: WHITE, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: TRANSPARENT_WHITE, width: 2)),
                            labelText: 'State',
                            labelStyle: _state.hasFocus ? subBody : body,
                          ),
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              // _currentSelectedValue = newValue;
                              // state.didChange(newValue);
                            });
                          },
                          dropdownColor: PURPLE_DARK,
                          value: 'MO',
                          items: STATES.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()),
                    ),
                  ],
                ),
                // SizedBox(height: PADDING / 2),
                // Text('Use Current Location', style: subBody),
                SizedBox(
                  height: PADDING * 2,
                ),
                Text('Disable anything you don\'t like.', style: body),
                SizedBox(
                  height: PADDING,
                ),
                Column(
                  children: [
                    _buildTile(),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
