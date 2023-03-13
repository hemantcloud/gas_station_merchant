import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: const Text('Home',style: TextStyle(fontSize: 18.0,)),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 16.0),
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(14.0),
                color: Colors.white,
                border: Border.all(color: const Color(0xFFbfbfbf),width: 0,style: BorderStyle.solid),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFbfbfbf),
                    offset: Offset(
                      0.0,
                      0.0,
                    ),
                    blurRadius: 4.0,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    maxRadius: 30.0,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome, John',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const Text(
                          "steveaustin@gmail.com",
                          style: TextStyle(color: AppColors.secondary,fontSize: 12.0),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/star.svg'),
                            const SizedBox(width: 5.0),
                            const Text(
                              '4.5',
                              style: TextStyle(color: AppColors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
      // extendBodyBehindAppBar: true,
    );
  }
}