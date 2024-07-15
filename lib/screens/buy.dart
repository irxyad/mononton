import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mononton/widgets/background.dart';
import 'package:mononton/widgets/button.dart';
import '../constanta.dart';
import '../data_mall.dart';
import 'homepage.dart';

class BuyTicket extends StatefulWidget {
  const BuyTicket({super.key, required this.imageUrl, required this.title});
  final String imageUrl;
  final String title;
  @override
  State<BuyTicket> createState() => _BuyTicketState();
}

final _current = DateTime.now();
final _currentDay = DateFormat('EEE');
final _currentDate = DateFormat('d');

class _BuyTicketState extends State<BuyTicket> {
  int _indexDate = 8;
  int _indexTime = 0;

  void _pickDate(int index) {
    setState(() => _indexDate = index);
  }

  void _picTime(int index) {
    setState(() => _indexTime = index);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(systemNavigationBarColor: primaryColor),
      child: BlurBackground(
        imageUrl: 'https://image.tmdb.org/t/p/w500${widget.imageUrl}',
        child: SafeArea(
          bottom: true,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'SCHEDULE',
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
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Column(
              children: <Widget>[
                Padding(
                  padding: hPadding.copyWith(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Booking for',
                            style: tStyle.copyWith(
                                color: grey, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            widget.title,
                            style: tStyle.copyWith(
                                color: white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      BtnIconText(
                        press: () {},
                        icon: SvgPicture.asset(
                          'assets/icons/ic_search.svg',
                          colorFilter:
                              const ColorFilter.mode(white, BlendMode.srcIn),
                        ),
                        bgColor: primaryColor,
                        radius: 12,
                        padding: const EdgeInsets.all(10),
                      )
                    ],
                  ),
                ),
                vSpace,
                SizedBox(
                  height: 75,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {});
                          _pickDate(8);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: _indexDate == 8
                                  ? primaryColor
                                  : secondaryColor,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(
                                  12,
                                ),
                                bottomRight: Radius.circular(
                                  12,
                                ),
                              )),
                          width: 90,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Today',
                                style: tStyle.copyWith(
                                    color: _indexDate == 8 ? white : grey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: _indexDate == 8
                                        ? white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Text(
                                  _currentDate.format(_current),
                                  style: tStyle.copyWith(
                                      color:
                                          _indexDate == 8 ? primaryColor : grey,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 7,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              // Check whether the index is the selected index.
                              final isSelected = index == _indexDate;
                              final now =
                                  _current.add(Duration(days: index + 1));
                              return Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, left: 8.0),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {
                                      _pickDate(index);
                                    },
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          color: isSelected
                                              ? primaryColor
                                              : secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Container(
                                        width: 60,
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _currentDay.format(now),
                                              style: tStyle.copyWith(
                                                  color:
                                                      isSelected ? white : grey,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? white
                                                      : Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14,
                                                      vertical: 8),
                                              child: Text(
                                                _currentDate.format(now),
                                                style: tStyle.copyWith(
                                                    color: isSelected
                                                        ? primaryColor
                                                        : grey,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                            }),
                      ),
                    ],
                  ),
                ),
                vSpace,
                Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: dataMall.length,
                        itemBuilder: (context, index) {
                          List time = dataMall[index]['time'];

                          return Padding(
                            padding: hPadding,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${dataMall[index]['name']}'
                                              .toUpperCase(),
                                          style: tStyle.copyWith(
                                              color: white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          '${dataMall[index]['address']}',
                                          style: tStyle.copyWith(
                                            color: grey,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${dataMall[index]['type']}'
                                                  .toUpperCase(),
                                              style: tStyle.copyWith(
                                                  color: white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            SvgPicture.asset(
                                              'assets/icons/ic_dropdown.svg',
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                      white, BlendMode.srcIn),
                                              height: 8,
                                            )
                                          ],
                                        ),
                                        Text(
                                          '${dataMall[index]['prize']}',
                                          style: tStyle.copyWith(
                                            color: grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 60.0, top: 11),
                                  child: SizedBox(
                                    height: 120,
                                    child: GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              crossAxisSpacing: 11,
                                              mainAxisSpacing: 11,
                                              childAspectRatio: 1.5),
                                      scrollDirection: Axis.vertical,
                                      itemCount: time.length,
                                      itemBuilder: (context, i) =>
                                          GestureDetector(
                                        onTap: () {
                                          _picTime(i);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          // margin: const EdgeInsets.only(
                                          //     right: 8, top: 8, bottom: 8),
                                          decoration: BoxDecoration(
                                              color: _indexTime == i
                                                  ? secondaryColor
                                                  : primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            dataMall[index]['time'][i],
                                            style: tStyle.copyWith(
                                                color: _indexTime == i
                                                    ? grey
                                                    : white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }))
              ],
            ),
            bottomSheet: InkWell(
              splashColor: Colors.red.shade700,
              onTap: () {},
              child: Ink(
                color: primaryColor,
                child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 50,
                    child: BtnTextIcon(
                      bgColor: Colors.transparent,
                      press: () {
                        showModalBottomSheet(
                          useRootNavigator: true,
                          enableDrag: true,
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: SizedBox(
                                height: Get.height / 1.5,
                                child: ClipRRect(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: black,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25))),
                                    child: SafeArea(
                                      bottom: true,
                                      child: Column(
                                        children: [
                                          vSpace,
                                          Text(
                                            'CHOOSE SEATS',
                                            style:
                                                tStyle.copyWith(fontSize: 18),
                                          ),
                                          vSpace,
                                          Container(
                                              padding: allPadding,
                                              height: 60,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Image.asset(
                                                  'assets/images/screens.png')),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: hPadding,
                                              child: GridView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: 120,
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        mainAxisSpacing: 8,
                                                        childAspectRatio: 4 / 4,
                                                        crossAxisSpacing: 8,
                                                        crossAxisCount: 10),
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: primaryColor),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          vSpace,
                                          Expanded(
                                              child: Column(
                                            children: [
                                              Padding(
                                                padding: hPadding,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 12,
                                                          width: 12,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3),
                                                              color: grey),
                                                        ),
                                                        hSpace,
                                                        Text(
                                                          'Available',
                                                          style:
                                                              tStyle.copyWith(
                                                                  fontSize: 13),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 12,
                                                          width: 12,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3),
                                                              color:
                                                                  primaryColor),
                                                        ),
                                                        hSpace,
                                                        Text(
                                                          'Your seat',
                                                          style:
                                                              tStyle.copyWith(
                                                                  fontSize: 13),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 12,
                                                          width: 12,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3),
                                                              color: darkGrey),
                                                        ),
                                                        hSpace,
                                                        Text(
                                                          'Reserved',
                                                          style:
                                                              tStyle.copyWith(
                                                                  fontSize: 13),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              vSpace,
                                              vSpace,
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          color: secondaryColor,
                                                          padding: allPadding,
                                                          child: Text(
                                                            'Cancel',
                                                            style:
                                                                tStyle.copyWith(
                                                                    fontSize:
                                                                        17),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          color: primaryColor,
                                                          padding: allPadding,
                                                          child: Text(
                                                            'Order summary',
                                                            style:
                                                                tStyle.copyWith(
                                                                    fontSize:
                                                                        17),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: white,
                      ),
                      text: Text(
                        'CHOOSE SEATS',
                        style: tStyle.copyWith(
                            color: white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
