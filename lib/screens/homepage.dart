import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mononton/constanta.dart';
import 'package:mononton/screens/upcoming.dart';
import 'package:mononton/service/api.dart';

import '../widgets/appbar.dart';
import '../widgets/button.dart';
import '../widgets/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TextEditingController searchC = TextEditingController()..addListener(() {});

  late CarouselController pageController;

  int pageOffset = 0;

  bool tapNowShowing = true;
  List dataImage = [];
  List dataMovies = [];

  @override
  void initState() {
    super.initState();
    pageController = CarouselController();

    getImage(dataImage).then((value) {
      setState(() {
        dataImage = value;
      });
    });
  }

  Index? index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AnnotatedRegion(
          value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
              systemNavigationBarColor: black),
          child: Stack(
            children: [
              dataImage.isNotEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        filterQuality: FilterQuality.low,
                        fit: BoxFit.cover,
                        colorBlendMode: BlendMode.multiply,
                        color: black.withOpacity(.5),
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${dataImage[pageOffset.toInt()]['poster_path']}',
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Container(
                          color: black,
                        ),
                        errorWidget: (context, url, error) => const Center(
                            child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Icon(Icons.error))),
                      ),
                    )
                  : Container(
                      color: black,
                    ),
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          filterQuality: FilterQuality.low,
                          colorFilter: ColorFilter.mode(
                              black.withOpacity(.1), BlendMode.multiply),
                          fit: BoxFit.cover,
                          image: const AssetImage(
                            'assets/images/noise.png',
                          )))),
              BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 20,
                    sigmaY: 20,
                  ),
                  child: SizedBox(
                      child: Scaffold(
                          backgroundColor:
                              dataImage.isEmpty ? black : Colors.transparent,
                          appBar: PreferredSize(
                            preferredSize: const Size.fromHeight(120),
                            child: CustomAppbar(),
                          ),
                          body: Column(children: <Widget>[
                            // SEARCH
                            Container(
                              clipBehavior: Clip.antiAlias,
                              height: 44,
                              margin: hPadding,
                              decoration: BoxDecoration(
                                  color: black,
                                  borderRadius: BorderRadius.circular(13)),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: TextField(
                                    textAlignVertical: TextAlignVertical.center,
                                    controller: searchC,
                                    style: tStyle.copyWith(
                                        color: white, fontSize: 16),
                                    cursorColor: white,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    cursorWidth: 1,
                                    maxLength: 30,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        prefixIcon: Container(
                                          height: 40,
                                          width: 40,
                                          padding: const EdgeInsets.all(13),
                                          color: Colors.transparent,
                                          child: SvgPicture.asset(
                                            'assets/icons/ic_search.svg',
                                            color: grey,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        counterText: '',
                                        border: InputBorder.none,
                                        hintText: 'Search movie',
                                        hintStyle: tStyle.copyWith(color: grey),
                                        focusedBorder: InputBorder.none),
                                  )),
                                  SizedBox(
                                    height: double.infinity,
                                    width: 40,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          alignment: Alignment.center,
                                          shape: MaterialStateProperty.all(
                                              const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.zero)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  primaryColor),
                                          padding: MaterialStateProperty.all(
                                              const EdgeInsets.all(0))),
                                      onPressed: () {},
                                      child: SvgPicture.asset(
                                        'assets/icons/ic_voice.svg',
                                        color: white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            vSpace,

                            Padding(
                              padding: hPadding,
                              child: Row(children: <Widget>[
                                BtnIconText(
                                    press: () async {
                                      getImage(dataImage).then((value) {
                                        setState(() {
                                          dataImage = value;
                                        });
                                      });
                                    },
                                    bgColor: white,
                                    icon: SvgPicture.asset(
                                        'assets/icons/ic_showing.svg'),
                                    text: 'Now Showing'),
                                hSpace,
                                BtnIconText(
                                    press: () => Get.to(const Upcoming(),
                                        transition: Transition.rightToLeft),
                                    text: 'Up coming'),
                              ]),
                            ),
                            vSpace,
                            _nowShowing()
                          ]))))
            ],
          )),
    );
  }

  CarouselSlider _nowShowing() {
    return CarouselSlider.builder(
        options: CarouselOptions(
            height: 300,
            initialPage: pageOffset,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            // padEnds: false,
            scrollPhysics: const BouncingScrollPhysics(),
            viewportFraction: 0.5,
            onPageChanged: (index, reason) {
              setState(() {
                pageOffset = index;
              });
            }),
        itemCount: dataImage.length,
        carouselController: pageController,
        itemBuilder: (context, i, realIndex) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(18),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              filterQuality: FilterQuality.low,
              fit: BoxFit.cover,
              imageUrl:
                  'https://image.tmdb.org/t/p/w500${dataImage[i]['poster_path']}',
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child:
                    CircularProgressIndicator(value: downloadProgress.progress),
              ),
              errorWidget: (context, url, error) => const Center(
                  child: SizedBox(
                      height: 40, width: 40, child: Icon(Icons.error))),
            ),
          );
        });
  }
}
