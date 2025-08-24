import 'package:flutter/material.dart';
import 'package:imaan_tree/arch/clean_arch/domain/entities/entity_remember.dart';


class RememberPage extends StatefulWidget {
  @override
  _RememberPageState createState() => _RememberPageState();
}

class _RememberPageState extends State<RememberPage> {
  final List<EntityRemember> items = [
    EntityRemember(
      title: "Morning Dhikr",
      description: "Start your day with morning remembrance.",
      durationDays: 7,
    ),
    EntityRemember(
      title: "Evening Dhikr",
      description: "End your day with evening remembrance.",
      durationDays: 7,
    ),
    EntityRemember(
      title: "Gratitude Reflection",
      description: "Reflect on Allah's blessings daily.",
      durationDays: 14,
    ),
  ];

  EntityRemember? selectedItem;
  DateTime? startDate;
  int daysCompleted = 0;

  void selectItem(EntityRemember item) {
    setState(() {
      selectedItem = item;
      startDate = DateTime.now();
      daysCompleted = 0;
      // TODO: Schedule notification based on user preference
    });
  }

  void markRememberedToday() {
    setState(() {
      daysCompleted += 1;
      // TODO: Update tracking and handle notification logic
    });
  }

  int get daysLeft {
    if (selectedItem == null) return 0;
    return (selectedItem!.durationDays - daysCompleted).clamp(0, selectedItem!.durationDays);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Remembrance")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: selectedItem == null
            ? ListView(
                children: items.map((item) {
                  return Card(
                    child: ListTile(
                      title: Text(item.title),
                      subtitle: Text(item.description),
                      trailing: ElevatedButton(
                        child: Text("Choose"),
                        onPressed: () => selectItem(item),
                      ),
                    ),
                  );
                }).toList(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current Tracking:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(selectedItem!.title, style: TextStyle(fontSize: 16)),
                  Text(selectedItem!.description),
                  SizedBox(height: 16),
                  Text("Days left to complete: $daysLeft"),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: daysLeft > 0 ? markRememberedToday : null,
                    child: Text("Yes, I Remembered Today"),
                  ),
                  if (daysLeft == 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        "Congratulations! You have completed this remembrance.",
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}