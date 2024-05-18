import 'package:flutter/material.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final String hintText;
  final List<T> items;
  final T? value;
  final void Function(T?) onChanged;
  final TextStyle? dropdownStyle;
  final Color? itemBackgroundColor;
  final String? Function(T?)? validator; // Validator function

  const CustomDropdownButton({
    required this.hintText,
    required this.items,
    required this.value,
    required this.onChanged,
    Key? key,
    this.dropdownStyle,
    this.itemBackgroundColor,
    this.validator, // Accept validator parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 15, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: mycolor4,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: mycolor5, // Set navy background color for dropdown menu
        ),
        child: DropdownButtonFormField<T>(
          borderRadius: BorderRadius.circular(15),
          value: value,
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Container(
                color:
                    itemBackgroundColor, // Set item background color if needed
                child: Text(
                  item.toString(),
                  style: dropdownStyle,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator, // Set validator function
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
            ), // Set hint text color to white
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none, // Remove border
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
          ),
        ),
      ),
    );
  }
}
