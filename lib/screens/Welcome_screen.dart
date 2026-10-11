import 'package:flutter/material.dart';
import 'package:smart_medication_system/screens/role_selection_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> _introImages = [
    "assets/images/Care illustration(1).png",
    "assets/images/photo_2026-10-08_12-51-03.jpg",
    "assets/images/photo_2026-10-08_12-51-22.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFD5EAF4),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/Hospital mark.png",
                      height: 50,
                    ),
                    Text(
                      "Healix",
                      style: TextStyle(
                        color: Color(0XFF002F5F),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  "Smart Healthcare for a\n Better Tomorrow",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0XFF002F5F),
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 30,),
                SizedBox(
                  height: 400,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _introImages.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Center(
                        child: Container(
                          width: 320,
                          height: 380,
                          decoration: BoxDecoration(
                            color: Color(0xFFD5EAF4),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 15,
                                offset:  Offset(0, 5),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              _introImages[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _introImages.length,
                        (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 6,
                      width: _currentIndex == index ? 22 : 8,
                      decoration: BoxDecoration(
                        color: _currentIndex == index ?  Colors.green.shade700 : Colors.grey,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Text(
                  "Connect with your doctor, manage your medications,\n and keep your health records in one place.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0XFF607D8B)
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 350,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF087FC8),
                        Color(0xFF00A683),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentIndex < _introImages.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.push(context,MaterialPageRoute(builder:(context) =>RoleSelectionScreen()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Get Started",
                          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
