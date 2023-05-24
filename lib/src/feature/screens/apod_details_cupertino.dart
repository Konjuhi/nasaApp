import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../models/apod.dart';

class ApodDetailCupertino extends StatefulWidget {
  final Apod apod;

  const ApodDetailCupertino({Key? key, required this.apod}) : super(key: key);

  @override
  _ApodDetailCupertinoState createState() {
    return _ApodDetailCupertinoState();
  }
}

class _ApodDetailCupertinoState extends State<ApodDetailCupertino> {
  double _sliderScalar = 1.0;
  final TransformationController _controller = TransformationController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(widget.apod.title!),
            backgroundColor: CupertinoColors.activeBlue,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: InteractiveViewer(
                    transformationController: _controller,
                    child: Image(
                      image: AssetImage(widget.apod.url!),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CupertinoSlider(
                  min: 1.0,
                  max: 4.0,
                  divisions: 20,
                  value: _sliderScalar,
                  onChanged: (newValue) {
                    setState(() {
                      _sliderScalar = newValue;
                      _controller.value =
                          Matrix4.identity().scaled(_sliderScalar);
                    });
                  },
                  activeColor: CupertinoColors.systemPurple,
                ),
                _ApodBody(widget.apod, scalar: _sliderScalar),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ApodBody extends StatelessWidget {
  const _ApodBody(this.apod, {required this.scalar});
  final Apod apod;
  final double scalar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: CupertinoListSection(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                DateFormat('yyyy-MM-dd').format(apod.date!),
                style: CupertinoTheme.of(context)
                    .textTheme
                    .dateTimePickerTextStyle,
              ),
              CupertinoButton.filled(
                onPressed: () {},
                child: Text(
                  'Zoom: ${scalar.toStringAsPrecision(2)}',
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .textStyle
                      .copyWith(color: CupertinoColors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            apod.title!,
            style: CupertinoTheme.of(context).textTheme.dateTimePickerTextStyle,
          ),
          const SizedBox(height: 4),
          Text(
            'Copyright: ${apod.copyright!}',
            style: CupertinoTheme.of(context).textTheme.dateTimePickerTextStyle,
          ),
          const SizedBox(height: 8),
          Text(
            apod.explanation!,
            style: CupertinoTheme.of(context).textTheme.dateTimePickerTextStyle,
          ),
        ],
      ),
    );
  }
}
