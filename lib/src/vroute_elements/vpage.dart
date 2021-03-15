part of '../main.dart';

@immutable
class VPage extends VRouteElementWithPage {
  final Page Function(LocalVRouterData child) pageBuilder;

  VPage({
    required this.pageBuilder,
    required Widget widget,
    required String? path,
    String? name,
    List<VRouteElement> subroutes = const [],
    List<String> aliases = const [],
    bool mustMatchSubRoute = false,
  }) : super(
          widget: widget,
          path: path,
          name: name,
          subroutes: subroutes,
          aliases: aliases,
          mustMatchSubRoute: mustMatchSubRoute,
        );

  @override
  Page buildPage({
    required Widget widget,
    required VPathRequestData vPathRequestData,
    required pathParameters,
    required VRouteElementNode vRouteElementNode,
  }) =>
      pageBuilder(
        LocalVRouterData(
          child: NotificationListener<VNavigationGuardMessage>(
            // This listen to [VNavigationGuardNotification] which is a notification
            // that a [VNavigationGuard] sends when it is created
            // When this happens, we store the VNavigationGuard and its context
            // This will be used to call its afterUpdate and beforeLeave in particular.
            onNotification: (VNavigationGuardMessage vNavigationGuardMessage) {
              VNavigationGuardMessageRoot(
                vNavigationGuard: vNavigationGuardMessage.vNavigationGuard,
                localContext: vNavigationGuardMessage.localContext,
                associatedVRouteElement: this,
              ).dispatch(vPathRequestData.rootVRouterContext);

              return true;
            },
            child: widget,
          ),
          vRouteElementNode: vRouteElementNode,
          url: vPathRequestData.url,
          previousUrl: vPathRequestData.previousUrl,
          historyState: vPathRequestData.historyState,
          pathParameters: pathParameters,
          queryParameters: vPathRequestData.queryParameters,
          context: vPathRequestData.rootVRouterContext,
        ),
      );
}