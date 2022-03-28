import 'package:chap5_practice/components/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class GroceryItemScreen extends StatefulWidget {
  @override
  State<GroceryItemScreen> createState() => _GroceryItemScreenState();

  // Inform whenever an Item is created.
  final Function(GroceryItem) onCreate;
  final Function(GroceryItem, int) onUpdate;
  // Get the Grocery Item that user click on it
  final GroceryItem? originalItem;
  final int index;
  final bool isUpdating;
  const GroceryItemScreen(
      {Key? key,
      required this.onCreate,
      required this.onUpdate,
      this.index = -1,
      this.originalItem})
      : isUpdating = (originalItem != null),
        super(key: key);

  static MaterialPage page({
    GroceryItem? item,
    int index = -1,
    required Function(GroceryItem) onCreate,
    required Function(GroceryItem, int) onUpdate,
  }) {
    return MaterialPage(
        name: FooderlichPages.groceryItemDetails,
        key: ValueKey(FooderlichPages.groceryItemDetails),
        child: GroceryItemScreen(
          onCreate: onCreate,
          onUpdate: onUpdate,
          originalItem: item,
          index: index,
        ));
  }
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  // TODO: Add grocery item screen state properties
  final _nameController = TextEditingController();
  String _name = '';
  Importance _importance = Importance.low;
  Color _currentColor = Colors.green;
  DateTime _dueDate = DateTime.now();
  int _currentSliderValue = 0;
  TimeOfDay _timeOfDay = TimeOfDay.now();

  @override
  void initState() {
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _nameController.text = originalItem.name;
      _name = originalItem.name;
      _importance = originalItem.importance;
      _currentColor = originalItem.color;
      final date = originalItem.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dueDate = originalItem.date;
    }
    _nameController.addListener(() {
      _name = _nameController.text;
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO 12: Add GroceryItemScreen Scaffold
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              //TODO 24: Adding Callback Handler
              final groceryItem = GroceryItem(
                id: widget.originalItem?.id ?? const Uuid().v1(),
                name: _nameController.text,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              );
              if (widget.isUpdating) {
                widget.onUpdate(groceryItem, widget.index);
              } else {
                widget.onCreate(groceryItem);
              }
            },
            icon: const Icon(Icons.check),
          )
        ],
        elevation: 0.0,
        title: Text(
          'Grocery Item',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildNameField(),
            const SizedBox(height: 10),
            buildImportanceField(),
            const SizedBox(height: 10),
            buildDateField(context),
            const SizedBox(height: 10),
            buildTimeField(context),
            const SizedBox(height: 10),
            buildColorPicker(context),
            const SizedBox(height: 10),
            buildQuantityField(),
            const SizedBox(height: 10),
            GroceryTitle(
              item: GroceryItem(
                id: 'PreviewMode',
                name: _name,
                color: _currentColor,
                importance: _importance,
                quantity: _currentSliderValue,
                date: DateTime(_dueDate.year, _dueDate.month, _dueDate.day,
                    _timeOfDay.hour, _timeOfDay.minute),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Item Name', style: GoogleFonts.lato(fontSize: 28)),
        const SizedBox(height: 10),
        TextField(
          textCapitalization: TextCapitalization.sentences,
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
            hintText: 'E.g. Apples, Banana, 1 Bag of salt',
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _currentColor)),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 5.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
          ),
        )
      ],
    );
  }

  Widget buildImportanceField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Imporatant', style: GoogleFonts.lato(fontSize: 28)),
        Wrap(
          spacing: 10,
          children: [
            ChoiceChip(
              label: const Text('low'),
              selectedColor: Colors.black,
              selected: _importance == Importance.low,
              onSelected: (selected) => setState(() {
                _importance = Importance.low;
              }),
            ),
            ChoiceChip(
              label: const Text('medium'),
              selectedColor: Colors.black,
              selected: _importance == Importance.medium,
              onSelected: (selected) => setState(() {
                _importance = Importance.medium;
              }),
            ),
            ChoiceChip(
              label: const Text('high'),
              selectedColor: Colors.black,
              selected: _importance == Importance.high,
              onSelected: (selected) => setState(() {
                _importance = Importance.high;
              }),
            )
          ],
        )
      ],
    );
  }

  Widget buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Date', style: GoogleFonts.lato(fontSize: 28)),
            TextButton(
              onPressed: () async {
                final currentDate = DateTime.now();
                final selectDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: currentDate,
                  lastDate: DateTime(currentDate.year + 5),
                );
                setState(() {
                  if (selectDate != null) {
                    _dueDate = selectDate;
                  }
                });
              },
              child: const Text('Selected'),
            ),
          ],
        ),
        Text(DateFormat('dd-MM-yyyy').format(_dueDate))
      ],
    );
  }

  Widget buildTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time',
              style: GoogleFonts.lato(fontSize: 28),
            ),
            TextButton(
                onPressed: () async {
                  final currentTime = TimeOfDay.now();
                  final selectTime = await showTimePicker(
                    context: context,
                    initialTime: currentTime,
                  );
                  setState(() {
                    if (selectTime != null) _timeOfDay = selectTime;
                  });
                },
                child: const Text('Selected'))
          ],
        ),
        Text(_timeOfDay.format(context))
      ],
    );
  }

  Widget buildColorPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text('Color', style: GoogleFonts.lato(fontSize: 28)),
            const SizedBox(width: 10),
            Positioned(
              bottom: 0,
              child: Container(
                width: 5,
                height: 26,
                color: _currentColor,
              ),
            )
          ],
        ),
        TextButton(
          child: const Text('Selected'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  content: BlockPicker(
                    pickerColor: Colors.white,
                    onColorChanged: (color) {
                      setState(() {
                        _currentColor = color;
                      });
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Save'),
                    )
                  ],
                );
              },
            );
          },
        )
      ],
    );
  }

  Widget buildQuantityField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Text('Quantity:', style: GoogleFonts.lato(fontSize: 28)),
            const SizedBox(width: 10),
            Text(
              '${_currentSliderValue.toInt()}',
              style: GoogleFonts.lato(fontSize: 28),
            )
          ],
        ),
        Slider(
          activeColor: _currentColor,
          inactiveColor: _currentColor.withOpacity(0.6),
          min: 0.0,
          max: 100.0,
          label: _currentSliderValue.toInt().toString(),
          divisions: 100,
          value: _currentSliderValue.toDouble(),
          onChanged: (double value) {
            setState(() => _currentSliderValue = value.toInt());
          },
        )
      ],
    );
  }
}
