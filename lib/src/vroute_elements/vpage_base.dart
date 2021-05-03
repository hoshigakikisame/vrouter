part of '../main.dart';

/// A [VRouteElement] similar to [VWidgetBase] but which allows you to specify your own page
/// thanks to [pageBuilder]
class VPageBase extends VRouteElement
    with
        VRouteElementSingleSubRoute,
        VRouteElementWithPage,
        VoidVGuard,
        VoidVPopHandler {
  /// A function which allows you to use your own custom page
  ///
  /// You must use [child] as the child of your page (though you can wrap it in other widgets)
  ///
  /// [child] will basically be whatever you put in [widget]
  @override
  final Page Function(LocalKey key, Widget child, String? name) pageBuilder;

  /// The widget which will be displayed for the given [path]
  @override
  final Widget widget;

  @override
  final LocalKey? key;

  @override
  final String? name;

  @override
  final List<VRouteElement> stackedRoutes;

  VPageBase({
    required this.pageBuilder,
    required this.widget,
    this.key,
    this.name,
    this.stackedRoutes = const [],
  });

  @override
  List<VRouteElement> buildRoutes() => stackedRoutes;

  @override
  bool get popWithSubRoute => false;
}