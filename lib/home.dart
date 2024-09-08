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
    double width = MediaQuery.of(context).size.width;

    bool isPortrait =
        MediaQuery.of(context).size.width <= MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 51, 51, 51),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: width * 0.125, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Header(),
              const SizedBox(
                height: 100,
              ),
              Stack(children: <Widget>[
                Align(
                  alignment:
                      isPortrait ? Alignment.centerLeft : Alignment.center,
                  child: Container(
                    height: 600,
                    width: isPortrait ? null : 600,
                    alignment: isPortrait ? null : Alignment.centerLeft,
                    child: Image.asset(
                      portraitPNG,
                      height: 600,
                    ),
                  ),
                ),
                const Positioned.fill(
                    child: Center(child: HeaderAboutRichText())),
                const Positioned(
                  right: 0,
                  bottom: 0,
                  child: HeaderLinkIcons(),
                )
              ]),
              const SizedBox(
                height: 50,
              ),
              const Divider(
                color: Colors.amber,
              ),
              AboutMe(isPortrait: isPortrait),
              const SizedBox(
                height: 50,
              ),
              Skills(isPortrait: isPortrait, width: width)
            ],
          ),
        ),
      ),
    );
  }
}

class Skills extends StatelessWidget {
  const Skills({
    super.key,
    required this.isPortrait,
    required this.width,
  });

  final bool isPortrait;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Skills",
          style: TextStyle(
              fontSize: 36,
              color: Colors.amber,
              fontFamily: 'PlayFair',
              fontVariations: [FontVariation('wght', 800)]),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: isPortrait ? 0 : width * 0.1),
          child: Center(
            child: Wrap(
              children: skills
                  .map(
                    (e) => Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.all(10),
                      height: 200,
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            e.asset,
                            height: 80,
                          ),
                          Text(e.name, style: const TextStyle(fontSize: 20)),
                          Text("${e.year} year/s",
                              style: const TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class HeaderLinkIcons extends StatelessWidget {
  const HeaderLinkIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          linkedinPNG,
          height: 40,
          color: Colors.amber,
        ),
        SizedBox(height: 5),
        Image.asset(
          githubPNG,
          height: 40,
          color: Colors.amber,
        ),
        SizedBox(height: 5),
        Image.asset(
          fbPNG,
          height: 40,
          color: Colors.amber,
        ),
      ],
    );
  }
}

class AboutMe extends StatelessWidget {
  const AboutMe({
    super.key,
    required this.isPortrait,
  });

  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isPortrait ? 0 : 120),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About Me",
            style: TextStyle(
                fontSize: 36,
                color: Colors.amber,
                fontFamily: 'PlayFair',
                fontVariations: [FontVariation('wght', 800)]),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40),
            child: Text(
              aboutMe,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                // fontVariations: [FontVariation('wght', 800)],
              ),
            ),
          ),
        ],
      ),
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
          text: "James\n",
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
