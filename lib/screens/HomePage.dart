import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viewpager/widgets/FloatActionWidget.dart';
import 'package:viewpager/widgets/indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}
List<String> imageUrl=[
  'assets/images/',
  'assets/images/',
  'assets/images/',
  'assets/images/',
];
class _HomePageState extends State<HomePage> {
  int currentPage= 0;
  final PageController _controller = PageController(initialPage: 0);
  double page=0;
  int currentIcon =0;

  double? screenWidth,paddingTop;

  late ValueChanged<int> onChange;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        page=_controller.page!;
      });
    });
    onChange = (value) {
      setState(() {
        currentIcon = value== 0? 1:0;
      });
    };

  }
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    paddingTop = MediaQuery.of(context).padding.top + 20;
    return Scaffold(
      backgroundColor: Colors.black45,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatActionWidget(currentIcon: currentIcon,
      valueChanged: onChange,),
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: _controller,
            physics: const BouncingScrollPhysics(),
            scrollBehavior: MyBehavior(),
            itemCount: imageUrl.length,
              scrollDirection:  currentIcon ==0?Axis.horizontal : Axis.vertical,
              reverse: currentIcon==0 ? true : false,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                return Transform(
                  transform: _matrix4(index),
                    child: ItemPageView(index: index));
              },),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              left: currentIcon ==0? screenWidth! * 0.4 : 20,
              top: currentIcon ==0? paddingTop : 100,
              child: BuildIndicator(
                  currentPage: currentPage,
              currentIcon: currentIcon,))


        ],
      ),
    );
  }
  void _onPageChanged(int page)
  {
    currentPage = page;
    setState(() {});
  }

  _matrix4(int index)
  {
    if(currentIcon==0)
      {
        return Matrix4.identity()..rotateX(page - index);
      }
    return  Matrix4.identity()..rotateZ(page - index);
  }
}
class ItemPageView extends StatelessWidget {
  final int index;
  const ItemPageView({Key? key,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
          image: AssetImage(
              imageUrl[index]+ '${index+1}.jpg',)
        )
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}