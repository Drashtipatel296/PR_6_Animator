import 'dart:convert';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pr_6_space_app/screens/favourite/like_screen.dart';
import 'package:provider/provider.dart';
import '../../controller/data_provider.dart';
import '../../model/data_model.dart';
import '../../utils/global_var.dart';
import '../detail/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    PlanetProvider planetProviderT = Provider.of<PlanetProvider>(context);
    PlanetProvider planetProviderF =
        Provider.of<PlanetProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Solar System',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<String>(
        future: rootBundle.loadString('assets/json/json_data.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading data'),
            );
          } else if (snapshot.hasData) {
            List<dynamic> data = jsonDecode(snapshot.data ?? '');
            planetProviderF.setData(data);
            return Stack(
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
                Swiper(
                  itemCount: planetProviderT.jsonData.length,
                  itemWidth: 450.0,
                  itemHeight: 750.0,
                  layout: SwiperLayout.TINDER,
                  pagination: const SwiperPagination(
                    margin: EdgeInsets.only(bottom: 15),
                    builder: DotSwiperPaginationBuilder(
                      space: 3,
                      activeColor: Colors.white,
                      color: Colors.grey,
                      size: 6.0,
                      activeSize: 8.0,
                    ),
                  ),
                  itemBuilder: (context, index) {
                    Planets planet = planetProviderT.jsonData[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              changePage(DetailScreen(
                                planet: planet,
                              )),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 500,
                                margin: EdgeInsets.only(top: 140),
                                decoration: BoxDecoration(
                                  color: Color(0xff29272A),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 130,
                                      ),
                                      Text(
                                        planet.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 58,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        planet.description,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 8,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 45,
                                      ),
                                      Text(
                                        'Details >',
                                        style: GoogleFonts.poppins(
                                          color: Colors.blue.shade900,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 340,
                                child: RotationTransition(
                                  turns: _controller,
                                  child: Hero(
                                    tag: planet.hero,
                                    child: Container(
                                      height: 300,
                                      width: 340,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(planet.image),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
      backgroundColor: Colors.transparent,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 65,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff29272A),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.home, color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search, color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.bookmark_add, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(changePage(LikeScreen(),),);
                },
                icon: Icon(Icons.favorite, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
