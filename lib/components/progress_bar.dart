import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';

class ProgressBar extends StatefulWidget {
  int progress;

  ProgressBar(this.progress);

  @override
  State<ProgressBar> createState() {
    return ProgressBarState(progress);
  }
}

class ProgressBarState extends State<ProgressBar> {
  int progress;

  ProgressBarState(this.progress);

  @override
  void initState() {
    super.initState();
    print(this.progress);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
                  3,
                  (index) =>
                      getBox((index + 1).toString(), index < this.progress))
              .toList()),
    );
  }

  Widget getBox(String number, bool enable) {
    var width = (MediaQuery.of(context).size.width * 0.33) - 10;
    return Stack(alignment: AlignmentDirectional.center, children: [
      Container(
        width: width,
        height: 5,
        decoration: BoxDecoration(
          color: enable ? AppColors.progressEnable : AppColors.progressDisable,
        ),
      ),
      getCricle(number, enable)
    ]);
  }

  Widget getCricle(String number, bool enable) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: enable ? AppColors.progressEnable : AppColors.progressDisable,
      ),
      child: Center(
        child: Text(
          number,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: enable ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
