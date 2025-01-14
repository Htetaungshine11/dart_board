import 'package:dart_board_widgets/dart_board_widgets.dart';
import 'package:dart_board_minesweeper/src/state/actions/minesweeper_actions.dart';
import 'package:dart_board_minesweeper/src/state/app_state.dart';
import 'package:dart_board_minesweeper/src/state/mine_sweeper_node.dart';
import 'package:dart_board_redux/dart_board_redux.dart';
import 'package:flutter/material.dart';

class MineBlock extends StatefulWidget {
  final int x, y;

  const MineBlock({Key? key, required this.x, required this.y})
      : super(key: key);

  @override
  _MineBlockState createState() => _MineBlockState();
}

class _MineBlockState extends State<MineBlock> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final state = getState<MinesweeperState>();
    bool isGameOver = state.mineSweeper.isGameOver;
    final theme = Theme.of(context);

    return LayoutId(
        id: "grid:${widget.x}:${widget.y}",
        child: FeatureStateBuilder<MinesweeperState>(
          /*converter: (state) =>
              state.state.mineSweeper!.getNode(x: widget.x!, y: widget.y!),
          distinct: true,
          builder: */
          (context, state) => Convertor<MinesweeperState, MineSweeperNode>(
            convertor: (state) =>
                state.mineSweeper.getNode(x: widget.x, y: widget.y),
            input: state,
            builder: (ctx, vm) => GestureDetector(
              onTap: () {
                dispatch(TouchMineSweeperTileAction(x: widget.x, y: widget.y));
                dispatch(clearTiles);
              },
              onLongPress: () {
                dispatch(FlagMineSweeperTileAction(x: widget.x, y: widget.y));
              },
              child: MouseRegion(
                onEnter: (_) => setState(() {
                  getState<MinesweeperState>().mineSweeper.isGameOver;
                }),
                onExit: (_) => setState(() => hover = false),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: AnimatedContainer(
                    decoration: vm.isVisible
                        ? (vm.isBomb ?? false
                            ? bombBox(context)
                            : cleanBox(context))
                        : hover
                            ? hoverBox(context)
                            : vm.isTagged
                                ? flagBox(context)
                                : unknownBox(context),
                    duration: Duration(
                        milliseconds: hover
                            ? (100 * vm.random).toInt()
                            : (250 + vm.random * 500).toInt()),
                    child: Center(
                        child: Text(
                      vm.isVisible
                          ? (vm.isBomb ?? false)
                              ? "💣"
                              : "${vm.neighbours == 0 ? "" : vm.neighbours}"
                          : (vm.isTagged
                              ? "🏳"
                              : (isGameOver && (vm.isBomb ?? false))
                                  ? "💣"
                                  : ""),
                      style: theme.textTheme.headline6!
                          .copyWith(fontWeight: FontWeight.bold, shadows: [
                        Shadow(
                            blurRadius: 2,
                            color: Colors.black,
                            offset: Offset(2, 1)),
                        Shadow(
                            blurRadius: 2,
                            color: Colors.white,
                            offset: Offset(-2, -1)),
                      ]),
                    )),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

bombBox(BuildContext context) => BoxDecoration(
      color: Colors.red,
      border: Border.all(color: Colors.white),
    );

flagBox(BuildContext context) => BoxDecoration(
      color: Theme.of(context).colorScheme.secondaryVariant,
      border:
          Border.all(color: Theme.of(context).colorScheme.secondary, width: 2),
    );

hoverBox(BuildContext context) => BoxDecoration(
      color: Theme.of(context).colorScheme.primaryVariant,
      border: Border.all(color: Colors.white, width: 2),
    );

unknownBox(BuildContext context) => BoxDecoration(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.66),
      borderRadius: BorderRadius.circular(16),
    );

cleanBox(BuildContext context) => BoxDecoration(
      color: Theme.of(context).colorScheme.surface.withOpacity(0.0),
    );
