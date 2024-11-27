import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:party_planner/services/mixins/config_mixin.dart';
import 'package:party_planner/style.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with ConfigMixin {
  final List<String> titles = [
    'Privacy Policy',
    'Terms of Use',
    'Version',
    'About us',
  ];

  final List<String> descriptions = [
    """The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.
Here is where you can list and ban behaviors and activities like:
Obscene, crude, or violent posts
False or misleading content
Breaking the law
Spamming or scamming the service or other users
Hacking or tampering with your website or app
Violating copyright laws
Harassing other users
Stalking other users
If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use.  The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.
Here is where you can list and ban behaviors and activities like:
Obscene, crude, or violent posts
False or misleading content
Breaking the law
Spamming or scamming the service or other users
Hacking or tampering with your website or app
Violating copyright laws
Harassing other users
Stalking other users
If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use.

The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.
Here is where you can list and ban behaviors and activities like:
Obscene, crude, or violent posts
False or misleading content
Breaking the law
Spamming or scamming the service or other users
Hacking or tampering with your website or app
Violating copyright laws
Harassing other users
Stalking other users
If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use. """,
    """The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.
Here is where you can list and ban behaviors and activities like:
Obscene, crude, or violent posts
False or misleading content
Breaking the law
Spamming or scamming the service or other users
Hacking or tampering with your website or app
Violating copyright laws
Harassing other users
Stalking other users
If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use.  The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.
Here is where you can list and ban behaviors and activities like:
Obscene, crude, or violent posts
False or misleading content
Breaking the law
Spamming or scamming the service or other users
Hacking or tampering with your website or app
Violating copyright laws
Harassing other users
Stalking other users
If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use.

The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.
Here is where you can list and ban behaviors and activities like:
Obscene, crude, or violent posts
False or misleading content
Breaking the law
Spamming or scamming the service or other users
Hacking or tampering with your website or app
Violating copyright laws
Harassing other users
Stalking other users
If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use. """,
    """The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.
Here is where you can list and ban behaviors and activities like:
Obscene, crude, or violent posts
False or misleading content
Breaking the law
Spamming or scamming the service or other users
Hacking or tampering with your website or app
Violating copyright laws
Harassing other users
Stalking other users
If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use.  The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.
Here is where you can list and ban behaviors and activities like:
Obscene, crude, or violent posts
False or misleading content
Breaking the law
Spamming or scamming the service or other users
Hacking or tampering with your website or app
Violating copyright laws
Harassing other users
Stalking other users
If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use.

The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.
Here is where you can list and ban behaviors and activities like:
Obscene, crude, or violent posts
False or misleading content
Breaking the law
Spamming or scamming the service or other users
Hacking or tampering with your website or app
Violating copyright laws
Harassing other users
Stalking other users
If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use. """,
    """The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.
Here is where you can list and ban behaviors and activities like:
Obscene, crude, or violent posts
False or misleading content
Breaking the law
Spamming or scamming the service or other users
Hacking or tampering with your website or app
Violating copyright laws
Harassing other users
Stalking other users
If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use.  The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.
Here is where you can list and ban behaviors and activities like:
Obscene, crude, or violent posts
False or misleading content
Breaking the law
Spamming or scamming the service or other users
Hacking or tampering with your website or app
Violating copyright laws
Harassing other users
Stalking other users
If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use.

The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.
Here is where you can list and ban behaviors and activities like:
Obscene, crude, or violent posts
False or misleading content
Breaking the law
Spamming or scamming the service or other users
Hacking or tampering with your website or app
Violating copyright laws
Harassing other users
Stalking other users
If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use. """,
  ];

  int _currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bgColor,
      appBar: AppBar(
        backgroundColor: Style.bgColor,
        title: Text(
          'Settings',
          style: Style.textStyle.copyWith(
            color: Color.fromRGBO(52, 52, 52, 1),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoPopupSurface(
                        child: Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Expanded(
                                child: WebViewWidget(
                                  controller: WebViewController()
                                    ..loadRequest(
                                      Uri.parse(privacyLink),
                                    ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Style.bgColor,
                        border: Border.all(
                          width: 1,
                          color: Color.fromRGBO(169, 169, 169, 1),
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.white,
                            ),
                            child: SvgPicture.asset(
                                'Assets/Icons/material-symbols_privacy-tip-outline-rounded.svg'),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Privacy Policy',
                            style: Style.textStyle.copyWith(
                              color: Color.fromRGBO(52, 52, 52, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoPopupSurface(
                        child: Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Expanded(
                                child: WebViewWidget(
                                  controller: WebViewController()
                                    ..loadRequest(
                                      Uri.parse(termsLink),
                                    ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Style.bgColor,
                        border: Border.all(
                          width: 1,
                          color: Color.fromRGBO(169, 169, 169, 1),
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.white,
                            ),
                            child: SvgPicture.asset(
                                'Assets/Icons/jam_document-f.svg'),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Terms of Use',
                            style: Style.textStyle.copyWith(
                              color: Color.fromRGBO(52, 52, 52, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async => await FlutterEmailSender.send(
                Email(
                    recipients: ['GavrilIl99@icloud.com'],
                    subject: 'Message to support',
                    body: 'Put your message here...'),
              ),
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  color: Style.bgColor,
                  border: Border.all(
                    width: 1,
                    color: Color.fromRGBO(169, 169, 169, 1),
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                      ),
                      child: SvgPicture.asset('Assets/Icons/mdi_about.svg'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Support',
                      style: Style.textStyle.copyWith(
                        color: Color.fromRGBO(52, 52, 52, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async => await InAppReview.instance.requestReview(),
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  color: Style.bgColor,
                  border: Border.all(
                    width: 1,
                    color: Color.fromRGBO(169, 169, 169, 1),
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                      ),
                      child: SvgPicture.asset(
                          'Assets/Icons/material-symbols_star-rate-outline-rounded.svg'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Rate Us',
                      style: Style.textStyle.copyWith(
                        color: Color.fromRGBO(52, 52, 52, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          _AppInfo(),
        ],
      ),
    );
  }

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: 147,
            child: Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    'Rate us',
                    style: Style.textStyle.copyWith(
                      fontSize: 18,
                    ),
                  ),
                ),
                // SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < _currentRating ? Icons.star : Icons.star_border,
                        color:
                            index < _currentRating ? Colors.amber : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _currentRating = index + 1;
                        });
                        Navigator.of(context).pop();
                      },
                    );
                  }),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(169, 169, 169, 1),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: Style.textStyle.copyWith(
                          color: Color.fromRGBO(240, 76, 47, 1),
                        ),
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Done',
                        style: Style.textStyle.copyWith(
                          color: Color.fromRGBO(106, 195, 38, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TextScreen extends StatelessWidget {
  final String title;
  final String description;

  TextScreen({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bgColor,
      appBar: AppBar(
        backgroundColor: Style.bgColor,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Markdown(
          data: description,
          styleSheet: MarkdownStyleSheet(
            h1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            h2: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            h3: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            p: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class _AppInfo extends StatelessWidget {
  const _AppInfo();

  @override
  Widget build(BuildContext context) {
    final info = AppInfo.of(context);
    final version = info.package.version;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'Assets/Icons/icon.png',
                  width: 80,
                  height: 80,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(info.package.appName,
                        style: Style.textStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        )),
                    Text(
                      '${version.major}.${version.minor}.${version.patch}',
                      style: Style.textStyle.copyWith(
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
