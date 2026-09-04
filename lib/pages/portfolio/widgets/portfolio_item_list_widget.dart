import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../webazin/data/dto/dto.dart';

import '../../../utils/custom_devider.dart';
import 'package:webazin/utils/utils.dart';
import '../../global_widgets/custom_expansion_tiles.dart';

class PortfolioItemListWidget extends StatelessWidget {
  final DataPortfolio dataPortfolio;

  const PortfolioItemListWidget(this.dataPortfolio);

  @override
  Widget build(final BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black87.withOpacity(0.5), blurRadius: 10, offset: Offset(0, 8)),
        ],
      ),
      child: CustomExpansionTile(
        title: Container(
          width: double.infinity,
          height: 50,
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 5,
                child: Container(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        dataPortfolio.sumUsdt ?? '-*-',
                        style: TextStyle(fontSize: 10, fontFamily: FontFamily.vazirBold, color: context.theme.dividerColor),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        padding: EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: dataPortfolio.positive ? AppColors.green : AppColors.redGmail,
                        ),
                        child: Center(
                          child: Text(
                            dataPortfolio.usdtOscillation ?? '-*-',
                            style: TextStyle(fontSize: 10, fontFamily: FontFamily.vazirBold, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
              ),
              Flexible(
                flex: 5,
                child: Container(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        dataPortfolio.sumIrt ?? '-*-',
                        style: TextStyle(fontSize: 10, fontFamily: FontFamily.vazirBold, color: context.theme.dividerColor),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        padding: EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: dataPortfolio.positive ? AppColors.green : AppColors.redGmail,
                        ),
                        child: Center(
                          child: Text(
                            dataPortfolio.irtOscillation ?? '-*-',
                            style: TextStyle(fontSize: 10, fontFamily: FontFamily.vazirBold, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  dataPortfolio.symbol ?? '-*-',
                                  style: TextStyle(fontSize: 8, fontFamily: FontFamily.vazirBold, color: context.theme.dividerColor),
                                ),
                              ),
                              Center(
                                child: Text(
                                  (dataPortfolio.remaining ?? 0).toString(),
                                  style: TextStyle(fontSize: 8, fontFamily: FontFamily.vazirMedium, color: context.theme.dividerColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        dataPortfolio.icon.contains(".svg")
                            ? SvgPicture.network(
                                dataPortfolio.icon,
                                width: 16,
                                height: 16,
                              )
                            : Image.network(
                                dataPortfolio.icon,
                                width: 16,
                                height: 16,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 5,
                        child: Container(
                          child: Center(
                              child: Text(
                            '',
                            style: TextStyle(fontSize: 12, fontFamily: FontFamily.vazirBold),
                          )),
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Container(
                          child: Center(
                              child: Text(
                            'Now'.tr,
                            style: TextStyle(fontSize: 12, fontFamily: FontFamily.vazirBold, color: context.theme.dividerColor),
                          )),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Container(
                          child: Center(
                              child: Text(
                            'When Buying'.tr,
                            style: TextStyle(fontSize: 12, fontFamily: FontFamily.vazirBold, color: context.theme.dividerColor),
                          )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          CustomDivider(
            margin: const EdgeInsets.symmetric(vertical: 8),
            color: Colors.red,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 5,
                        child: Container(
                          child: Center(
                              child: Text(
                            'Average purchase price (USDT)'.tr,
                            style: TextStyle(fontSize: 12, fontFamily: FontFamily.vazirBold),
                          )),
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Container(
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                dataPortfolio.unitUsdtNow ?? '-*-',
                                style: TextStyle(fontSize: 10, fontFamily: FontFamily.vazirBold),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: dataPortfolio.positive ? AppColors.green : AppColors.redGmail,
                                ),
                                child: Center(
                                  child: Text(
                                    dataPortfolio.percent ?? '-*-',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Container(
                          child: Center(
                            child: Text(
                              dataPortfolio.unitUsdt ?? '-*-',
                              style: TextStyle(fontSize: 10, fontFamily: FontFamily.vazirBold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 5,
                        child: Container(
                          child: Center(
                              child: Text(
                            'Average purchase price (Irt)'.tr,
                            style: TextStyle(fontSize: 12, fontFamily: FontFamily.vazirBold),
                          )),
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Container(
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                dataPortfolio.unitIrtNow ?? '-*-',
                                style: TextStyle(fontSize: 10, fontFamily: FontFamily.vazirBold),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: dataPortfolio.positive ? AppColors.green : AppColors.redGmail,
                                ),
                                child: Center(
                                  child: Text(
                                    dataPortfolio.percent ?? '-*-',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Container(
                          child: Center(
                            child: Text(
                              dataPortfolio.unitIrt ?? '-*-',
                              style: TextStyle(fontSize: 10, fontFamily: FontFamily.vazirBold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 5,
                        child: Container(
                          child: Center(
                              child: Text(
                            'Total purchase amount (USDT)'.tr,
                            style: TextStyle(fontSize: 12, fontFamily: FontFamily.vazirBold),
                          )),
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Container(
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                dataPortfolio.sumUsdtNow ?? '-*-',
                                style: TextStyle(fontSize: 10, fontFamily: FontFamily.vazirBold),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: dataPortfolio.positive ? AppColors.green : AppColors.redGmail,
                                ),
                                child: Center(
                                  child: Text(
                                    dataPortfolio.percent ?? '-*-',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Container(
                          child: Center(
                            child: Text(
                              dataPortfolio.sumUsdt ?? '-*-',
                              style: TextStyle(fontSize: 10, fontFamily: FontFamily.vazirBold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 5,
                        child: Container(
                          child: Center(
                              child: Text(
                            'Total purchase amount (Irt)'.tr,
                            style: TextStyle(fontSize: 12, fontFamily: FontFamily.vazirBold),
                          )),
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Container(
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                dataPortfolio.sumIrtNow ?? '-*-',
                                style: TextStyle(fontSize: 10, fontFamily: FontFamily.vazirBold),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: dataPortfolio.positive ? AppColors.green : AppColors.redGmail,
                                ),
                                child: Center(
                                  child: Text(
                                    dataPortfolio.percent ?? '-*-',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Container(
                          child: Center(
                            child: Text(
                              dataPortfolio.sumIrt ?? '-*-',
                              style: TextStyle(fontSize: 10, fontFamily: FontFamily.vazirBold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
