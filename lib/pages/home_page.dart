// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pingsu/model/radio.dart';
import 'package:pingsu/utils/ai_util.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<MyRadio> radios;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRadios();
  }

  fetchRadios() async {
    final radioJson = await rootBundle.loadString("assests/radio.json");
    radios = MyRadioList.fromJson(radioJson).radios;
    print(radios);
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Stack(
        // ignore: sort_child_properties_last
        children: [
          VxAnimatedBox()
              .size(context.screenWidth, context.screenHeight)
              .withGradient(LinearGradient(
                colors: [AIColors.primaryColor1, AIColors.primaryColor2],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ))
              .make(),
          AppBar(
            title: 'AI Radio'.text.xl4.bold.white.make().shimmer(
                  primaryColor: Vx.purple300,
                  secondaryColor: Colors.white,
                ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
          ).h(100.0).p16(),
          VxSwiper.builder(
              itemCount: radios.length,
              enlargeCenterPage: true,
              aspectRatio: 1.0,
              itemBuilder: (context, index) {
                final rad = radios[index];

                return VxBox(
                        child: ZStack([
                  Positioned(
                      top: 0.0,
                      right: 0.0,
                      child: VxBox(
                              child: rad.category.text.uppercase.white
                                  .make()
                                  .p16())
                          .height(50)
                          .black
                          .alignCenter
                          .withRounded(value: 10.0)
                          .make()),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: VStack(
                      [
                        rad.name.text.xl3.white.bold.make(),
                        5.heightBox,
                        rad.tagline.text.sm.white.semiBold.make()
                      ],
                      crossAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: [
                      Icon(
                        CupertinoIcons.play_circle,
                        color: Colors.white,
                      ),
                      10.heightBox,
                      "Double tap to play!".text.gray300.make()
                    ].vStack(),
                  )
                ])).clip(Clip.antiAlias)
                    .bgImage(DecorationImage(
                        image: NetworkImage(rad.image),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.darken)))
                    .border(color: Colors.black, width: 5.0)
                    .withRounded(value: 60.0)
                    .make()
                    .onInkDoubleTap(() {})
                    .p16();
              })
                    .centered(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Icon(CupertinoIcons.stop_circle,color: Colors.white,size: 50.0,),
              ).pOnly(bottom: context.percentHeight*12)
        ],
        fit: StackFit.expand,
        clipBehavior: Clip.antiAlias,

      ),
    );
  }
}
