import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:youtube_data_api_vk/helpers/helpers_extention.dart';
import 'package:youtube_data_api_vk/models/channel_page.dart';
import 'package:youtube_data_api_vk/models/video.dart';

class ChannelData {
  ChannelPage channel;
  List<Video> videosList;

  ChannelData({required this.channel, required this.videosList});

  factory ChannelData.fromMap(Map<String, dynamic> map) {
    if (kDebugMode) {
      print(
          'The channel data is: ${map.get('contents')?.get('twoColumnBrowseResultsRenderer')?.getList('tabs')?[1].get('tabRenderer')?.get('content')?.get('richGridRenderer')?.getList('contents')?.firstOrNull?.get('richItemRenderer')?.get('content') ?? 'Its null'}');
    }
    var headers = map.get('header');
    String? subscribers = headers
        ?.get('c4TabbedHeaderRenderer')
        ?.get('subscriberCountText')?['simpleText'];
    var thumbnails = headers
        ?.get('c4TabbedHeaderRenderer')
        ?.get('avatar')
        ?.getList('thumbnails');
    String? avatar = thumbnails?.elementAtSafe(thumbnails.length - 1)?['url'];
    String? banner = headers
        ?.get('c4TabbedHeaderRenderer')
        ?.get('banner')
        ?.getList('thumbnails')
        ?.first['url'];

    List<Video> videoList = [];
    map
        .get('contents')
        ?.get('twoColumnBrowseResultsRenderer')
        ?.getList('tabs')?[1]
        .get('tabRenderer')
        ?.get('content')
        // ?.get('sectionListRenderer')
        ?.get('richGridRenderer')
        ?.getList('contents')
        ?.forEach((element) {
      var content = element.get('richItemRenderer')?.get('content');

      Video video = Video.fromMap(content);
      videoList.add(video);
    });

    return ChannelData(
        videosList: videoList,
        channel: ChannelPage(
            subscribers: (subscribers != null) ? subscribers : " ",
            avatar: avatar,
            banner: banner));
  }
}
