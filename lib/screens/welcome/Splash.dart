import 'package:flutter/material.dart';

import 'Welcome_screen.dart';


class Splash extends StatefulWidget{
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    Future.delayed( Duration(seconds: 7), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        ),
      );
    });
  }
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
            padding: const EdgeInsets.symmetric(vertical: 70),
            child: Column(
              children: [
                Image.asset("assets/images/Hospital mark.png",height: 120,),
                Text("Healix",
                  style: TextStyle(
                      color: Color(0XFF002F5F),
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),),
                SizedBox(height: 40,),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration:  Duration(seconds: 8),
                  builder: (context, value, child) {
                    double rotationValue = 0.0;
                    double opacityValue = 1.0;
                    if (value <= 0.25) {
                      rotationValue = 0.0;
                      opacityValue = 1.0;
                    } else if (value > 0.25 && value <= 0.50) {
                      double p = (value - 0.25) / 0.25;
                      rotationValue = p * 6.28;
                      opacityValue = p <= 0.5 ? (1.0 - (p * 2)) : ((p - 0.5) * 2);
                    } else if (value > 0.50 && value <= 0.75) {
                      rotationValue = 0.0;
                      opacityValue = 1.0;
                    } else {
                      double p = (value - 0.75) / 0.25;
                      rotationValue = p * 6.28;
                      opacityValue = p <= 0.5 ? (1.0 - (p * 2)) : ((p - 0.5) * 2);
                    }
                    return Column(
                      children: [
                        Opacity(
                          opacity: opacityValue,
                          child: Transform.rotate(
                            angle: rotationValue,
                            child: Image.asset(
                              "assets/images/-Image 2026-10-08 at 12.14.56 AM(1)(1).png",
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),
                        Opacity(
                          opacity: opacityValue,
                          child: Container(
                            width: 170,
                            height: 6,
                            decoration: const BoxDecoration(
                              gradient: RadialGradient(
                                center: Alignment.center,
                                radius: 0.5,
                                colors: [
                                  Color(0x25000000),
                                  Color(0x08000000),
                                  Colors.transparent,
                                ],
                                stops: [0.0, 0.6, 1.0],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 15,),
                Container(
                  width: 200,
                  height: 18,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.elliptical(150, 8)),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0XFF00446E).withOpacity(0.25),
                            blurRadius: 12,
                            spreadRadius: 3
                        )
                      ]
                  ),
                ),
                SizedBox(height: 90,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: 3.5,
                          child: Stack(
                            children: [
                              Container(
                                color: Color(0xFFE0E0E0),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 1),
                                child:  LinearProgressIndicator(
                                  backgroundColor: Colors.transparent,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent),
                                ),
                              ),
                              ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (bounds) => LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFF1B5E20),
                                    Color(0xFF81C784),
                                  ],
                                ).createShader(bounds),
                                child:LinearProgressIndicator(
                                  backgroundColor: Colors.transparent,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  minHeight: 3.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Preparing Your Health...',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF757575),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
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