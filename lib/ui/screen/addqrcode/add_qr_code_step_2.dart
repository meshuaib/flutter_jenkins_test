import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:o2o/data/response/order_history_details_response.dart';
import 'package:o2o/ui/screen/base/base_state.dart';
import 'package:o2o/ui/widget/button/gradient_button.dart';
import 'package:o2o/ui/widget/common/app_colors.dart';
import 'package:o2o/ui/widget/common/app_images.dart';
import 'package:o2o/ui/widget/common/common_widget.dart';
import 'package:o2o/util/helper/common.dart';

class AddQrCodeStep2 extends StatefulWidget {

  AddQrCodeStep2(
      this.orderHistoryDetails,
      this.newQrCodes,
      this.onPreviousScreen,
      this.onNextScreen
  );
  final OrderHistoryDetails orderHistoryDetails;
  final LinkedHashSet newQrCodes;
  final Function onPreviousScreen;
  final Function onNextScreen;

  @override
  _AddQrCodeStep2State createState() => _AddQrCodeStep2State();
}

class _AddQrCodeStep2State extends BaseState<AddQrCodeStep2> {

  _buildInstruction() {
    final oldQrCodes = widget.orderHistoryDetails.qrCodes;
    String primaryQrCode = oldQrCodes.isEmpty? '00000000' : oldQrCodes[0];
    String primaryQrCodeLast4Digit = primaryQrCode.substring(primaryQrCode.length-4);

    final deliveryDate = Converter.toDateTime(widget.orderHistoryDetails.endingTime);

    final qrCodeCount = oldQrCodes.length + widget.newQrCodes.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            AppImages.loadSizedImage(AppImages.icDigit1Url, width: 36.0, height: 36.0),
            Padding(
              padding: EdgeInsets.only(left: 10,),
              child: Text('の箇所に', style: TextStyle(
                color: Colors.black, fontSize: 14,
              ),),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('${deliveryDate.hour}:${deliveryDate.minute}',
                style: TextStyle(
                    color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold
                ),),
            ),
            Text('を記入してください。', style: TextStyle(
              color: Colors.black, fontSize: 14,
            ),),
          ],
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 5),),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppImages.loadSizedImage(AppImages.icDigit2Url, width: 36.0, height: 36.0),
            Padding(
              padding: EdgeInsets.only(left: 10,),
              child: Text('の箇所に', style: TextStyle(
                color: Colors.black, fontSize: 14,
              ),),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                primaryQrCodeLast4Digit,
                style: TextStyle(
                    color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold
                ),
              ),
            ),
            Text('を記入してください。', style: TextStyle(
              color: Colors.black, fontSize: 14,
            ),),
          ],
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 5),),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppImages.loadSizedImage(AppImages.icDigit3Url, width: 36.0, height: 36.0),
            Padding(
              padding: EdgeInsets.only(left: 10,),
              child: Text('の箇所に', style: TextStyle(
                color: Colors.black, fontSize: 14,
              ),),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('$qrCodeCount/$qrCodeCount',
                style: TextStyle(color: Colors.blue,
                    fontSize: 18, fontWeight: FontWeight.bold
                ),),
            ),
            Text('を記入してください。', style: TextStyle(
              color: Colors.black, fontSize: 14,
            ),),
          ],
        ),
      ],
    );
  }

  _buildControlBtn() {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 13,),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.colorF1F1F1)),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GradientButton(
            text: locale.txtGoBack,
            onPressed: () => widget.onPreviousScreen(),
            gradient: AppColors.btnGradientLight,
            txtColor: Colors.black,
            showIcon: true,
            icon: Icon(
              Icons.arrow_back_ios, color: Colors.black, size: 14,
            ),
          ),
          GradientButton(
            text: 'ラベル修正に進む',
            onPressed: () => widget.onNextScreen(),
            showIcon: true,
            padding: EdgeInsets.symmetric(horizontal: 32),
          ),
        ],
      ),
    );
  }

  _bodyBuilder() {
    return Stack (
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 13),
              alignment: Alignment.center,
              child: AppImages.imgQrCodeLabelOk,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: _buildInstruction(),
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
              padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
              child: CommonWidget.sectionTitleBuilder('追加した荷札QRコード'),
            ),
            ListView.builder(
              itemCount: widget.newQrCodes.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final item = widget.newQrCodes.toList()[index];
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                  child: Text(item, style: TextStyle(fontSize: 14.0),),
                );
              }
            ),
            Padding(padding: EdgeInsets.only(bottom: 80),)
          ],
        ),
        _buildControlBtn(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.white,
      child: _bodyBuilder(),
    );
  }

}