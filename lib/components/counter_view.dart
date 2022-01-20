import 'package:flutter/material.dart';

class CounterView extends StatefulWidget {
  final int initNumber;
  final Function(String, int) counterCallback;
  final Function increaseCallback;
  final Function decreaseCallback;
  final int minNumber;
  final String product;
  final int maxNumber;
  CounterView(
      {required this.product,
      required this.initNumber,
      required this.counterCallback,
      required this.increaseCallback,
      required this.decreaseCallback,
      required this.minNumber,
      required this.maxNumber});
  @override
  _CounterViewState createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  late int _currentCount;
  late String _product;
  late Function _counterCallback;
  late Function _increaseCallback;
  late Function _decreaseCallback;
  late int _minNumber;
  late int _maxNumber;

  @override
  void initState() {
    _product = widget.product;
    _currentCount = widget.initNumber;
    _counterCallback = widget.counterCallback;
    _increaseCallback = widget.increaseCallback;
    _decreaseCallback = widget.decreaseCallback;
    _minNumber = widget.minNumber;
    _maxNumber = widget.maxNumber;
    super.initState();
  }

  var LightGreyColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: LightGreyColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _currentCount == 1
              ? _createIncrementDicrementButton(
                  Icons.delete, () => _dicrement())
              : _createIncrementDicrementButton(
                  Icons.remove, () => _dicrement()),
          SizedBox(
            width: 10,
          ),
          Text(_currentCount.toString()),
          SizedBox(
            width: 10,
          ),
          _createIncrementDicrementButton(Icons.add, () => _increment()),
        ],
      ),
    );
  }

  void _increment() {
    setState(() {
      if (_currentCount < _maxNumber) {
        _currentCount++;
        _counterCallback(_product, _currentCount);
        _increaseCallback(_product, _currentCount);
      }
    });
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > _minNumber) {
        _currentCount--;
        _counterCallback(_product, _currentCount);
      }
      _decreaseCallback(_product, _currentCount);
    });
  }

  Widget _createIncrementDicrementButton(IconData icon, Function onPressed) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
      onPressed: () {
        onPressed();
      },
      elevation: 2.0,
      fillColor: LightGreyColor,
      child: Icon(
        icon,
        color: Colors.black,
        size: 12.0,
      ),
      shape: CircleBorder(),
    );
  }
}
