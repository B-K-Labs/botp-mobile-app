import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/common.dart';
import "package:flutter/material.dart";
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({Key? key}) : super(key: key);

  @override
  State<WalkThroughScreen> createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  @override
  Widget build(BuildContext context) {
    return const ScreenWidget(hasAppBar: false, body: WalkThroughBody());
  }
}

class WalkThroughBody extends StatefulWidget {
  const WalkThroughBody({Key? key}) : super(key: key);

  @override
  State<WalkThroughBody> createState() => _WalkThroughBodyState();
}

class _WalkThroughBodyState extends State<WalkThroughBody> {
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);

  int _selectedPage = 0;
  List<Map<String, String>> walkThroughItemsList = [
    {
      "title": "Better Two-factor authentication",
      "description": "Directly confirm or reject the transaction in 2FA",
    },
    {
      "title": "More transparent with Blockchain",
      "description": "Lookup transaction right from Blockchain",
    },
    {
      "title": "Recoverable account",
      "description": "Back up once, import everywhere",
    },
  ];

  _onPageChanged(int page) {
    setState(() {
      _selectedPage = page;
    });
  }

  get isReadAll => _selectedPage == walkThroughItemsList.length - 1;

  @override
  Widget build(BuildContext context) {
    return Column(children: [_walkThroughView(), _actionButton()]);
  }

  Widget _walkThroughView() {
    return Expanded(
        child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          Column(children: [
            SizedBox(
                height: 300,
                child: PageView.builder(
                  onPageChanged: _onPageChanged,
                  // physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  itemCount: walkThroughItemsList.length,
                  itemBuilder: (context, index) {
                    final String title = walkThroughItemsList[index]["title"]!;
                    final String description =
                        walkThroughItemsList[index]["description"]!;
                    final String? imageUrl =
                        walkThroughItemsList[index]["imageUrl"];
                    return WalkThroughItemWidget(
                        title: title,
                        description: description,
                        imageUrl: imageUrl);
                  },
                ))
          ]),
          Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kAppPaddingHorizontalSize),
              child: SmoothPageIndicator(
                controller: _pageController, // PageController
                count: 3,
                effect: WormEffect(
                  dotColor: Theme.of(context).colorScheme.primaryContainer,
                  dotHeight: 8.0,
                  dotWidth: 8.0,
                  activeDotColor: Theme.of(context).colorScheme.primary,
                ), // your preferred effect
                onDotClicked: (index) {
                  _pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubicEmphasized);
                },
              )),
        ])));
  }

  Widget _actionButton() {
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kAppPaddingHorizontalSize,
            vertical: kAppPaddingVerticalSize),
        child: Row(children: [
          isReadAll
              ? Container()
              : Expanded(
                  child: Row(children: [
                  Expanded(
                      child: ButtonNormalWidget(
                          text: "Skip",
                          type: ButtonNormalType.secondaryOutlined,
                          onPressed: () {
                            context.read<SessionCubit>().completedWalkThrough();
                          })),
                  const SizedBox(width: kAppPaddingBetweenItemSmallSize)
                ])),
          Expanded(
              child: ButtonNormalWidget(
                  text: isReadAll ? "Get started" : "Next",
                  onPressed: isReadAll
                      ? () {
                          context.read<SessionCubit>().completedWalkThrough();
                        }
                      : () {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOutCubicEmphasized);
                        }))
        ]));
  }
}

class WalkThroughItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final String? imageUrl;
  const WalkThroughItemWidget(
      {Key? key, required this.title, required this.description, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // WalkThrough theme
    // - Text
    final titleStyle = Theme.of(context).textTheme.bodyMedium;
    final descriptionStyle = Theme.of(context)
        .textTheme
        .headlineSmall
        ?.copyWith(color: Theme.of(context).colorScheme.primary);
    return Container(
        padding:
            const EdgeInsets.symmetric(horizontal: kAppPaddingHorizontalSize),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              imageUrl != null
                  ? SizedBox(
                      height: 120.0,
                      width: 120.0,
                      child: Image.network(imageUrl!,
                          scale: 1, fit: BoxFit.contain))
                  : SizedBox(
                      height: 120.0,
                      width: 120.0,
                      child: Image.asset("assets/images/temp/botp_temp.png",
                          scale: 1, fit: BoxFit.contain),
                    ),
              const SizedBox(height: 60.0),
              Text(title, style: titleStyle),
              const SizedBox(height: kAppPaddingBetweenItemSmallSize),
              Text(description, style: descriptionStyle),
            ]));
  }
}
