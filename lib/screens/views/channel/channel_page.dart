import 'package:court_craze/screens/views/channel/body.dart';
import 'package:flutter/material.dart';
import 'package:youtube_data_api_vk/models/channel_data.dart';
import 'package:youtube_data_api_vk/youtube_data_api.dart';

class ChannelPage extends StatefulWidget {
  final String id;
  final String title;

  const ChannelPage({Key? key, required this.id, required this.title})
      : super(key: key);

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  YoutubeDataApi youtubeDataApi = YoutubeDataApi();
  ChannelData? channelData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder(
        future: youtubeDataApi.fetchChannelData(widget.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return _loading();
            case ConnectionState.active:
              return _loading();
            case ConnectionState.none:
              return const Text("Connection None");
            case ConnectionState.done:
              if (snapshot.error != null) {
                return Center(child: Text(snapshot.stackTrace.toString()));
              } else {
                if (snapshot.hasData) {
                  return Body(
                    channelData: snapshot.data,
                    title: widget.title,
                    youtubeDataApi: youtubeDataApi,
                    channelId: widget.id,
                  );
                } else {
                  return const Center(child: Text("No data"));
                }
              }
          }
        },
      ),
    );
  }

  Widget _loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Future<bool> _refresh() async {
    setState(() {});
    return true;
  }
}
