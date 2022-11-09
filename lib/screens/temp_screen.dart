import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mononton/screens/homepage.dart';
import '../constanta.dart';
import '../widgets/button.dart';

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

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key, required this.wishlist});
  final List wishlist;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(systemNavigationBarColor: Colors.black),
      child: WillPopScope(
        onWillPop: () async {
          // Get.to(() => const HomePage());
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
              child: wishlist.isEmpty
                  ? Column(
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
                    )
                  : ListView(
                      children: [
                        for (int i = 0; i < wishlist.length; i++)
                          wishlist[i]['isSelected'] == true
                              ? Container(
                                  margin: allPadding,
                                  width: MediaQuery.of(context).size.width,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      color: secondaryColor),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 200,
                                        width: double.infinity,
                                        child: CachedNetworkImage(
                                          filterQuality: FilterQuality.low,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${wishlist[i]['poster_path']}',
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                          ),
                                        ),
                                      ),
                                      Row(
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
                                              wishlist[i]['title'],
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
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10))),
                                              onPressed: () {
                                                print(wishlist);
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
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox()
                      ],
                    )

              // succes listview

              // ListView.builder(
              //     itemCount: wishlist.length,
              //     itemBuilder: (context, i) => Padding(
              //       padding: allPadding,
              //       child: Column(
              //         children: [
              //
              // Container(
              //             width: MediaQuery.of(context).size.width,
              //             clipBehavior: Clip.antiAlias,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(13),
              //                 color: secondaryColor),
              //             child: Column(
              //               children: [
              //                 SizedBox(
              //                   height: 200,
              //                   width: double.infinity,
              //                   child: CachedNetworkImage(
              //                     filterQuality: FilterQuality.low,
              //                     fit: BoxFit.cover,
              //                     imageUrl:
              //                         'https://image.tmdb.org/t/p/w500${wishlist[i]['poster_path']}',
              //                     progressIndicatorBuilder:
              //                         (context, url, downloadProgress) =>
              //                             Center(
              //                       child: CircularProgressIndicator(
              //                           value: downloadProgress.progress),
              //                     ),
              //                   ),
              //                 ),
              //                 Row(
              //                   children: [
              //                     const SizedBox(
              //                       width: 15,
              //                     ),
              //                     SizedBox(
              //                       width:
              //                           MediaQuery.of(context).size.width / 2,
              //                       child: Text(
              //                         wishlist[i]['title'],
              //                         overflow: TextOverflow.ellipsis,
              //                         style: tStyle.copyWith(
              //                             color: white,
              //                             fontWeight: FontWeight.bold,
              //                             fontSize: 14),
              //                       ),
              //                     ),
              //                     const Spacer(),
              //                     SizedBox(
              //                       height: 50,
              //                       child: ElevatedButton(
              //                         style: ButtonStyle(
              //                             elevation:
              //                                 MaterialStateProperty.all(0),
              //                             alignment: Alignment.center,
              //                             shape: MaterialStateProperty.all(
              //                                 const RoundedRectangleBorder(
              //                                     borderRadius:
              //                                         BorderRadius.zero)),
              //                             backgroundColor:
              //                                 MaterialStateProperty.all(
              //                                     primaryColor),
              //                             padding: MaterialStateProperty.all(
              //                                 EdgeInsets.symmetric(
              //                                     horizontal: 10))),
              //                         onPressed: () {
              //                           print(wishlist);
              //                         },
              //                         child: Text(
              //                           'BUY TICKET',
              //                           style: tStyle.copyWith(
              //                               color: white,
              //                               fontWeight: FontWeight.bold,
              //                               fontSize: 14),
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 )
              //               ],
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
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
