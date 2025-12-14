import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/button/button.dart';
import '../components/input/input.dart';
import 'images.dart';

class FilterByDate extends StatefulWidget {
  const FilterByDate({Key? key}) : super(key: key);

  @override
  State<FilterByDate> createState() => _FilterByDateState();
}

class _FilterByDateState extends State<FilterByDate> {
  final TextEditingController _fromDateController =
      TextEditingController(text: '');
  final TextEditingController _toDateController =
      TextEditingController(text: '');
  final _emptyNode = FocusNode();

  String? fromError;
  String? toError;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: 315,
        width: double.infinity,
        child: Column(children: [
          const SizedBox(height: 20),
          heading(),
          const SizedBox(height: 20),
          fromDate(),
          const SizedBox(height: 20),
          toDate(),
          buttons()
        ]),
      ),
    );
  }

  heading() {
    return const Text('Filter by date',
        style: TextStyle(
            color: Color(0xff1e1e1e),
            fontSize: 18,
            fontFamily: "Poppins-SemiBold"));
  }

  fromDate() {
    return InputPrimary(
        enabled: false,
        svgIconRight: Images.icCalendar,
        svgIconOnTap: () => {onPickDate(_fromDateController)},
        controller: _fromDateController,
        errorText: fromError,
        labelText: 'From Date',
        keyboardType: TextInputType.datetime);
  }

  toDate() {
    return InputPrimary(
        enabled: false,
        svgIconRight: Images.icCalendar,
        svgIconOnTap: () => {onPickDate(_toDateController)},
        controller: _toDateController,
        errorText: toError,
        labelText: 'To Date',
        keyboardType: TextInputType.datetime);
  }

  onPickDate(dateController) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2005, 8),
        lastDate: DateTime(2030));
    if (picked != null) {
      setState(() {
        dateController.text = DateFormat("dd/MM/yyyy").format(picked);
        fromError = null;
        toError = null;
      });
    }
  }

  buttons() {
    return Row(
        children: [Expanded(child: cancel()), Expanded(child: filter())]);
  }

  cancel() {
    return ButtonSecondary(
        text: 'Cancel',
        onPressed: onCancel);
  }

  onCancel() {
    Navigator.pop(context);
  }

  filter() {
    return ButtonPrimary(
        text: 'Filter',
        onPressed: onFilter);
  }

  onFilter() {
    setState(() {
      fromError = null;
      toError = null;
    });
    if (_fromDateController.text.isEmpty) {
      setState(() {
        fromError = 'please enter from date';
      });
    } else if (_toDateController.text.isEmpty) {
      setState(() {
        toError = 'please enter to date';
      });
    } else {
      Navigator.pop(
          context, [_fromDateController.text, _toDateController.text]);
    }
  }
}
