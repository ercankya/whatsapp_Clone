import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/utils/coloors.dart';

class OtherListContactCard extends StatelessWidget {
  const OtherListContactCard({
    super.key,
    required this.text,
    required this.leading,
    IconData? this.trailing,
  });

  final String text;
  final IconData leading;
  final IconData? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(top: 10, left: 20, right: 10),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Coloors.greenDark,
        child: Icon(
          leading,
          color: Colors.white,
        ),
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        trailing,
        color: Coloors.greyDark,
      ),
    );
  }
}
