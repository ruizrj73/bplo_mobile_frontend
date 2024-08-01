// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lgu_bplo/utils/theme_color.dart';
import 'package:intl/intl.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';

class InputControls {
  static Widget textFieldInput(BuildContext context, TextEditingController inputController, {
          String title = "", 
          TextInputType keyboardType = TextInputType.text, 
          String prefixText = "", 
          String suffixText = "", 
          bool isDate = false, 
          bool isCurrentDate = true, 
          bool readOnly = false,
          TextCapitalization textCapitalization = TextCapitalization.words,
          Function(String) onChangedx,
          bool isNumeric = false,
          bool isCurrency = false
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != "" ? Text(title, style: TextStyle(fontSize: 12)) : Container(),
        title != "" ? SizedBox(height: 4): Container(),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 30,
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(4.0))),
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
            ),
            child: TextField(
              textCapitalization: textCapitalization,
              controller: inputController,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                border: InputBorder.none, 
                suffixIcon: isDate ? Icon(Feather.calendar, size: 20, color: ThemeColor.disabled) : suffixText != "" ? Text(suffixText, style: TextStyle(fontSize: 12, color: ThemeColor.disabledText)) : null,
                suffixIconConstraints: BoxConstraints(maxHeight: 20),
                suffixIconColor: ThemeColor.disabled,
                prefixIcon: prefixText != "" ? Text(prefixText, style: TextStyle(fontSize: 12, color: ThemeColor.disabledText)) : null,
                prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                isDense: true,
                counterText: '',
              ),
              inputFormatters: !isNumeric && !isCurrency ? [] : [
                NumberTextInputFormatter(
                  integerDigits: 13,
                  decimalDigits: isCurrency ? 2 : 0,
                  maxValue: '1000000000000.00',
                  decimalSeparator: '.',
                  groupDigits: 3,
                  groupSeparator: ',',
                  allowNegative: false,
                  overrideDecimalPoint: true,
                  insertDecimalPoint: isCurrency,
                  insertDecimalDigits: isCurrency,
                ),
              ],
              style: TextStyle(fontSize: 12),
              readOnly: isDate || readOnly,
              onChanged: onChangedx,
              onTap: () async {
                if (isDate) {
                  DateTime pickedDate = await showDatePicker(
                    context: context, initialDate: DateTime.now(),
                    firstDate: DateTime(1500),
                    lastDate: isCurrentDate ? DateTime.now() : DateTime(DateTime.now().year + 10),
                  );
                  
                  if(pickedDate != null ){
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                    
                    inputController.text = formattedDate;
                  }
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  static Widget selectionFieldInput(BuildContext context, String value, Function(String) callback, List<String> selection, {String title = ""}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != "" ? Text(title, style: TextStyle(fontSize: 12)) : Container(),
        title != "" ? SizedBox(height: 4): Container(),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 30,
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(4.0))),
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                style: TextStyle(
                  fontSize: 12,
                  color: ThemeColor.secondary,
                ),
                hint: const Text(''),
                isExpanded: true,
                value: value,
                onChanged: callback,
                items: selection.map((String items) {
                  return DropdownMenuItem( 
                    value: items, 
                    child: Text(items, style: TextStyle(fontSize: 12)), 
                  ); 
                }).toList(), 
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget radioButtonSelection(String groupValueX, String value1, String value2, Function(String) onChangedX, {String title = "", String value3 = ""}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != "" ? Text(title, style: TextStyle(fontSize: 12)) : Container(),
        title != "" ? SizedBox(height: 4): Container(),
        Row(
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: Radio(
                value: value1,
                groupValue: groupValueX,
                onChanged: onChangedX
              ),
            ),
            Text(value1, style: TextStyle(fontSize: 12)),
            SizedBox(width: 16),
            SizedBox(
              height: 30,
              width: 30,
              child: Radio(
                value: value2,
                groupValue: groupValueX,
                onChanged: onChangedX
              ),
            ),
            Text(value2, style: TextStyle(fontSize: 12)),
            value3 == "" ? Container() : SizedBox(width: 16),
            value3 == "" ? Container() : SizedBox(
              height: 30,
              width: 30,
              child: Radio(
                value: value3,
                groupValue: groupValueX,
                onChanged: onChangedX
              ),
            ),
            value3 == "" ? Container() : Text(value3, style: TextStyle(fontSize: 12)),
          ],
        ),
      ]
    );
  }
}