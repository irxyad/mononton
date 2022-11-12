import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mononton/screens/homepage.dart';
import 'package:mononton/service/api.dart';
import '../constanta.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(systemNavigationBarColor: Colors.black),
      child: WillPopScope(
        onWillPop: () async {
          Get.to(() => const HomePage());
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Ticket Page',
              style: tStyle.copyWith(
                  color: white, fontSize: 19, fontWeight: FontWeight.bold),
            ),
            leading: GestureDetector(
              onTap: () => Get.to(() => const HomePage(),
                  transition: Transition.upToDown),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: white,
              ),
            ),
            backgroundColor: Colors.black,
            elevation: 0,
          ),
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: LottieBuilder.asset(
                      'assets/images/sleep.json',
                      height: 100,
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.contain,
                      frameRate: FrameRate.max,
                      repeat: true,
                    )),
                Text(
                  'Lanjutnyaa ntar yak\nLagi rebahan doi',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.niconne().copyWith(
                      color: white,
                      fontSize: 28,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({
    super.key,
  });

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  List watchlist = [];

  @override
  void initState() {
    super.initState();
    loadWatchlist([]).then((value) {
      setState(() {
        watchlist = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(systemNavigationBarColor: Colors.black),
      child: WillPopScope(
        onWillPop: () async {
          Get.to(() => const HomePage());
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Watchlist Page',
              style: tStyle.copyWith(
                  color: white, fontSize: 19, fontWeight: FontWeight.bold),
            ),
            leading: GestureDetector(
              onTap: () => Get.to(() => const HomePage()),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: white,
              ),
            ),
            backgroundColor: Colors.black,
            elevation: 0,
          ),
          backgroundColor: Colors.black,
          body: ListView(
            children: [
              for (int i = 0; i < watchlist.length; i++)
                watchlist[i] != null
                    ? Container(
                        margin: allPadding,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: secondaryColor),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            SizedBox(
                              // height: 150,
                              width: double.infinity,
                              child: CachedNetworkImage(
                                filterQuality: FilterQuality.low,
                                fit: BoxFit.cover,
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500${watchlist[i]['poster_path']}',
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {});
                                      removeWatchlist(watchlist, i);
                                    },
                                    child: SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: SvgPicture.asset(
                                        'assets/icons/ic_watchlist.svg',
                                        color: Colors.pink.shade600,
                                      ),
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      color: black.withOpacity(.5),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Text(
                                              watchlist[i]['title'],
                                              overflow: TextOverflow.ellipsis,
                                              style: tStyle.copyWith(
                                                  color: white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            height: 50,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          0),
                                                  alignment: Alignment.center,
                                                  shape: MaterialStateProperty.all(
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .zero)),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          primaryColor),
                                                  padding:
                                                      MaterialStateProperty.all(
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 10))),
                                              onPressed: () {
                                                (watchlist.length);
                                              },
                                              child: Text(
                                                'BUY TICKET',
                                                style: tStyle.copyWith(
                                                    color: white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(systemNavigationBarColor: Colors.black),
      child: WillPopScope(
        onWillPop: () async {
          Get.to(() => const HomePage());
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'More Page',
              style: tStyle.copyWith(
                  color: white, fontSize: 19, fontWeight: FontWeight.bold),
            ),
            leading: GestureDetector(
              onTap: () => Get.to(() => const HomePage(),
                  transition: Transition.upToDown),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: white,
              ),
            ),
            backgroundColor: Colors.black,
            elevation: 0,
          ),
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: LottieBuilder.asset(
                      'assets/images/sleep.json',
                      height: 100,
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.contain,
                      frameRate: FrameRate.max,
                      repeat: true,
                    )),
                Text(
                  'Lanjutnyaa ntar yak\nLagi rebahan doi',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.niconne().copyWith(
                      color: white,
                      fontSize: 28,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Upcoming extends StatelessWidget {
  const Upcoming({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(systemNavigationBarColor: Colors.black),
      child: WillPopScope(
        onWillPop: () async {
          Get.to(() => const HomePage());
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Upcoming Page',
              style: tStyle.copyWith(
                  color: white, fontSize: 19, fontWeight: FontWeight.bold),
            ),
            leading: GestureDetector(
              onTap: () => Get.to(() => const HomePage(),
                  transition: Transition.upToDown),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: white,
              ),
            ),
            backgroundColor: Colors.black,
            elevation: 0,
          ),
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: LottieBuilder.asset(
                      'assets/images/sleep.json',
                      height: 100,
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.contain,
                      frameRate: FrameRate.max,
                      repeat: true,
                    )),
                Text(
                  'Lanjutnyaa ntar yak\nLagi rebahan doi',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.niconne().copyWith(
                      color: white,
                      fontSize: 28,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
