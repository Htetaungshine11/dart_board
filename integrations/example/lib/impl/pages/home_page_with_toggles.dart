import 'package:dart_board_core/dart_board.dart';

enum TemplateOptions { plain, bottom_nav, side_nav }
enum BackgroundOptions { white, image, animated }

class HomePageWithToggles extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Material(
      color: Colors.transparent,
      child: Center(
          child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              child: Container(
                width: 350,
                child: Column(
                  children: [
                    Text(
                      'Dart Board',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      'Flutter Feature Framework',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      '[ Self Guided Tour ]',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    ListTile(
                      title: Text('Template'),
                      trailing: PopupMenuButton<TemplateOptions>(
                        onSelected: (TemplateOptions result) {
                          switch (result) {
                            case TemplateOptions.plain:
                              DartBoardCore.instance.setFeatureImplementation(
                                  'template', 'direct');
                              break;
                            case TemplateOptions.bottom_nav:
                              DartBoardCore.instance.setFeatureImplementation(
                                  'template', 'bottomNav');
                              break;
                            case TemplateOptions.side_nav:
                              DartBoardCore.instance.setFeatureImplementation(
                                  'template', 'sideNav');
                              break;
                          }
                          ;
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<TemplateOptions>>[
                          const PopupMenuItem<TemplateOptions>(
                            value: TemplateOptions.plain,
                            child: Text('No Layout'),
                          ),
                          const PopupMenuItem<TemplateOptions>(
                            value: TemplateOptions.side_nav,
                            child: Text('AppBar+Drawer Nav'),
                          ),
                          const PopupMenuItem<TemplateOptions>(
                            value: TemplateOptions.bottom_nav,
                            child: Text('Bottom Navigation'),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text('Background'),
                      trailing: PopupMenuButton<BackgroundOptions>(
                        onSelected: (BackgroundOptions result) {
                          switch (result) {
                            case BackgroundOptions.white:
                              DartBoardCore.instance
                                  .setFeatureImplementation('background', null);
                              break;
                            case BackgroundOptions.image:
                              DartBoardCore.instance.setFeatureImplementation(
                                  'background', 'City Image');
                              break;
                            case BackgroundOptions.animated:
                              DartBoardCore.instance.setFeatureImplementation(
                                  'background', 'Relaxing Waves');
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<BackgroundOptions>>[
                          const PopupMenuItem<BackgroundOptions>(
                            value: BackgroundOptions.white,
                            child: Text('Solid'),
                          ),
                          const PopupMenuItem<BackgroundOptions>(
                            value: BackgroundOptions.image,
                            child: Text('Image'),
                          ),
                          const PopupMenuItem<BackgroundOptions>(
                            value: BackgroundOptions.animated,
                            child: Text('Animated'),
                          ),
                        ],
                      ),
                    ),
                    SwitchListTile.adaptive(
                        title: Text('Logging'),
                        value:
                            DartBoardCore.instance.isFeatureActive('logging'),
                        onChanged: (result) => {
                              DartBoardCore.instance.setFeatureImplementation(
                                  'logging', result ? 'default' : null)
                            }),
                    SwitchListTile.adaptive(
                        title: Text('Border'),
                        value: DartBoardCore.instance
                            .isFeatureActive('app_border'),
                        onChanged: (result) => {
                              DartBoardCore.instance.setFeatureImplementation(
                                  'app_border', result ? 'default' : null)
                            }),
                    SwitchListTile.adaptive(
                        title: Text('MineSweeper'),
                        value: DartBoardCore.instance
                            .isFeatureActive('MineSweeper'),
                        onChanged: (result) => {
                              DartBoardCore.instance.setFeatureImplementation(
                                  'MineSweeper', result ? 'default' : null)
                            }),
                    SwitchListTile.adaptive(
                        title: Text('Theme'),
                        value: DartBoardCore.instance.isFeatureActive('theme'),
                        onChanged: (result) => DartBoardCore.instance
                            .setFeatureImplementation(
                                'theme', result ? 'default' : null)),
                    ListTile(
                      title: Text('Readme'),
                      onTap: () {
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            useSafeArea: true,
                            builder: (ctx) => Dialog(
                                child: Card(child: RouteWidget('/readme'))));
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )));
}