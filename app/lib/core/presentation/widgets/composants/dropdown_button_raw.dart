// ignore_for_file: use-closest-build-context

import 'package:flutter/material.dart';

class DropdownButtonRaw<T> extends StatefulWidget {
  DropdownButtonRaw({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.menuStyle,
  }) : assert(items.containsKey(selectedItem.key), 'Selected item not found in items');

  final Map<T, Widget> items;
  final MapEntry<T, Widget> selectedItem;
  final ValueChanged<T> onChanged;
  final DropdownMenuStyle menuStyle;
  @override
  State<DropdownButtonRaw<T>> createState() => _DropdownButtonRawState<T>();
}

class _DropdownButtonRawState<T> extends State<DropdownButtonRaw<T>> {
  final _anchorKey = GlobalKey();
  final _controller = OverlayPortalController();

  @override
  Widget build(final BuildContext context) {
    final value = widget.selectedItem.value;

    return InkWell(
      key: _anchorKey,
      onTap: _controller.show,
      child: OverlayPortal(
        controller: _controller,
        overlayChildBuilder: (final _) {
          final rootContext = _anchorKey.currentContext!;
          final overlay = Overlay.of(rootContext).context.findRenderObject()! as RenderBox;
          final anchorBox = rootContext.findRenderObject()! as RenderBox;
          final upperLeft = anchorBox.localToGlobal(Offset.zero, ancestor: overlay);
          final bottomRight = anchorBox.localToGlobal(anchorBox.paintBounds.bottomRight, ancestor: overlay);
          final anchorRect = Rect.fromPoints(upperLeft, bottomRight);

          return _DropdownMenu(
            anchorRect: anchorRect,
            onTapOutside: (final _) => _controller.hide(),
            style: widget.menuStyle,
            children:
                widget.items.entries
                    .map(
                      (final e) => _DropdownMenuItem(
                        item: e,
                        onChanged: (final value) {
                          _controller.hide();
                          widget.onChanged(value);
                        },
                      ),
                    )
                    .toList(),
          );
        },
        child: value,
      ),
    );
  }
}

class DropdownMenuStyle {
  const DropdownMenuStyle({required this.decoration, required this.alignment, required this.offset});

  final Decoration decoration;
  final Alignment alignment;
  final Offset offset;
}

class _DropdownMenu extends StatelessWidget {
  const _DropdownMenu({required this.anchorRect, required this.onTapOutside, required this.style, required this.children});

  final Rect anchorRect;
  final TapRegionCallback onTapOutside;
  final DropdownMenuStyle style;
  final List<Widget> children;

  @override
  Widget build(final BuildContext context) =>
      TapRegion(onTapOutside: onTapOutside, child: _DropdownMenuLayout(anchorRect: anchorRect, style: style, children: children));
}

class _DropdownMenuItem<T> extends StatelessWidget {
  const _DropdownMenuItem({super.key, required this.item, required this.onChanged});

  final MapEntry<T, Widget> item;
  final ValueChanged<T> onChanged;

  @override
  Widget build(final BuildContext context) => Material(
    type: MaterialType.transparency,
    child: InkWell(onTap: () => onChanged(item.key), child: Center(child: item.value)),
  );
}

class _DropdownMenuLayout extends StatelessWidget {
  const _DropdownMenuLayout({required this.anchorRect, required this.style, required this.children});

  final Rect anchorRect;
  final DropdownMenuStyle style;
  final List<Widget> children;

  @override
  Widget build(final BuildContext context) => CustomSingleChildLayout(
    delegate: _DropdownMenuPositionDelegate(anchorRect: anchorRect, alignment: style.alignment, offset: style.offset),
    child: _DropdownMenuContent(style: style, children: children),
  );
}

class _DropdownMenuContent extends StatefulWidget {
  const _DropdownMenuContent({required this.style, required this.children});

  final DropdownMenuStyle style;
  final List<Widget> children;

  @override
  State<_DropdownMenuContent> createState() => _DropdownMenuContentState();
}

class _DropdownMenuContentState extends State<_DropdownMenuContent> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => IntrinsicWidth(
    child: Material(
      type: MaterialType.transparency,
      child: DecoratedBox(
        decoration: widget.style.decoration,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(
            context,
          ).copyWith(scrollbars: false, overscroll: false, physics: const ClampingScrollPhysics()),
          child: PrimaryScrollController(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(mainAxisSize: MainAxisSize.min, children: widget.children),
            ),
          ),
        ),
      ),
    ),
  );
}

class _DropdownMenuPositionDelegate extends SingleChildLayoutDelegate {
  const _DropdownMenuPositionDelegate({required this.anchorRect, required this.alignment, required this.offset});

  final Rect anchorRect;
  final Alignment alignment;
  final Offset offset;

  @override
  BoxConstraints getConstraintsForChild(final BoxConstraints constraints) => BoxConstraints(
    maxWidth: constraints.maxWidth,
    maxHeight: constraints.maxHeight - (alignment.withinRect(anchorRect) + offset).dy - 48,
  );

  @override
  Offset getPositionForChild(final Size size, final Size childSize) => alignment.withinRect(anchorRect) + offset;

  @override
  bool shouldRelayout(final _DropdownMenuPositionDelegate oldDelegate) => oldDelegate.anchorRect != anchorRect;
}
