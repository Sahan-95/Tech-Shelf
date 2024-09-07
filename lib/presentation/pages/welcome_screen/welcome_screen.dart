import 'package:flutter/material.dart';

import 'package:book_store/presentation/utils/extensions/color_extension.dart';

import '../../utils/responsive/screen_sizes.dart';
import '../../utils/routes/custom_routes.dart';
import '../home_screen/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = displayHeight(context);
    double screenWidth = displayWidth(context);

    return Scaffold(
      body: Stack(
        children: [
          // background image
          Image.asset(
            'assets/images/welcome_screen/welcome_image.jpg',
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: screenHeight * 0.3,
              ),
              child: SizedBox(
                width: screenWidth * 0.65,
                height: screenHeight * 0.05,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          createRoute(
                            const HomeScreen(title: 'IT Book Store'),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.black, width: 4),
                    ),
                    child: Text(
                      "Explore Library",
                      style: TextStyle(
                          color: "#2F0650".toColor(),
                          fontWeight: FontWeight.w700,
                          fontSize: screenHeight * 0.025),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
