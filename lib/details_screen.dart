import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:happy_birthday_suwa/context_extension.dart';
import 'package:happy_birthday_suwa/main.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(birthdayData.name),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                child: Hero(
                  tag: "birthday-name",
                  child: Text(
                    "Happy Birthday\n${birthdayData.name}",
                    style: context.textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const RenderWishes(),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: context.colorScheme.onBackground.withOpacity(0.4),
                      width: 2,
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Your smile brightens the darkest days, Your love warms my heart in countless ways. With you by my side, life feels complete, My soulmate, my love, my forever treat. Today we celebrate your birth, And honor the woman of priceless worth. May your birthday be filled with joy and bliss, And sealed with a passionate, everlasting kiss.",
                  style: context.textTheme.bodySmall!.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "- Rafey (your chubby hamsta)",
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RenderWishes extends StatefulWidget {
  const RenderWishes({super.key});

  @override
  State<RenderWishes> createState() => _RenderWishesState();
}

class _RenderWishesState extends State<RenderWishes> {
  static const birthdayWishes = [
    "Happy birthday to a woman who lights up every room she walks into! May your day be as bright and beautiful as your radiant smile.",
    "Wishing a very happy birthday to my amazing friend! You're a true gem – kind, funny, and always there for me. I hope your special day is filled with love, laughter, and all the things that make you happiest.",
    "Happy birthday to a remarkable woman who inspires me every day. Your strength, compassion, and resilience are truly admirable. I hope this year brings you an abundance of joy, success, and personal growth.",
    "To my dearest friend, happy birthday! You're a talented, intelligent, and gorgeous woman who deserves all the happiness in the world. May this year be your best one yet, filled with exciting adventures and wonderful memories.",
    "Happy birthday to a woman who is not only beautiful on the outside but also has a heart of pure gold. Your kindness, loyalty, and positivity make you truly one-of-a-kind. I'm so grateful to have you in my life.",
    "Wishing a fabulous birthday to the most fabulous woman I know! You're a trendsetter, a risk-taker, and someone who always stays true to herself. Keep shining bright and living life to the fullest.",
    "Happy birthday to a woman who wears many hats – a loving friend, a dedicated professional, and a role model to many. May this special day be a reminder of how much you are appreciated and loved.",
    "On your birthday, I want you to know that you are an incredible woman who deserves all the best things in life. Your warmth, generosity, and zest for life are truly inspiring. Happy birthday, my dear friend!",
    "Happy birthday to a woman who has a heart as beautiful as her smile. You bring so much joy and positivity into the lives of those around you. I hope your day is filled with love, laughter, and all the things that make you happy.",
    "Wishing you a very happy birthday, my dear friend! You are a strong, independent woman who always follows her dreams and never settles for less. May this year be filled with countless opportunities for growth and success."
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    _showNextWish();
    super.initState();
  }

  void _showNextWish() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % birthdayWishes.length;
    });

    Future.delayed(
      const Duration(seconds: 5),
      () {
        if (_currentIndex != 0) {
          _showNextWish();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: const Offset(0, 0),
          ).animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: Text(
        key: ValueKey(_currentIndex),
        birthdayWishes[_currentIndex],
      ),
    );
  }
}
