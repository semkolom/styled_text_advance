import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayerWithControls extends StatefulWidget {
  final VideoPlayerController controller;
  final double? width;
  final double? height;

  const CustomVideoPlayerWithControls({
    Key? key,
    required this.controller,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  _CustomVideoPlayerWithControlsState createState() =>
      _CustomVideoPlayerWithControlsState();
}

class _CustomVideoPlayerWithControlsState
    extends State<CustomVideoPlayerWithControls> {
  double _playbackSpeed = 1.0;
  double _volume = 1.0;

  @override
  void initState() {
    super.initState();
    // Initialize volume to the current controller volume
    _volume = widget.controller.value.volume;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          VideoPlayer(widget.controller),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(milliseconds: 300),
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                widget.controller.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  if (widget.controller.value.isPlaying) {
                    widget.controller.pause();
                  } else {
                    widget.controller.play();
                  }
                });
              },
            ),
            // Speed control
            DropdownButton<double>(
              value: _playbackSpeed,
              onChanged: (double? newValue) {
                if (newValue != null) {
                  setState(() {
                    _playbackSpeed = newValue;
                    widget.controller.setPlaybackSpeed(_playbackSpeed);
                  });
                }
              },
              items: <double>[0.5, 1.0, 1.5, 2.0]
                  .map<DropdownMenuItem<double>>((double value) {
                return DropdownMenuItem<double>(
                  value: value,
                  child: Text("${value}x"),
                );
              }).toList(),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
            ),
            // Volume control
            Slider(
              value: _volume,
              min: 0.0,
              max: 1.0,
              onChanged: (value) {
                setState(() {
                  _volume = value;
                  widget.controller.setVolume(_volume);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
