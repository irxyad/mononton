import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mononton/constanta.dart';
import 'package:mononton/screens/buy.dart';
import 'package:mononton/screens/temp_screen.dart';
import 'package:mononton/service/api.dart';
import 'package:mononton/widgets/background.dart';
import 'package:mononton/widgets/navigationbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/appbar.dart';
import '../widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchC = TextEditingController()..addListener(() {});
  late PageController pageController;

  late CarouselController carouselController;

  int slideCarrousel = 0;
  List dataMovies = [];
  List watchlist = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    carouselController = CarouselController();

    setState(() {
      isLoading = true;
      loadMovies().then((value) {
        setState(() {
          isLoading = false;
          dataMovies = value;
          loadWatchlist(dataMovies).then((value) {
            setState(() {
              watchlist = value;
            });
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == false && dataMovies.isNotEmpty
        ? GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AnnotatedRegion(
              value: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light,
                  systemNavigationBarContrastEnforced: true,
                  statusBarBrightness: Brightness.light,
                  systemNavigationBarColor: Colors.transparent),
              child:
// BACKGROUND BLUR
                  BlurBackground(
                imageUrl:
                    'https://image.tmdb.org/t/p/w500${dataMovies[slideCarrousel]['poster_path']}',
                child: SafeArea(
                  bottom: true,
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.transparent,
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(kToolbarHeight + 10),
                      child: CustomAppbar(),
                    ),
                    body: Column(children: <Widget>[
                      // SEARCH
                      vSpace,
                      Container(
                        clipBehavior: Clip.antiAlias,
                        height: 44,
                        margin: hPadding,
                        decoration: BoxDecoration(
                            color: black,
                            borderRadius: BorderRadius.circular(13)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                textAlignVertical: TextAlignVertical.center,
                                controller: searchC,
                                style:
                                    tStyle.copyWith(color: white, fontSize: 16),
                                cursorColor: white,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                cursorWidth: 1,
                                maxLength: 30,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    isCollapsed: true,
                                    prefixIcon: Container(
                                      height: 40,
                                      width: 40,
                                      padding: const EdgeInsets.all(13),
                                      color: Colors.transparent,
                                      child: SvgPicture.asset(
                                        'assets/icons/ic_search.svg',
                                        colorFilter: const ColorFilter.mode(
                                            white, BlendMode.srcIn),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    counterText: '',
                                    border: InputBorder.none,
                                    hintText: 'Search movie',
                                    hintStyle: tStyle.copyWith(color: grey),
                                    focusedBorder: InputBorder.none),
                              ),
                            ),
                            SizedBox(
                              height: double.infinity,
                              width: 40,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    alignment: Alignment.center,
                                    shape: WidgetStateProperty.all(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero)),
                                    backgroundColor:
                                        WidgetStateProperty.all(primaryColor),
                                    padding: WidgetStateProperty.all(
                                        EdgeInsets.zero)),
                                onPressed: () {},
                                child: SvgPicture.asset(
                                  'assets/icons/ic_voice.svg',
                                  colorFilter: const ColorFilter.mode(
                                      white, BlendMode.srcIn),
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
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.clear();
                              },
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              bgColor: white,
                              icon: SvgPicture.asset(
                                  'assets/icons/ic_showing.svg'),
                              text: Text(
                                'Now Showing',
                                style: tStyle.copyWith(
                                    fontWeight: FontWeight.bold, color: black),
                              )),
                          hSpace,
                          BtnIconText(
                              bgColor: Colors.transparent,
                              press: () => Get.to(const Upcoming(),
                                  transition: Transition.rightToLeft),
                              text: Text(
                                'Up coming',
                                style: tStyle.copyWith(
                                    fontWeight: FontWeight.bold, color: grey),
                              )),
                          const Spacer(),
                          BtnTextIcon(
                            icon: SvgPicture.asset(
                              'assets/icons/ic_forward.svg',
                              colorFilter: const ColorFilter.mode(
                                  white, BlendMode.srcIn),
                            ),
                            bgColor: black.withOpacity(.5),
                            press: () {
                              Get.to(() => (const More()),
                                  transition: Transition.rightToLeft);
                            },
                            text: Text(
                              'More',
                              style: tStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: white),
                            ),
                          ),
                        ]),
                      ),
                      vSpace,
                      _nowShowing(),
                      const SizedBox(
                        height: 15,
                      ),
                      dataMovies.isNotEmpty
                          ? Expanded(
                              child: Padding(
                                padding: hPadding,
                                child: Column(
                                  children: [
                                    Text(
                                      dataMovies[slideCarrousel]['title'],
                                      style: tStyle.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    dataMovies[slideCarrousel]['vote_count'] ==
                                            0
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                                SvgPicture.asset(
                                                  'assets/icons/ic_rating.svg',
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                          white,
                                                          BlendMode.srcIn),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'No rating',
                                                  style: tStyle.copyWith(
                                                      color: white,
                                                      fontSize: 13),
                                                ),
                                              ])
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icons/ic_rating.svg',
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                dataMovies[slideCarrousel]
                                                        ['vote_average']
                                                    .toString(),
                                                style: tStyle.copyWith(
                                                    color: white, fontSize: 13),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const CircleAvatar(
                                                backgroundColor: white,
                                                radius: 2,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                dataMovies[slideCarrousel]
                                                            ['vote_count'] <
                                                        2
                                                    ? '${dataMovies[slideCarrousel]['vote_count']} Person'
                                                        .toString()
                                                    : '${dataMovies[slideCarrousel]['vote_count']} People'
                                                        .toString(),
                                                style: tStyle.copyWith(
                                                    color: white, fontSize: 13),
                                              ),
                                            ],
                                          ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                      child: ShaderMask(
                                        shaderCallback: (bounds) {
                                          return LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                white,
                                                white.withOpacity(0),
                                              ],
                                              stops: const [
                                                0.6,
                                                1
                                              ]).createShader(bounds);
                                        },
                                        child: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                              maxHeight: 150),
                                          child: SingleChildScrollView(
                                            padding: const EdgeInsets.only(
                                                bottom: 60),
                                            clipBehavior: Clip.antiAlias,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            child: Text(
                                              dataMovies[slideCarrousel]
                                                          ['overview'] ==
                                                      ''
                                                  ? '- Synopsis is not available for now -'
                                                  : dataMovies[slideCarrousel]
                                                      ['overview'],
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.fade,
                                              style: tStyle.copyWith(
                                                  height: 2,
                                                  color: white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14.0, horizontal: 40),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BtnIconText(
                                              radius: 14,
                                              // width: 130,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 25),
                                              bgColor: secondaryColor,
                                              icon: SvgPicture.asset(
                                                  'assets/icons/ic_watchlist.svg',
                                                  colorFilter: ColorFilter.mode(
                                                      watchlist[slideCarrousel] !=
                                                              null
                                                          ? Colors.pink
                                                          : grey,
                                                      BlendMode.srcIn)),
                                              press: () {
                                                setState(() {});
                                                if (watchlist[slideCarrousel] ==
                                                    null) {
                                                  addWatchlist(
                                                      dataMovies,
                                                      slideCarrousel,
                                                      watchlist);
                                                } else {
                                                  removeWatchlist(watchlist,
                                                      slideCarrousel);
                                                }
                                              },
                                              text: Text(
                                                'Watchlist',
                                                style: tStyle.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: white,
                                                ),
                                              )),
                                          const SizedBox(
                                            width: 0,
                                          ),
                                          BtnIconText(
                                              radius: 14,
                                              width: 130,
                                              padding: const EdgeInsets.all(15),
                                              bgColor: primaryColor,
                                              press: () {
                                                Get.to(
                                                    () => BuyTicket(
                                                        title: dataMovies[
                                                                slideCarrousel]
                                                            ['title'],
                                                        imageUrl: dataMovies[
                                                                slideCarrousel]
                                                            ['poster_path']),
                                                    curve: Curves
                                                        .fastLinearToSlowEaseIn,
                                                    transition:
                                                        Transition.leftToRight);
                                              },
                                              text: Text(
                                                'Buy ticket',
                                                style: tStyle.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: white,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const CircularProgressIndicator(),
                    ]),
                    bottomNavigationBar: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 58.0),
                      child: MyNavbar(watchlist: watchlist),
                    ),
                  ),
                ),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }

  // Expanded _paralax_slider() {
  //   return Expanded(
  //     child: PageView.builder(
  //         onPageChanged: (value) {
  //           setState(() {
  //             slideCarrousel = value;
  //           });
  //         },
  //         itemCount: dataMovies.length,
  //         controller: pageController,
  //         itemBuilder: (context, i) {
  //           return Padding(
  //             padding: const EdgeInsets.only(right: 60.0),
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(18),
  //               clipBehavior: Clip.antiAlias,
  //               child: Transform.scale(
  //                 alignment: Alignment(-slider.abs() + i, 0),
  //                 scale: 1.25,
  //                 child: CachedNetworkImage(
  //                   filterQuality: FilterQuality.low,
  //                   fit: BoxFit.cover,
  //                   imageUrl:
  //                       'https://image.tmdb.org/t/p/w500${dataMovies[i]['poster_path']}',
  //                   progressIndicatorBuilder:
  //                       (context, url, downloadProgress) => Center(
  //                     child: CircularProgressIndicator(
  //                         value: downloadProgress.progress),
  //                   ),
  //                   errorWidget: (context, url, error) => const Center(
  //                       child: SizedBox(
  //                           height: 40, width: 40, child: Icon(Icons.error))),
  //                 ),
  //               ),
  //             ),
  //           );
  //         }),
  //   );
  // }

  CarouselSlider _nowShowing() {
    return CarouselSlider.builder(
        options: CarouselOptions(
            height: 300,
            initialPage: slideCarrousel,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            // aspectRatio: 16 / 9,
            scrollPhysics: const BouncingScrollPhysics(),
            viewportFraction: 0.5,
            onPageChanged: (index, reason) {
              slideCarrousel = index;
              setState(() {
                // pageOffset = index;
                // id = dataMovies[slideCarrousel]['id'];

                // getDetailMovies(detailMovies, id);
                // print(id);
                // print('---------------------');
                // print(detailMovies.length);
                // print('---------------------');
                // print(detailMovies[slideCarrousel]['title']);
              });
            }),
        itemCount: dataMovies.length,
        carouselController: carouselController,
        itemBuilder: (context, i, realIndex) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(18),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              filterQuality: FilterQuality.low,
              fit: BoxFit.cover,
              imageUrl:
                  'https://image.tmdb.org/t/p/w500${dataMovies[i]['poster_path']}',
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
