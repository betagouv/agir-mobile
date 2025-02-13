import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class FnvCheckboxSet extends StatefulWidget {
  const FnvCheckboxSet({
    super.key,
    required this.options,
    required this.selectedOptions,
    required this.onChanged,
  });

  final List<String> options;
  final List<String> selectedOptions;
  final ValueChanged<List<String>> onChanged;

  @override
  State<FnvCheckboxSet> createState() => _FnvCheckboxSetState();
}

class _FnvCheckboxSetState extends State<FnvCheckboxSet> {
  List<String> _selectedOptions = [];

  @override
  void initState() {
    super.initState();
    _selectedOptions = widget.selectedOptions;
  }

  void _handleChanged({
    required final List<String> options,
    required final List<String> selectedOptions,
    required final String option,
    required final bool value,
  }) {
    final newSelectedOptions = _updateSelectedOptions(
      options,
      option,
      selectedOptions,
      value,
    );

    setState(() {
      _selectedOptions = newSelectedOptions;
    });
    widget.onChanged(newSelectedOptions);
  }

  List<String> _updateSelectedOptions(
    final List<String> options,
    final String option,
    final List<String> selectedOptions,
    final bool value,
  ) {
    final newSelectedOptions = List<String>.of(selectedOptions);
    final valeurAucune = options.lastOrNull;

    if (option == valeurAucune ||
        (selectedOptions.contains(valeurAucune) && value)) {
      newSelectedOptions
        ..clear()
        ..add(option);

      return newSelectedOptions;
    }

    value ? newSelectedOptions.add(option) : newSelectedOptions.remove(option);

    return newSelectedOptions;
  }

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children:
        widget.options
            .map(
              (final option) => GestureDetector(
                onTap:
                    () => _handleChanged(
                      options: widget.options,
                      selectedOptions: _selectedOptions,
                      option: option,
                      value: !_selectedOptions.contains(option),
                    ),
                behavior: HitTestBehavior.opaque,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color:
                            _selectedOptions.contains(option)
                                ? DsfrColors.blueFranceSun113
                                : DsfrColors.grey900,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(DsfrSpacings.s2w),
                    child: DsfrCheckbox.md(
                      label: option,
                      value: _selectedOptions.contains(option),
                    ),
                  ),
                ),
              ),
            )
            .separator(const SizedBox(height: DsfrSpacings.s2w))
            .toList(),
  );
}
