import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchField<T> extends StatefulWidget {
  final String? hint;
  final List<T> Function(String query) getResults;
  final void Function(T) onSelectResult;

  SearchField({
    this.hint,
    required this.getResults,
    required this.onSelectResult,
  });

  @override
  State<StatefulWidget> createState() => _SearchFieldState<T>();
}

class _SearchFieldState<T> extends State<SearchField<T>> {
  late TextEditingController _controller;
  List<T> _results = [];
  OverlayEntry? _resultsOverlay;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(() => _updateResults());
    _results = [];
  }

  @override
  void dispose() {
    _controller.dispose();
    _dismissOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListenableProvider.value(
        value: _controller,
        builder: (context, _) => TextFormField(
          decoration: InputDecoration(
            labelText: widget.hint ?? '',
          ),
          controller: _controller,
          autofocus: true,
          autocorrect: false,
          enableSuggestions: false,
        ),
      );

  void _updateResults() {
    var query = _controller.text.trim();
    setState(
        () => _results = query.isNotEmpty ? widget.getResults.call(query) : []);
    if (_results.isNotEmpty) {
      if (_resultsOverlay == null) {
        var renderBox = context.findRenderObject() as RenderBox;
        var offset = renderBox.localToGlobal(Offset.zero);
        _resultsOverlay = OverlayEntry(
          builder: (context) => Positioned(
            left: offset.dx,
            top: offset.dy + renderBox.size.height + 2,
            child: Container(
              width: renderBox.size.width,
              height: renderBox.size.height * 2,
              child: Material(
                elevation: 2,
                color: Theme.of(context).dialogBackgroundColor,
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) => _item(_results[index]),
                ),
              ),
            ),
          ),
        );
        Overlay.of(context)!.insert(_resultsOverlay!);
      } else {
        _resultsOverlay!.markNeedsBuild();
      }
    } else {
      _dismissOverlay();
    }
  }

  GestureDetector _item(T item) {
    return GestureDetector(
      onTap: () => _selectItem(item),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(item.toString()),
      ),
    );
  }

  void _selectItem(T item) {
    widget.onSelectResult(item);
    _dismissOverlay();
  }

  void _dismissOverlay() {
    _resultsOverlay?.remove();
    _resultsOverlay = null;
  }
}
