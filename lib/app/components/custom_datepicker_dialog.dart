import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/borders.dart';
import '../style/colors.dart';

class CustomDateTimePickerDialog extends StatefulWidget {
  final String? text;
  final bool enabled;
  final Function(String?)? onDataChange;
  final String? Function(String?)? validator;


  const CustomDateTimePickerDialog({
    Key? key,
    this.text,
    this.onDataChange,
    this.enabled = true,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomDateTimePickerDialog> createState() =>
      _CustomDateTimePickerDialogState();
}

class _CustomDateTimePickerDialogState
    extends State<CustomDateTimePickerDialog> {
  var selectedDate;
  var valueDate;
  var textDate;

  _selectDate(BuildContext context) async {
    selectedDate = DateTime.now();
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Center(
            child: SizedBox(
          width: 500,
          height: Get.height / 2,
          child: child,
        ));
      },
    );

    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        valueDate =
            '${selectedDate.year.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
        textDate =
            '${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year.toString().padLeft(2, '0')}';
      });
    }

    widget.onDataChange?.call(valueDate);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: TextFormField(
          readOnly: true,
            style: const TextStyle(color: kPrimaryTextColor),
            decoration: InputDecoration(
                label: Text(widget.text == null ? 'Tanggal' : widget.text!,style: Get.textTheme.bodyText2?.copyWith(color: kSecondaryTextColor)),


                hintText: 'Pilih',
                hintStyle: Get.textTheme.bodyText2?.copyWith(color: kSecondaryTextColor)),
            controller: TextEditingController(text: textDate),
            validator: widget.validator, onTap: (){
          if (widget.enabled == true) _selectDate(context);
        },),
      ),
    );
  }
}
