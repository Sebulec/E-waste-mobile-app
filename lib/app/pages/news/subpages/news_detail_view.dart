import 'dart:ui';

import 'package:e_waste/app/pages/news/news_model_view.dart';
import 'package:e_waste/app/widgets/analytics_screen.dart';
import 'package:e_waste/app/widgets/constants.dart';
import 'package:e_waste/app/widgets/ui_factory/ui_factory.dart';
import 'package:e_waste/data/services/analytics_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_html/flutter_html.dart';

import 'news_detail_controller.dart';

class NewsDetailPage extends View {
  final NewsModelView _newsModelView;

  NewsDetailPage(this._newsModelView);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState(_newsModelView);
}

class _NewsDetailPageState
    extends ViewState<NewsDetailPage, NewsDetailController>
    with AnalyticsScreen, SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    _scaleAnimation = CurvedAnimation(
        parent: _animationController, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    _animationController.forward();
  }

  @override
  String get screenName => ScreenName.NEWS_DETAIL_NAME;

  _NewsDetailPageState(NewsModelView newsModelView)
      : super(NewsDetailController(newsModelView)) {
    setCurrentScreen();
  }

  final String text = '''
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut eleifend nisl eget consectetur commodo. Fusce in sapien quis quam finibus sollicitudin. Nulla facilisi. Donec vitae lacus sed nisl maximus tempus sit amet vitae nisl. Mauris orci dui, mollis nec lacus sit amet, sollicitudin commodo felis. Sed vitae cursus risus. Sed imperdiet mi leo, vitae semper arcu commodo eu. Etiam tempus tortor in imperdiet scelerisque. Cras aliquam, est sed efficitur pellentesque, elit elit finibus neque, vulputate finibus urna felis non arcu. Proin at ornare velit. Nunc pharetra risus ac vestibulum lobortis. Aliquam ut venenatis dui. Donec sagittis eleifend lectus, non fringilla odio interdum sed.

Nullam velit risus, iaculis id posuere vel, mollis eu neque. Fusce euismod feugiat sapien vitae euismod. Morbi sed odio ac dui egestas consectetur. Pellentesque bibendum lobortis varius. Sed faucibus facilisis felis, et sagittis nibh dignissim eget. Phasellus eu orci leo. Phasellus bibendum tortor tellus, vitae mollis diam venenatis et. Sed id lorem et nunc eleifend lacinia ullamcorper eget libero. Proin elit dui, elementum vel ligula a, feugiat tincidunt metus. Nullam sit amet dignissim diam. Sed fermentum tempus sapien non rhoncus.

Donec posuere mauris non dui molestie blandit. Etiam at lacus mollis, porta lacus non, sagittis tortor. Curabitur ac lobortis risus, a aliquet ante. Aenean ut risus a magna aliquam gravida. Mauris venenatis aliquam metus, a egestas nisi bibendum a. Nulla sapien libero, vulputate quis nibh quis, egestas consectetur metus. Nunc elit tortor, posuere at convallis quis, dignissim a ante. Quisque et pulvinar elit, at imperdiet ipsum. Mauris eleifend ultricies erat, id sollicitudin tellus ornare a. Aliquam eu euismod sapien, et egestas nisl.

In gravida sapien in facilisis eleifend. Fusce hendrerit ultricies tortor, nec molestie turpis scelerisque quis. Aliquam nec tempor augue. Quisque fermentum varius sapien, eget faucibus leo malesuada eget. Nam efficitur nunc et consectetur fermentum. Cras luctus nibh vel rhoncus rutrum. In rutrum erat vel dolor porta, nec sagittis sem pharetra. Aliquam at sodales lorem. Vivamus vitae lorem elementum nisi hendrerit dapibus. Nulla elementum, magna non condimentum placerat, lacus mauris sagittis quam, ac tincidunt diam urna ut enim. Nulla dapibus, mauris et semper aliquet, lacus tellus lacinia erat, sit amet sagittis lacus magna quis odio. Sed eget nulla nec magna faucibus varius. Aenean tincidunt risus at euismod tempor. Morbi vitae ex malesuada, elementum ipsum non, sollicitudin augue. Mauris finibus eleifend libero et ultrices.

Sed lorem ex, eleifend id dui ac, placerat efficitur orci. Aliquam a commodo erat, ac elementum nulla. Interdum et malesuada fames ac ante ipsum primis in faucibus. Cras dapibus augue nec dui interdum, consectetur sollicitudin neque fringilla. Fusce viverra ornare lacus id ultricies. Pellentesque ac malesuada dolor, in vehicula massa. Integer semper urna eu turpis elementum faucibus. Mauris at ultrices nulla.

Quisque rhoncus at tortor at iaculis. Phasellus tellus augue, venenatis in placerat eget, ultricies vel mi. Ut vulputate interdum purus, id sollicitudin est ullamcorper ut. Fusce rhoncus ligula magna. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec vestibulum ultrices nisl, non scelerisque libero aliquet a. Aliquam blandit at tellus non pellentesque. Quisque ut faucibus est.

Maecenas placerat ornare nulla, quis efficitur urna luctus non. Nam ultricies eros ac metus pretium, sed dignissim eros lacinia. Quisque at diam nibh. Praesent pulvinar purus eros, sed lobortis arcu vehicula at. Sed ultricies lacus sit amet pretium cursus. Pellentesque mollis elit et odio lobortis ultricies. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin orci metus, porta nec tristique id, blandit id massa. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aenean venenatis faucibus mauris, ac faucibus elit. Suspendisse accumsan urna mi, id aliquet erat consectetur vitae. Nam ultrices efficitur iaculis. Ut sodales ornare ex, id dignissim odio dictum sed.

Nullam blandit a arcu ac euismod. Nunc nec vulputate lectus, sed volutpat lacus. Vivamus tempus tortor id nunc ultricies eleifend. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Integer tincidunt a est a scelerisque. Mauris fermentum dolor ac eleifend ullamcorper. Curabitur eu ex iaculis, fringilla odio fringilla, luctus lorem. Aliquam sagittis ipsum at nibh placerat, non egestas enim scelerisque. Vivamus finibus a diam eget accumsan. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.

Aenean id dolor eget nisi mattis sodales vel sed urna. Curabitur blandit ante pulvinar, venenatis ex in, lacinia ipsum. Nam dignissim, justo ultricies sagittis eleifend, lorem lacus egestas nulla, vitae molestie erat turpis dignissim libero. Nunc dignissim blandit nisi eget semper. Vestibulum quis eros viverra, pharetra ipsum at, faucibus neque. Pellentesque bibendum eleifend porta. Mauris mattis gravida finibus. Curabitur luctus eget quam at molestie. Proin imperdiet nibh in commodo feugiat. Aliquam maximus libero elit, non commodo metus iaculis at. Sed quis leo feugiat, sagittis purus sed, euismod urna. Cras congue nisl non molestie dapibus. Aenean in tempor ipsum.

Sed rhoncus luctus ante vitae vulputate. Proin at posuere turpis, id varius eros. In id aliquet tortor. Morbi vitae porttitor est. Donec eu nulla ipsum. Nulla sed nisl vestibulum, facilisis urna et, convallis turpis. Mauris et egestas erat, in suscipit tortor.

Nulla turpis leo, pellentesque vel fermentum ut, elementum ut mi. Vestibulum eleifend varius ultrices. Curabitur ut nisi posuere, sollicitudin nulla eget, vehicula sapien. Pellentesque luctus, est ut aliquet semper, nisl ligula ornare eros, hendrerit vehicula tortor nisl eu turpis. Cras ultricies, urna nec convallis convallis, nulla mi vehicula dui, vel finibus arcu tellus eget justo. Cras pulvinar egestas nisl non fermentum. Nulla eget facilisis odio, eu placerat est. Proin elit ligula, tincidunt ac turpis eu, ultrices ornare felis. Nam lobortis, nisl sed lobortis laoreet, ex massa euismod tellus, ac laoreet nisi justo vitae tellus. In ut ipsum et nunc finibus semper viverra in enim. Ut ac diam lorem. In nulla nibh, sollicitudin at nibh sit amet, pellentesque interdum nunc. Vivamus lacinia libero in varius rutrum. Suspendisse at pretium magna. Duis ultrices congue eros sit amet auctor.

Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Praesent rhoncus vel leo quis egestas. Quisque vitae posuere ex. In a sem varius, bibendum odio id, blandit urna. Aliquam ullamcorper purus nec magna suscipit aliquam ut vitae ipsum. Proin nibh lectus, aliquam id semper quis, sagittis in diam. Phasellus rutrum metus at mi rhoncus egestas. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc ultrices, ipsum nec tempor lobortis, ex dui tincidunt erat, vitae suscipit ligula orci non mi. Donec a maximus metus. Duis varius orci orci, eget ullamcorper lacus imperdiet nec. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Duis nec porttitor lectus, quis volutpat magna. Donec finibus lobortis diam, vel molestie neque sodales ac.

Nullam odio ipsum, imperdiet vel nisl non, dignissim ullamcorper lectus. Mauris varius orci mi, at vehicula libero interdum sed. Maecenas bibendum sodales dolor eu tristique. Vestibulum condimentum lectus enim, nec porttitor elit auctor id. Vivamus maximus maximus feugiat. Cras sollicitudin, sem in convallis imperdiet, orci lectus elementum nunc, ut congue mi leo placerat risus. Nam vehicula laoreet sapien, quis aliquam neque efficitur a. Suspendisse vulputate facilisis orci, nec pulvinar risus malesuada eu. Etiam in tellus blandit nisi ultricies porttitor. Duis eu venenatis nunc.

Morbi porta convallis arcu, nec accumsan ante tempor maximus. Aliquam lacinia, leo a iaculis congue, mauris justo vulputate augue, quis venenatis diam orci sit amet lorem. Nunc odio risus, sollicitudin in nibh ut, posuere pulvinar diam. Nunc ullamcorper vehicula elit, in faucibus eros pulvinar sit amet. Aliquam eleifend nisi tortor, pulvinar sollicitudin nulla placerat vel. Nullam at suscipit dolor. Vivamus ac erat pretium ante efficitur imperdiet. Suspendisse potenti. Vestibulum ex turpis, sodales id tincidunt nec, semper id enim. Nulla elementum consectetur eros id viverra. Vivamus eleifend mi luctus sem feugiat, non placerat diam molestie. Ut dui purus, molestie sit amet ligula non, suscipit vestibulum nunc. Morbi cursus et ipsum tempus cursus. Proin congue efficitur mi at imperdiet.

Nulla congue sollicitudin tempor. Maecenas porta orci et enim imperdiet condimentum. Sed odio mi, rutrum rutrum pulvinar vel, fringilla eu ante. Vestibulum sodales semper augue vel scelerisque. Pellentesque suscipit feugiat nunc. Suspendisse finibus magna a orci placerat fermentum. Proin non ipsum euismod, posuere odio ut, vestibulum tortor. Vivamus et mattis urna, nec malesuada felis. Nunc sit amet lacus a turpis accumsan interdum. Morbi tincidunt ipsum sit amet odio fringilla, faucibus dapibus ipsum dictum. Aenean bibendum, nisl a semper posuere, erat neque gravida ligula, quis varius odio ligula at tortor. Suspendisse potenti. In tincidunt dolor nec tristique pulvinar. Mauris augue dui, interdum sit amet convallis quis, dignissim eu arcu. Maecenas luctus, purus a blandit pellentesque, erat neque malesuada orci, vel varius turpis nibh at metus. Donec enim dui, tempus at scelerisque et, finibus et enim.
                      ''';

  @override
  Widget buildPage() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: SingleChildScrollView(
                        child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: _obtainWidgetsForNewsViewModel(),
                            ))),
                    decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0))),
                  ),
                ),
              ),
            )));
  }

  List<Widget> _obtainWidgetsForNewsViewModel() => [
        UIFactory.createLabel(controller.currentNewsModelView.headerTitle,
            Colors.amberAccent, EWasteLayout.HEADER_FONT, 28),
        Image.network(
            "https://ca.slack-edge.com/TDDKEQ07J-UDFDCV3V5-948cfb60d5f4-512"),
        Html(
            data: controller.currentNewsModelView?.htmlText ?? "",
            padding: EdgeInsets.all(EWasteLayout.PADDING))
      ];
}
