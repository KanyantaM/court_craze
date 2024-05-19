import 'package:youtube_data_api_vk/models/video.dart';
import 'package:youtube_data_api_vk/models/video_page.dart';

class VideoData {
  VideoPage? video;
  List<Video> videosList;

  VideoData({this.video, required this.videosList});
}
