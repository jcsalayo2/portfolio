import 'package:flutter/material.dart';
import 'package:portfolio/constant.dart';
import 'package:portfolio/main.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).size.width <= MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 51, 51, 51),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Header(),
              const SizedBox(
                height: 100,
              ),
              if (isPortrait) ...[
                Stack(children: <Widget>[
                  Image.asset(
                    'image.png',
                    height: 600,
                  ),
                  Positioned.fill(child: Center(child: HeaderAboutRichText())),
                ])
              ] else ...[
                const HeaderAbout(),
              ]
              // About
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderAboutPortrait {
  const HeaderAboutPortrait();
}

class HeaderAbout extends StatelessWidget {
  const HeaderAbout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Name
        HeaderAboutRichText(),
        // Image
        Image.asset(
          'image.png',
          height: 600,
        )
      ],
    );
  }
}

class HeaderAboutRichText extends StatelessWidget {
  const HeaderAboutRichText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: const TextSpan(
      style: TextStyle(fontSize: 32, color: Colors.white),
      children: [
        TextSpan(text: "I'M "),
        TextSpan(
          text: "James Carlo\n",
          style: TextStyle(
              fontSize: 46,
              color: Colors.amber,
              fontFamily: 'PlayFair',
              fontVariations: [FontVariation('wght', 800)]),
        ),
        TextSpan(
          text: "A software engineer",
        ),
      ],
    ));
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {},
            child: Text(
              'About',
              style: textHeader,
            )),
        const SizedBox(width: 20),
        TextButton(
            onPressed: () {},
            child: Text(
              'Portfolio',
              style: textHeader,
            )),
        const SizedBox(width: 20),
        TextButton(
            onPressed: () {},
            child: Text(
              'Contacts',
              style: textHeader,
            )),
      ],
    );
  }
}
