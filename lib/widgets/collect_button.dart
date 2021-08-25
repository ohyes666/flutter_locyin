import 'package:flutter/material.dart';
import 'package:flutter_locyin/utils/getx.dart';
import 'package:get/get.dart';
class CollectButtonWidget extends StatefulWidget {
  //所属游记
  final int id;
  //点赞数
  final int count;
  //判断是否已经点赞
  final bool collected;
  const CollectButtonWidget({Key? key, required this.id, required this.count, required this.collected}) : super(key: key);


  @override
  _CollectButtonWidgetState createState() => _CollectButtonWidgetState();
}

class _CollectButtonWidgetState extends State<CollectButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GetBuilder<DynamicController>(
              init: DynamicController(),id: "collect",
              builder: (controller) {
                return IconButton(
                  icon: Icon(Icons.star),
                  //根据是否收藏修改颜色
                  color: controller.dynamicList!.data.firstWhere( (element) => element.id == widget.id).collected == 1 ?Colors.cyan:Colors.grey,
                  onPressed: (){
                    controller.collect(widget.id);
                  },
                );
              }),
        ],
      ),
    );
  }
}
