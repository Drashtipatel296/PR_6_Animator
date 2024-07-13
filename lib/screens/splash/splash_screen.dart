import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pr_6_space_app/screens/home/home_screen.dart';
import 'package:pr_6_space_app/utils/global_var.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.4,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/img/bg.jpg'),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 110, left: 20, right: 20),
                height: 350,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/img/spl.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Text(
                textAlign: TextAlign.center,
                'Explore the\nuniverse!',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 53,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                textAlign: TextAlign.center,
                'Learn more about the\nuniverse where we all live.',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.grey,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 55,
              ),
              Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(changePage(const HomeScreen(),),);
                  },
                  icon: const Icon(
                    Icons.play_arrow,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
