import 'package:flutter/material.dart';
import 'package:mekto/utility/app_color.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  CustomSearchBarState createState() => CustomSearchBarState();
}

class CustomSearchBarState extends State<CustomSearchBar> {
  bool isExpanded = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
          if (!isExpanded) {
            _focusNode.unfocus();
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColor.branco, // Substitua pela cor desejada
            width: 2, // Espessura da borda
          ),
          color: isExpanded ? AppColor.branco : AppColor.branco,
        ),
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: FocusScope(
          node: FocusScopeNode(),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: AppColor.halloween,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  focusNode: _focusNode,
                  controller: widget.controller,
                  decoration: const InputDecoration(
                    hintText: 'Procurar uma peça...',
                    border: InputBorder.none,
                  ),
                  autofocus: false,
                  onChanged: widget.onChanged,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
