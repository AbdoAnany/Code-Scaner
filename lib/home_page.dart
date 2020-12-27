import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scan/add.dart';
import 'package:scan/appTheme.dart';
import 'package:scan/generate.dart';
import 'package:scan/home.dart';
import 'package:scan/search.dart';

class HomeCourse extends StatefulWidget {
  var courseData;
  var dataUser;

  @override
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<HomeCourse>
    with SingleTickerProviderStateMixin {
  int _currrentIndex = 0;

  TabController controller;
  @override
  void initState() {
    super.initState();
    //  controller = new TabController(vsync: this, length: 2);
    _pageController.initialPage;
  }

  PageController _pageController = PageController();

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);

    _pageController.animateToPage(_currrentIndex, curve: Curves.bounceIn,
        duration: Duration(milliseconds: 50));
  }

  var tab = [
    new Search(),
    new Home(),
    new Generate(),
    new Home(),

    new Add_Product(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(

      // body: new TabBarView(controller: controller, children: <Widget>[
      //   new Home(),
      //   new Generate(),
      // ]),

        body: Container(
          child: PageView(
            controller: _pageController,
            children: tab,
          ),

        ),
        bottomNavigationBar: ConvexAppBar.badge(

          {},initialActiveIndex: 2,
          gradient: LinearGradient(
              begin: Alignment.bottomRight,end: Alignment.topLeft,
              colors: AppTheme.mix9
          ),

          backgroundColor: AppTheme.a2.withOpacity(1),
          curveSize: 100,
          elevation: 5,
          top: -30,
          color: AppTheme.white,
          items: [
            TabItem(
              icon: Icons.search,
              title: "Search",
            ),
            TabItem(
              icon: Icons.local_fire_department,
              title: "Hot",
            )   ,
            TabItem(
              icon: Icons.home,
              title: "Home",
            ),

            TabItem(
              icon: Icons.post_add_rounded,
              title: "Add Product",
            ),
          ],
          onTap: (index) {

            setState(() {
              _currrentIndex = index;
              _pageController.animateToPage(_currrentIndex, curve: Curves.bounceOut,
                  duration: Duration(milliseconds: 50));
              return TabItem;
            });
          },
        ),
     )) ;
  }
}

// class WaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     var sw = size.width;
//     var sh = size.height;
//
//     path.cubicTo(sw / 12, 0, sw / 12, 2 * sh / 5, 2 * sw / 12, 2 * sh / 5);
//     path.cubicTo( 3 * sw / 12, 2 * sh / 5, 3 * sw / 12, 0, 4 * sw / 12, 0);
//     path.cubicTo( 5 * sw / 12, 0, 5 * sw / 12, 2 * sh / 5, 6 * sw / 12, 2 * sh / 5);
//     path.cubicTo( 7 * sw / 12, 2 * sh / 5, 7 * sw / 12, 0, 8 * sw / 12, 0);
//     path.cubicTo( 9 * sw / 12, 0, 9 * sw / 12, 2 * sh / 5, 10 * sw / 12, 2 * sh / 5);
//     path.cubicTo( 11 * sw / 12, 2 * sh / 5, 11 * sw / 12, 0, sw, 0);
//     path.lineTo(sw, sh);
//     path.lineTo(0, sh);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
//
// class CustomBottomNavigationBar1 extends StatefulWidget {
//   @override
//   _CustomBottomNavigationBarState createState() =>
//       _CustomBottomNavigationBarState();
// }
//
// class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
//   setPage() {
//     setState(() {
//     //  pageController.jumpToPage(currentIndex);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 110,
//       child: Material(
//         color: Colors.transparent,
//         child: Stack(
//           children: <Widget>[
//             Positioned(
//               bottom: 0,
//               child: ClipPath(
//                 clipper: WaveClipper(),
//                 child: Container(
//                   height: 60,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Theme.of(context).primaryColor.withAlpha(150),
//                         Theme.of(context).primaryColor,
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 45,
//               width: MediaQuery.of(context).size.width,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//
//                 ],
//               ),
//             ),
//             Positioned(
//               bottom: 10,
//               width: MediaQuery.of(context).size.width,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Text(
//                     'Focus',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Container(),
//                   Text(
//                     'Relax',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Container(),
//                   Text(
//                     'Sleep',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
