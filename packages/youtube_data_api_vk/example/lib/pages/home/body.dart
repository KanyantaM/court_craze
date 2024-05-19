import 'package:flutter/material.dart';
import 'package:youtube_data_api_vk/models/video.dart';
import '/widgets/video_widget.dart';

class Body extends StatefulWidget {
  final List<Video> contentList;

  const Body({Key? key, required this.contentList}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.contentList.length,
        itemBuilder: (context, index) {
          return video(widget.contentList[index]);
        },
      ),
    );
  }

  Widget video(Video video) {
    return VideoWidget(
      video: video,
    );
  }
}
