import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locyin/utils/getx.dart';
import 'package:flutter_locyin/widgets/amap_gridview.dart';
import 'package:flutter_locyin/widgets/locator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'const_config.dart';
import 'package:get/get.dart' as getx;

class MapPage extends StatefulWidget {
  MapPage({Key? key}) : super(key: key);

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {

  //默认显示在北京天安门
  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(39.909187, 116.397451),
    zoom: 10.0,
  );

  ///地图类型
  MapType _mapType = MapType.normal;

  ///显示路况开关
  bool _trafficEnabled = true;

  /// 地图poi是否允许点击
  bool _touchPoiEnabled = true;

  ///是否显示3D建筑物
  bool _buildingsEnabled = true;

  ///是否显示底图文字标注
  bool _labelsEnabled = true;

  ///是否显示指南针
  bool _compassEnabled = true;

  ///是否显示比例尺
  bool _scaleEnabled = true;

  ///是否支持缩放手势
  bool _zoomGesturesEnabled = true;

  ///是否支持滑动手势
  bool _scrollGesturesEnabled = true;

  ///是否支持旋转手势
  bool _rotateGesturesEnabled = true;

  ///是否支持倾斜手势
  bool _tiltGesturesEnabled = true;

  ///自定义定位小蓝点
  MyLocationStyleOptions _myLocationStyleOptions = MyLocationStyleOptions(false);

  CustomStyleOptions _customStyleOptions = CustomStyleOptions(false);

  late AMapController _mapController;

  String? _currentZoom;

  final List<Permission> needPermissionList = [
    Permission.location,
    Permission.storage,
    Permission.phone,
  ];

  bool initMineLocation = false;

  bool drawMineLocationMarker = false;

  //需要先设置一个空的map赋值给AMapWidget的markers，否则后续无法添加marker
  final Map<String, Marker> _markers = <String, Marker>{};

  Widget? _poiInfo;

  AMapPoi? _poi;
  void _checkPermissions() async {
    Map<Permission, PermissionStatus> statuses =
    await needPermissionList.request();
    statuses.forEach((key, value) {
      print('$key premissionStatus is $value');
    });
  }
  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  @override
  void reassemble() {
    super.reassemble();
    _checkPermissions();
  }
  @override
  Widget build(BuildContext context) {
    final AMapWidget amap = AMapWidget(
      apiKey: ConstConfig.amapApiKeys,
      onMapCreated: _onMapCreated,
      onCameraMove: _onCameraMove,
      onCameraMoveEnd: _onCameraMoveEnd,

      initialCameraPosition: _kInitialPosition,
      mapType: _mapType,
      trafficEnabled: _trafficEnabled,
      buildingsEnabled: _buildingsEnabled,
      compassEnabled: _compassEnabled,
      labelsEnabled: _labelsEnabled,
      scaleEnabled: _scaleEnabled,
      touchPoiEnabled: _touchPoiEnabled,
      rotateGesturesEnabled: _rotateGesturesEnabled,
      scrollGesturesEnabled: _scrollGesturesEnabled,
      tiltGesturesEnabled: _tiltGesturesEnabled,
      zoomGesturesEnabled: _zoomGesturesEnabled,
      customStyleOptions: _customStyleOptions,
      myLocationStyleOptions: _myLocationStyleOptions,
      onLocationChanged: _onLocationChanged,
      onTap: _onMapTap,
      onLongPress: _onMapLongPress,
      onPoiTouched: _onMapPoiTouched,
      //创建地图时，给marker属性赋值一个空的set，否则后续无法添加marker
      markers: Set<Marker>.of(_markers.values),

    );
    List<Widget> _optionsWidget = [
      _createMyFloatButton('改变显示区域', _changeLatLngBounds),
      _createMyFloatButton('改变中心点', _changeCameraPosition),
      _createMyFloatButton('改变缩放级别到18', _changeCameraZoom),
      _createMyFloatButton('按照像素移动地图', _scrollBy),
    ];

    Widget _cameraOptions() {
      return Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: AMapGradView(
                childrenWidgets: _optionsWidget,
              ),
            ),
          ],
        ),
      );
    }

    return ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  minHeight: MediaQuery.of(context).size.height-64
              ),
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height-64,
                    width: MediaQuery.of(context).size.width,
                    child: amap,
                  ),
                  Positioned(
                      right: -10,
                      bottom: 132,
                      child: ClipPath.shape(
                        shape: StadiumBorder(),
                        child: ElevatedButton(
                          child: SizedBox(
                            width: 60,
                            height: 40,
                            child: Icon(
                              Icons.add,
                            ),
                          ),
                          onPressed: _zoomIn,
                        ),
                      )
                  ),
                  Positioned(
                      right: -10,
                      bottom: 72,
                      child: ClipPath.shape(
                        shape: StadiumBorder(),
                        child: ElevatedButton(
                          child: SizedBox(
                            width: 60,
                            height: 40,
                            child: Icon(
                              Icons.remove,
                            ),
                          ),
                          onPressed: _zoomOut,
                        ),
                      )
                  ),
                  getx.GetBuilder<UserController>(
                    init: UserController(),
                    id: "location",
                    builder: (controller) {
                      if(controller.location!=null && !initMineLocation){
                        _mineLocation(double.parse(controller.location!["latitude"].toString()),
                            double.parse(controller.location!["longitude"].toString()));
                        initMineLocation  = true;
                      }
                      return Positioned(
                          left: -10,
                          bottom: 72,
                          child: LocatorWidget(onPressed: (Map<String,
                              Object>? _locationResult) {
                            _mineLocation(double.parse(_locationResult!["latitude"].toString()),
                                double.parse(_locationResult["longitude"].toString()));
                          },)
                      );
                  }),
                  Positioned(
                      left: -10,
                      bottom: 132,
                      child: ClipPath.shape(
                        shape: StadiumBorder(),
                        child: ElevatedButton(
                          child: SizedBox(
                            width: 60,
                            height: 40,
                            child: Icon(
                              Icons.settings,
                            ),
                          ),
                          onPressed: () {   },
                        ),
                      )
                  ),
                  Positioned(
                      left: MediaQuery.of(context).size.width/2 -45,
                      bottom: 24,
                      child: ClipPath(
                        //路径裁切组件
                        clipper: CurveClipper(), //路径
                        child: ElevatedButton(
                          onPressed: () {  },
                          child: SizedBox(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Expanded(
                                  child: Icon(
                                    Icons.send,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      "发布游记",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            width: 60,
                            height: 100,
                          ),
                        ),
                      ),
                  ),

                  Positioned(
                    bottom: 0,
                      child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _currentZoom.toString(),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Container(
                      child: _poiInfo,
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  void _onMapCreated(AMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  //移动视野
  void _onCameraMove(CameraPosition cameraPosition) {}

  //移动地图结束
  void _onCameraMoveEnd(CameraPosition cameraPosition) {
    setState(() {
      _currentZoom = '当前缩放级别：${cameraPosition.zoom}';
    });
    if(!drawMineLocationMarker){
      _addMarker();
      drawMineLocationMarker = true;
    }

  }

  void _changeCameraPosition() {
    _mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            //中心点
            target: LatLng(31.230378, 121.473658),
            //缩放级别
            zoom: 13,
            //俯仰角0°~45°（垂直与地图时为0）
            tilt: 30,
            //偏航角 0~360° (正北方为0)
            bearing: 0),
      ),
      animated: true,
    );
  }

  //改变显示级别
  void _changeCameraZoom() {
    _mapController.moveCamera(
      CameraUpdate.zoomTo(18),
      animated: true,
    );
  }

  //级别加1
  void _zoomIn() {
    _mapController.moveCamera(
      CameraUpdate.zoomIn(),
      animated: true,
    );
  }

  //级别减1
  void _zoomOut() {
    _mapController.moveCamera(
      CameraUpdate.zoomOut(),
      animated: true,
    );
  }

  //改变显示区域
  void _changeLatLngBounds() {
    _mapController.moveCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
              southwest: LatLng(33.789925, 104.838326),
              northeast: LatLng(38.740688, 114.647472)),
          15.0),
      animated: true,
    );
  }
  //我的位置
  void _mineLocation(double latitude,double longitude){
    _mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          //中心点
            target: LatLng(latitude, longitude),
            //缩放级别
            zoom: 18,
            //俯仰角0°~45°（垂直与地图时为0）
            tilt: 30,
            //偏航角 0~360° (正北方为0)
            bearing: 0),
      ),
      animated: true,
    );
  }


  //按照像素移动
  void _scrollBy() {
    _mapController.moveCamera(
      CameraUpdate.scrollBy(50, 50),
      animated: true,
      duration: 1000,
    );
  }

  FlatButton _createMyFloatButton(String label,Function()? onPressed) {
    return FlatButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textColor: Colors.white,
      highlightColor: Colors.blueAccent,
      child: Text(label),
      color: Colors.blue,
    );
  }
  void _onLocationChanged(AMapLocation location) {
    if (null == location) {
      return;
    }
    print('_onLocationChanged ${location.toJson()}');
  }
  void _onMapTap(LatLng latLng) {
    if (null == latLng) {
      return;
    }
    print('_onMapTap===> ${latLng.toJson()}');
  }

  void _onMapLongPress(LatLng latLng) {
    if (null == latLng) {
      return;
    }
    print('_onMapLongPress===> ${latLng.toJson()}');
  }
  Widget showPoiInfo(AMapPoi poi) {
    return Container(
      alignment: Alignment.center,
      color: Color(0x8200CCFF),
      child: Text(
        '您选择了 ${poi.name}',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
  void _onMapPoiTouched(AMapPoi poi) {
    print(poi);
    _poi = poi;
    setState(() {
      _poiInfo = showPoiInfo(poi);
    });
  }
  //添加一个marker
  void _addMarker() {
    final _markerPosition =
    LatLng(double.parse(getx.Get.find<UserController>().location!['latitude'].toString()), double.parse(getx.Get.find<UserController>().location!['longitude'].toString()));
    final Marker marker = Marker(
      position: _markerPosition,
      //使用默认hue的方式设置Marker的图标
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    );
    //调用setState触发AMapWidget的更新，从而完成marker的添加
    setState(() {
      //将新的marker添加到map里
      _markers[marker.id] = marker;
    });
  }

}
/// 曲线路径
class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path()..lineTo(0, 40);

    var firstControlPoint = Offset(size.width/2, 0);
    var firstEdnPoint = Offset(size.width,40);

    path.quadraticBezierTo(
        firstControlPoint.dx,
        firstControlPoint.dy,
        firstEdnPoint.dx,
        firstEdnPoint.dy);

    path..lineTo(size.width, size.height )
      ..lineTo(0, size.height );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}