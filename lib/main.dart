import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:happy_birthday_suwa/context_extension.dart';
import 'package:happy_birthday_suwa/details_screen.dart';
import 'package:happy_birthday_suwa/play_hbd_audio.dart';
import 'package:happy_birthday_suwa/scale_cake_img.dart';

void main() {
  runApp(const MainApp());
}

var birthdayData = (
  name: "Suwa",
  age: 18,
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffEE7999),
          primary: const Color(0xffEE7999),
          background: const Color(0xffFAE3EA),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    _controllerCenter = ConfettiController(
      duration: const Duration(seconds: 10),
    );
    _controllerCenter.play();
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiWidget(
                    emissionFrequency: 0.05,
                    confettiController: _controllerCenter,
                    blastDirectionality: BlastDirectionality.explosive,
                    shouldLoop: true,
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple,
                      Colors.yellow,
                    ],
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Hero(
                    tag: "birthday-name",
                    child: Material(
                      child: Text(
                        "Happy Birthday",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    birthdayData.name,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Image.asset("assets/pink-cake.png")
                  const ScaleCakeImg(),
                  const PlayHbdAudio(),
                  const CupCakeGlazeBtn(),
                ],
              ),
            ),
            Positioned(
              bottom: -30,
              right: -60,
              child: Transform.rotate(
                angle: -0.6,
                child: Image.asset(
                  height: 200,
                  width: 200,
                  "assets/hello-kitty-waving.gif",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CupCakeGlazeBtn extends StatefulWidget {
  const CupCakeGlazeBtn({super.key});

  @override
  State<CupCakeGlazeBtn> createState() => _CupCakeGlazeBtnState();
}

class _CupCakeGlazeBtnState extends State<CupCakeGlazeBtn>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _textAnimationController;
  late final Animation<double> _textAnimation;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Durations.medium1,
      lowerBound: 0.3,
    );
    _textAnimationController = AnimationController(
      vsync: this,
      duration: Durations.medium1,
      lowerBound: 0.3,
    );

    _textAnimation = Tween<double>(
      begin: 1,
      end: 0.9,
    ).animate(_textAnimationController);

    _animation = Tween<double>(
      begin: 1,
      end: 0.9,
    ).animate(_controller);
    _textAnimationController.repeat(
      reverse: true,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScaleTransition(
          scale: _textAnimation,
          child: Text.rich(
            TextSpan(
              text: "Click Here",
              style: context.textTheme.bodyLarge!.copyWith(),
              children: const [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.arrow_downward_rounded),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTapDown: (details) {
            _controller.forward();
          },
          onTapUp: (details) {
            _controller.reverse();
          },
          onTapCancel: () {
            _controller.reverse();
          },
          child: ScaleTransition(
            scale: _animation,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                foregroundDecoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  image: const DecorationImage(
                    image: AssetImage("assets/cup-cake-glaze.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const DetailsScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          Offset begin = const Offset(0.0, 1.0);
                          Offset end = Offset.zero;

                          Animatable<Offset> tween =
                              Tween<Offset>(begin: begin, end: end).chain(
                            CurveTween(curve: Curves.easeInOut),
                          );

                          Animation<Offset> pageAnimation =
                              animation.drive(tween);

                          return SlideTransition(
                            position: pageAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: const Text("Click Here"),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
