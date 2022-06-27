import 'package:flutter/material.dart';
import 'package:insta_storie/model/user.dart';
import 'package:story_view/story_view.dart';

import '../model/story.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final controller = StoryController();
  List<StoryItem> storyItems = [];

  void addStoryItems() {
    for (final story in widget.user.stories) {
      switch (story.mediaType) {
        case MediaType.image:
          storyItems.add(StoryItem.pageImage(
            url: story.url as String,
            controller: controller,
            caption: story.caption,
            duration: Duration(
              milliseconds: (story.duration * 1000).toInt(),
            ),
          ));
          break;
        case MediaType.text:
          storyItems.add(
            StoryItem.text(
              title: story.caption,
              backgroundColor: story.color,
              duration: Duration(
                milliseconds: (story.duration * 1000).toInt(),
              ),
            ),
          );
          break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    addStoryItems();
  }

  void handleCompleted() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return StoryView(
        storyItems: storyItems,
        controller: controller, // pass controller here too
        repeat: false, // should the stories be slid forever
        onStoryShow: (s) {},
        onComplete: handleCompleted,
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.down) {
            Navigator.pop(context);
          }
        } // To disable vertical swipe gestures, ignore this parameter.
        // Preferrably for inline story view.
        );
  }
}
