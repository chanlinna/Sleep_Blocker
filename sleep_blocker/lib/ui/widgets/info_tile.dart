import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget{
  final String title;
  final String desc;
  final InfoType infoType;
  final VoidCallback? onTap;

  const InfoTile({
    super.key,
    required this.title,
    required this.desc,
    required this.infoType,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(infoType.icon, color: infoType.iconColor,),
            const SizedBox(width: 10,),
            Text(title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: infoType.titleColor, fontSize: 16),
            )
          ],
        ),
        const SizedBox(height: 10,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: infoType.boxColor,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Text(desc,
            textAlign: infoType == InfoType.blocker || infoType == InfoType.advice
            ? TextAlign.center
            : TextAlign.start,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: infoType.descColor),
          ),
        )
      ],
    );
    if (onTap == null) return content;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: content,
    );
  }
}

enum InfoType{
  blocker(icon: Icons.warning ,iconColor: Color(0xFFF87171), titleColor: Color(0xFFF87171), descColor: Color(0xFFFFFFFF), boxColor: Color(0xFFF87171)),
  advice(icon: Icons.message, iconColor: Color(0xFF2DD4BF), titleColor: Color(0xFFFFFFFF), descColor: Color(0xFFFFFFFF), boxColor: Color(0xFF334155)), 
  insight(icon: Icons.insights, iconColor: Color(0xFFFFFFFF), titleColor: Color(0xFFFFFFFF), descColor: Color(0xFF181B55), boxColor: Color(0xFFF87171));
  
  final IconData icon;
  final Color iconColor;
  final Color titleColor;
  final Color descColor;
  final Color boxColor;

  const InfoType({
    required this.icon,
    required this.iconColor, 
    required this.titleColor, 
    required this.descColor,
    required this.boxColor
  });
}