import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'search.dart';

class Home extends StatefulWidget {
  StatefulWidget TopBarSecondary;

  Home(StatefulWidget this.TopBarSecondary);

  @override
  State<Home> createState() {
    return HomeState(TopBarSecondary);
  }
}

class HomeState extends State<Home> {
  StatefulWidget TopBarSecondary;

  HomeState(StatefulWidget this.TopBarSecondary) {}

  void openSearch(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
  }

  List<String> home_images = [
    "https://images.tech.co/wp-content/uploads/2021/05/28104036/iphone-12-colors.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return makepage([
      CarouselSlider.builder(
        itemCount: home_images.length,
        options: CarouselOptions(
            enlargeCenterPage: true,
            height: 250,
            pauseAutoPlayInFiniteScroll: true,
            reverse: false,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayAnimationDuration: Duration(milliseconds: 300)),
        itemBuilder: (context, i, r) {
          return Container(
              height: 250,
              width: double.infinity,
              child: Image.network(
                home_images[i],
                fit: BoxFit.cover,
              ));
        },
      ),
    ]);
  }

  Widget makepage(List<Widget> list) {
    return Scaffold(
        body: Column(
      children: [
        TopBarSecondary,
        Expanded(
            flex: 2,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: list,
                  ),
                )
              ],
            ))
      ],
    ));
  }
}
