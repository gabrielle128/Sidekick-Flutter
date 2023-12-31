import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/style/app_style.dart';

Widget journalCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppStyle.cardsColor[doc['color_id']],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doc["journal_title"],
                style: AppStyle.mainTitle,
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                doc["creation_date"],
                style: AppStyle.mainDate,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(doc["journal_content"],
                  style: AppStyle.mainContent, overflow: TextOverflow.ellipsis),
            ],
          )));
}
