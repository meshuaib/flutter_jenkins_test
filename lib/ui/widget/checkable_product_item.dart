import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o2o/data/constant/const.dart';
import 'package:o2o/data/product/product_entity.dart';
import 'package:o2o/util/localization/o2o_localizations.dart';

class CheckableProductItem extends StatelessWidget {
  final ProductEntity scannedProduct;
  final bool checkboxVisible;
  final bool isChecked;
  final Function onChecked;

  CheckableProductItem({
    Key key,
    @required this.scannedProduct,
    this.checkboxVisible = true,
    @required this.isChecked,
    this.onChecked,
  }) : super(key: key);

  ListTile _listTileBuilder(context) {
    O2OLocalizations locale = O2OLocalizations.of(context);

    final imageUrl = scannedProduct.imageUrl.isEmpty
        ? AppConst.NO_IMAGE_URL : scannedProduct.imageUrl;

    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Visibility(
            child: Checkbox(
              value: isChecked,
              onChanged: (checked) => onChecked(checked),
            ),
            visible: checkboxVisible,
          ),
          Image.network(imageUrl, fit: BoxFit.fill,),
        ],
      ),
      title: Text(
        scannedProduct.title,
        style: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold
        ),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 5),
        child: Text(
          '${locale.txtJanCode}: ${scannedProduct.janCode}',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: checkboxVisible? 5 : 16),
      onTap: () => onChecked(!isChecked),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: _listTileBuilder(context),
    );
  }
}
