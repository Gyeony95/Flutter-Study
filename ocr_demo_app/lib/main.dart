import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as path;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:ocr_demo_app/permission_manager.dart';
import 'package:ocr_demo_app/data_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http_parser/http_parser.dart';

import 'package:async/async.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  var api_url = 'https://5f1f45080b7a4bc9b0d346e334fadde5.apigw.ntruss.com/custom/v1/9490/a509203108dc6c4c3388709dc5002103efe4e849d02e3c2d4a2645b86a385af1/document/id-card';
  var secret_key = 'YVFIRlRyeWFmWVhjbmRNYVFoR0dVVkVXdVdLbFRsWVQ=';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton(onPressed: () async {
              if (Platform.isAndroid
                  ? await PermissionManager()
                      .checkPermission(Permission.storage)
                  : await PermissionManager()
                      .checkPermission(Permission.photos)) {
                final images = await MultiImagePicker.pickImages(
                  maxImages: 10,
                );

                if (images?.isNotEmpty == true) {
                  // final list = <File>[];
                  images.forEach(
                    (image) async {
                      final file = File(
                        await FlutterAbsolutePath.getAbsolutePath(
                          image.identifier,
                        ),
                      );
                      // list.add(file);


                      var request_json = {
                        'images' : [
                          {
                            'format': 'jpg',
                            'name': 'Screenshot_20210621-132525',
                            'data' : '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAoGBxQUExYUFBMWGBYZGSIaGBkZGR8cGhwZHBobGhwcHBwdHysiGhwoHxkZJDQjKC0uMTExHCE3PDcvOyswMS4BCwsLDw4PHBERHS4oHx8wMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLv/AABEIAMIBAwMBIgACEQEDEQH/xAAbAAABBQEBAAAAAAAAAAAAAAAFAAIDBAYBB//EAEQQAAIBAgQDBQQHBgUDBAMAAAECAwARBBIhMQUTQQYiUXHwMmGBkRRCUqGxwdEjM2KCkuEVcsLS8QdTohYkQ/IlNLL/xAAZAQADAQEBAAAAAAAAAAAAAAAAAQIDBAX/xAAmEQACAgIDAAEEAgMAAAAAAAAAAQIREiEDMVFBEyJhcQTwMoGR/9oADAMBAAIRAxEAPwD0/ifESDkQ2I3P5ChplY7u3zNOOtj1Ovz1pg8taRsopDxIw+sfmf1rnNP2j8z+tcYeJUHzqMxnewI8RSHo6ztb221953+dUzNJsXYePeP6++ny4mNdGkQEbgsAflVXF4+G4IlTX+Ib0NMWi7DKbe039RqbnEfWPzNU4XABJOUX3JsPvqeHlsbc1CTsFIJppCbiiUTH7TfM/rTlc/ab+o0sPLBrlbNY2OoOvhpUUvG4lJGaNT1uwBoyQrJWnt9Zv6jUTYo39pv6jUK8YjZgokjJPQML/AXqWbE5BmdkA8TU5/gaSHLiD9pv6j+tO5xOmZvmb/jVRuMQnQvF/ULVPC8Li6tceKm4v5inlH5EPcsNpGv4ZjUUmKYaFm+BNRvjYVYgTx3G4ZhcefhUEfEYS2XmxljsA4JJqsfBposiYnUSN/UaTYhhozN5gm346VxoRuN65Y/WGniPzrNqi0kIzuv12I/zG4qVJ2tfO3zP61Dy8uouR4eFW+BQDmG1iCp0Oovf30k6CSVHVnP2j/UaX0g/bPzP60b5K/ZX5ClyV+yvyFPNEaAbzN9o/wBR/Wqa4hkaxdspPVjoa0/IX7K/IUmw6HdF+QqZTsE14A5J2+0fmf1obine9xK4H+Y1ruQv2V+QpHDp9hf6RRKVoaaRjhimfKBKw017x/XWupimbKole+t++fRrXjCp9hP6R+lIYVPsJ/SP0qEwbXhkPpbWy8181/tnanDFMMy81yenfPoVrfoqfYT+kfpS+jJ9hf6R+lVkLRlFxDLcGRzpp3z+tXsFxWSIrdy6ncNr8jR76Mn2F/pFCuPIBksANG6W8KakGmH8PiAyhhsRcUqxseKkAABFulKrzJwCGGN7Ea3G3wrmIbTunX6xH4DwpsTNlAsANvedKct7WtoBSbKcrIMg+6uHcWNjT206U0jbSkIxXaPjUUkskQghVwcrSygEbe0FAu1vA22ofgMVBhwqiODEoDdZAAJB11utmsdiDXokUN+m4P4UL4Hhngw8EUq5WGc23t3mIv8AA1qpXHZNbo52ow5mwto4+Yc8b5RbYMCd/dehT4MviMM0WDaJUcs72RRblutjla51IrXJe357X+VZvgc2JhTlNhZnIZu8WSxUsSPaa9rWqctCx2P7KAB8Xl2+kHT35FNZ/jGHeOaeYw5Ud7lpI4WGgC3BMg0Nr7da2vByWzkw8k5rkHLdtB3u6Tfw1od2jwDmSGcIJVizZoxvdgLOt9Cwt1tvUqVMqtGa4NNIzpLHh0kUN9SKEfJuboa0Hbxv/bgAgMXW11uDY3I9lraXtcb0/g2Ac4h5+XyldAgRrBmIJOdgCQN7CjPEeGrIvLkW4NjbXxvUy5NlRjo8v5neyhDte+Vcvl+43rZdgWRYGRNw7Fh0u2undUfIVaPZjDf9r7z+tc7LYF4UkRwQOc5QXzdw2y+8Up8ikgjBpmX49zSXOJgWOEsdUWJWYX0GdpCbkeAvT+zrTB4zh4FeIMBmZYi6rexs6yX0HiCaPdoMJJz4Z1i5qoGUoLZgWtZ1voSLW+NO7PYN+fNO0XKWQKBGbXJW93a2gJuB8BT+p9tjw2aMIrfwn7q5cpuLjxrldWUjfUeFTDm+JFuHhWlTcr5kdKs8BsZTbTum4+VNlgvqvy8PKpOCL+2vrfKfyrSSTVoTeg7SpVW4mZuU/ICGXL3OYSEzdM1gTaskZsD43hOKkdmk4gYYr9xIY0U5emeSTMSfIAVC3CMdEM+Gxxm68rEqrKw8BLGAyH36inYbsNh27+LBxcx9qSbvC53CR+zGvuA6CgXaTh/D8NJy8LHMmLIuqYNypXwaUX5ar/mHwNWqEzV9nO0C4jPG0bRYiKwlhe2Zb7MCNHQ9GFF68nx8fECYJ55XMyKyBsHEplyHcSuxCkbaBbX2qzwyCHEllbEY7mpq8c0skcgHjlUgEe8aVDcVsnNHp9q5XmGNjwcDZGx2Ije17fSpCQPEgk2HnRHA/Swokw/EmlQi6iVElQ/zLlb76VoPqI39KsdF2wxEP/7mFunWXDXdQPFoyM6jyzVpuF8UhxEYlgkWRD1U3sfA+BHgdaZSaZboJ2m/+P8Am/KjdBe01+5b+K/3U12UgFzh76VWY00GlcrSmUEMKAVAJ213pzL0uenXzpuGOg06VLJc5hYDwoMyF1sd/KmAbVLMPwpsQLGwGnjSoY/CJc3vt+NUpJObKSNgLe6p8dOACifzH9Kr4VOo0G1v1p/gaVKy7FGMum/j+lPc3sevr16tTc3zpMfE+vXrpSok41r3+6lptrUZxIvbS/313meVJspDidj4dKep1J/Comf16tXI5AdQR4aG4vtbQVlIpEmUWJPXqPzpgisRc6Hwp4el7/u6H9KhopMrvvTxXHTr0pLUlofXL101zlmgBmcjUVe4SwMl9jlP5VRtVngv73+U/lVwk1omStBylSrlaGJn+2nHJIRHBh7fSJiRGSLiNFsXlYeCgiw6kis5GqYQJDDG82IlJIF7yyt9aSVzso6sdBsKs4ZzNjsXOdQjDDxeAWMXcjzdjf8AyiiX/TbCCUS8QbVpmKRX+rBGcqgf5mBf4jwoSylj8Iyk8mVv8F4tbPbBXtflZpL+XMta/vtQ2NxiC0oiMeLgDoY3NijsuivbRkPdYH416gRWE7aYKTD4iTHRx50OHyyBfaaVWHKFhqb5iL1U+JVcexNAbBjD4GJUmdTM+rkjPLJIdWNgCzeAFttKk7OyYYSzCBmRns7QspjynW7rGwBGbqRpoK1fYvswMOnNms+KkGaWQjUE65E+yi7ADwv1qXtl2bGKiuhyYiPvQSDdXHQ+KNsQfGk+G13sMQZQnE8OaGX6VhQVlGrxqQqTjqjjbMej7ip+B8Q58KyFcrarIh3SRSVdT5MDV+uRNwZKdBjgHGI8VAs0d7HRlPtI40ZGHRgdKqdpXty/5h+FBOz8nI4i0Y0jxcZe3QTRWzHzZGH9NHe0du55N+VdcXdM6IO9gXL5/P8AtSrmU+IpVoWF4MLoLP0FWJcMx3aw91AhIdD7qmLGwuenjRonEIYoRra7X0ta/wCVUcTxAnuoMo9fKoJraeX9qUWgJtvtRY6SKvEZAiMTG8ikWZUsWsdCbEgG3rasRgWKFYAplkjZX/aKc5BYlQM2JCZraCw6bV6DyA217HT11rMwdgJIylpoWMcmdGaNrizXAIDC+mlMmRrcLi2ZAzRujEXKNYsvuOUkX8jQbtRxNouTZ5l5j5Bykje7EXAIk223Hxo3Kw6a+VUuK8LixCBJlBUMGGpBBHUEaj4UgSMghmM3DjiSTPzpgc2TOI8pyA5NLWAPnWs7R8QMOHlkQjOqHLfo2wJ8ib70Nn7PRc7DPCiosTO7ADViyZRruddbmiOJwwkRo3AKMCrDxBBB16UmNRLeQJFYPlCrcudbW1LNfQncm9YTB4iZ8FKxQ8t5wy5rLYtijcWtmDE7gmwuLVs44+4FY5xaxuNx0vbS+16HScBvG0XOfIZDJay+0ZebuRtmIqdFYsP4WViP2gCt1UNmG/QkDp7qw0aTq0aEtdvpBAzggjMTGT+1GykWva3vrUwQuFIaV2Jv3iBcA9NBawv1FVG4KpkSQuSyA5e7HbvWvcZLHYb1KKcWXuzK/wDtIASG/ZLc5g4Jy6965B663NRdncSzrKp15U0kQPiqt3fOwIHwq1wyHIhUOzbkFgNLknZQBb3VPgsEIo8qjZizMd2ZyWLHzJrKQ0TA1dy/2oeTT1lO16gtofit/wAal4N+8/lP4iqrGrXB/wB5/Kfyq0TLoNVy9tT01rtC+0vG4cNBI8sqJ3DlBPeY2Ngq7kk6WFao5zBcLxDJwuSZQS8izSC25aR3It7+8K9M7O8OEGFghA/dxqnxCgH7715hisKY+F4eJ7jWBJB4BpY8wPztXr4q+H5f5MkOrlqjleykgE2F7Dc6bD30MwXG8zYdJIZY5JkZ8pFwmS11dhoG7wsK2KC4FI12uGgDzqKPl8Qx8X1S8cyjw5sdm/8AKMn40SqhKwfimOYbKsMZ/wAwRnP3OtX68/n/AM2ZvsGTD/8AI8OtvnmJ/wAv0dwfvIrRdo1vkuNg35UD7MR/SMfLOBePDIYUPjK5DS2/yqqr5k0f7QITlt4N99q3gqSRtx6QA5n8JpVPa3UUq2pmlohXYeVTRAW1O351EmwqRNiPXhSGKXp0/wCaet9Bf0ajfp+nTSp1QA3B09/l69GhEsGcE4+ss8kISxQN9YE/s3yHMu6EnVd7jWmr2j7uJeWMoYVUsquGJzA2S40VxaxXpcampOF9nkikaQO50cKDYZea+d7MAGY3GlzoPfUb9nUyzK0skhmjWNmbKGCpmynuixYFiSx3NqokScfURyMyFXibIyAhruQpUKfrZs6/Oqs/HmMEc4hJDpzCC4UIoXMbsRa/Qe/rUkfAUyOHLSFn5jOTlOcKFB7trWUAaVWm7OKYYYVmkVYttFbOQNMwYWNjqBawPlUlkuO40Y1R+UzRsFZmJCkZyFUBTfO9zsOlEZMXGGyF0DnZSwzf0nWh2N4QZJIpOc4MQsAFQqWO72YWzaWuLW1ooUB6C/j1+F6TGVl4hecwFGBCZ8zDukXtZep3pkHEgzzJy3Bite4F2uC3dA6aaVZGBHNE1zmyFLW0sWDX89Ka3C1LTMSf2qhWFxoFVl0Nr3saHEdsF4LtKrwSTZLcsA2DqwOYBgM1rAi4uOlSTdogsKSkJ35Mi2lBW+u72sNFPS9TYLs7y0dVmkzMFXPZQQEFlsAuXxvca0z/AAIZAvMbOJTNzCFvzDe/dy5bWNrVDopNs5ie0ARY2ERZnjaQgOO6kYBc5hcNuLeNT4ntSFcJkLLkjZ2vbKkj5ENvrG4Nx0AqvP2XXlRIruuRGjDDLcpJ7YNxa5te42qXGdnkdwwdl0RHQWswjbOgJtcWJO1S1FoNhsCumoIntoTp41YNYtUaCvVvg37z+U/lVKrfBf3v8p/Kqj2RLob234xJh4FWG3PmkEURIuFLXLOR1CqGNvKgXDez0ER5hXmTHV5ZO9IzdTmPs+QsBV3t4cuIwDt7HNdL9A7xkJ5XsRUk0oVSzGwUEnyGpp8kmqSOKb2VeO8O+kQSQ3tnXRvBgbqfgwBo32S7WJiFEUpEWKQASxMbHNtmS/to24IrEY3jGIiiw+LkliRJ5FWLDZCZGiZrFmcnRgCrWAsL2o7xPhME4tNEj5diw7w8juPhTjKXFqXyJOjWcf49BhI2lnlVFUX1PeJ8FXdifAVU4D2qhxAiFwkkql1jZgWsts3skgkXFxWY/wCm3Y7CyYf6VNCkskjuVEg5ixoHKqiB720Aud73qP8A6jdiYIYWx2DAw0+H/aDlAKhtbNdALBreFr7G966yj0kGqHG+Kx4aF55TZEFz4k9FA6sToB76ymB7cYlECz4CWR7e3hyhjfwNncNGfEG9qoyRT4uVZ8XlVEN4sOpuino8h+vJ4dB76zlyRirsG0d7NYeQRtLMLTTSNLKPss+y+/KuVfhTOKYySWT6JhdZ3HffdYYzoZH9/wBldyaXaDFSKYo1migSVsrzyXJQm1gi2tnOtixsPfWs7PcChwsfLiBJJzPIxvJI/V3bqa54xyebFGNuyXgfCY8NAkEQ7qDc7sx1Zm8WY3J86rdoW9gWve/5UWoVx0+x5N+Vax7N0CeXSqaPDmw1/CuVqMqZLAbbClE2vr14UlXu3120+X9qaqmkFlhIid/XrWrRcX0XTS36+v0pit3fP0fXlTL+vXShEsnMgte+h2Pv93jt93nVPDYpG2dT3suhHtfZ89DpvWO4fwSYYoDKv7Nucf2py2laQWB5IJI75tcbjWm8GjAljYSEnnF2i72a4SRcvfuNDaxBucxvsKsDZ4gKPrAX0Avud7Dx9bVVllUGxZQbXsSAbDrr09XoPgklBgWZLH6S0lxt+1ilcg2O6sSpPl42oX2riP0iQq6A8q4DowBJV0FmFwWCmToNxodwqHZrWYWzFgBa979LePh86ckqjS4+Y/X8qx+N4S4Msn0f/wCNzze6bqcMqBd83tA9KMcW4PJLKiWww5oLCQwkyLy8hF2z6k7X02p0kGRoTGw3Fug2+XTWlEbi4sRe2hB1Gh+t7jQftfKRyRzCpDZg3dVOYo7pZnNgu/c6+OlVeF4QtFhZBzCfpTvY3yqrNNfQaFb2s38VwdaTQ7ZoFxcebLnTNe1swzX8Lam9Kca391Y3BhlxYIKi8pGWxvzDISzGPmZwhudSLAa2tW7dRfbXfSsJqmXFlUHQX/4p3N2067+6pCSu66eNRjEihRi12Xb8IS1yT93r15VLBJ0p4kX3fGulVOo+FJ8V9MeX4Ok1d4Kp5l/4T+VR/RARdTvVrhwtJt9WpXG09mcpJon4zwqLEwtDMLo3gbFSNVZT0YGxBrF8Y4HxGOGSEIuLjZGRZFYRTAEWGdW7rkeIIv4V6DSq/wBmLimeS8anZ4yMRhMShXALDHaEtknRw91K3AViqa/w0Q4D20gmjXmyLFNazxyd05uts1rgmvSr1ke1kKycQwccqq0fLmcBgCGkGRQNdzlZjb9Kckp6YsLKPCpsVhc30NoZoGYuInYjIzG7ZJFv3SSTlI0vvTuLS43HKIsQsUGHzBnSNzI8mUghS5ChUuNbA32qpxXsZE+KiEMPIjALyyxHlsx2WMZTpe5Ym3Sp8RwTFwBmgxYlUAnJiV2AF/3qWI+INJuVUmEuKS6LnFuILh4mkYE2sFVd2YnKqj3kkChCdoZosQYMXh1j0Q50fOqGXNkV9BYkqRcaXHvrPjjGLlfCYjEwkYdJkkAjClXAJynvuCSWC5Rpob+FG+OYmXEniJGAxufEJFHBeGwHJuyuzFu6eYx8dAPGlHhjj93Zkoh7ikSNDIsoBQocwO1rG9FOwUjtw7CNISWMKanUkW7pJ8ctqBQcCxmLATEIMPAbcxMweaUdUNu7Gp2OpJHhW3jjCgKosALADYAaAUoxcVTNIRaHUJ7QfU8m/wBNFqC9pRfl69G/Krj2aIHfSD0FKoFmFKtCqO4Zhpr4evXuqd0vawHvt69a+NQRJb5Vcw7X8NPhp6t91BDGqf0Hrz9a0h69eulPMVgNb+vXoVy2lx09ev70AZOPtFI8eJkiMRERBQX1EZG7WvdrgkDTw6VffGyjEGO6tGFLMiKSyAKMhZr+07ZgF6gX6VBDxDDTO6CMjmEq9ygvkutiA+a3d00vXcPPhTMZESQTNIEYlXTvGMkEq9hbKm9qsB3FOIyhFkTuoG/aLIhzkF0W9r91LM121+rVBuP4ouymMCNZcmaxFl+kCNfaWxJS2xO99NqvyY7C4kwjIzNfuZlIuHUyBumaNhF8SBpVec4eOR8zYhWu0xXvCJivfbLcZT00vSyBkY4xPzZV5kZCTxxgLGQSrsAdSxBA7yaDcGtSzHTT8qz+MxWFAVSjgovOXLGVBCESkK1sp1IJF971poEBA8NCLfOlbfQkMzt4V1ntqRbxqwQOpPy/tVTFEHr8Nr1E4yfTNY0Nlkv5dadhza2brt7v7VXJOl/gKmQHc+IrnjJydGjSRO6eI02PrrVLERAWt8vD3etavliFLDULoff4VSWXOTcb6+vQoaplRI1A66WropW6E2p6xjxoQybC4phpe499EuF4gNJ8NvlQVDZrfCifBf3v8p/KqU5J0Z8kVVh2lSpVZgKh/HuCQ4qMRyhhlOZHRiskbi9mRhqp38+tEKDdpePfR+WkcfNnkJEceYKLKO87sdEjW4ufeKau9AwWeE8Sh0jmw+JQbc4NFJ8XQFW/pFZftHxPGPOcHiIskYjEkwwgeWQxk6KzWGVTY3sL2rQ8KnxWMkkROLQpJGAXjw2HWSNMxIAMsl+Ye6RpbbYVw4THcPnkxTtHjecESRUQQyhYw2VkBYo1sxuLi9aY12JzdVYH4XNHjJJFXK2DjRYljyjK7lQxOouMgsBtY3q/wrjj8Pljw87M+FkbLDK5u0Tf9uQndNgp+dU+xvEI2M6EGOZppJWidcrhXfum2zC1tVuKvdrOGCfCzREalCV9zrqp+YrmyxnXwYp0zeUqxP8A0t4+7wrhp2LOsSyROd5YWGn8yHun4HrW2rRqjdOxUD7Tk3jt/F8u7Rygfac6x6fa/wBNNdlLsGRgWG1Ko8g9GlWhRbRLqPL1686aq2v69f8ANMw72A8vyohhCCp8x5/OhbMziNfp6+Pr51QnjIJ1+Xh6/SiGLw5BuNvXryqpzzmIsPDX87+utMEYXh/ZydcQrtogckgSXGW7ZdzfqPwoxgOzUkJhVWRlEuZyI8raRut27xznUaadaMyR+/X56/r+NOwkrBl1Ph9330DoBYfgbrJEwMOUSZ25aFbDI6j2nbTvCyi1r1Pxng5m5xe0n7IpEh0Vbi5JPViQuvQDzo5h2Hh3j19dKfJBpYanxHrwppWgoyU3ZpiJXVlzyR5QCguDyghXmZu6pKg7VrcPGQLXAsBpr4U0XBsdAPd1rsUgN72uPeTQmhkiDU3N/XnTwDrYD0KauXzv/CaegAJ1Iv40xlWZetuvwtSU239k9evw91TN3QR7XhVLGNrrXNyLH7kax3pllHuWA2tt5ag1wevXo1zC769AfwqAls3X3eFqyk8lZSWxYgag00qR1qXEWt8fX/FRG/z+NJDHL086IcOxAR8zXta2mvhQ6NCTb/iryKN9wOnifXrWm3TFKqCo4vH/ABfKnQcUjfYn5a/Kg8m2nWnYSDKwJ261cZb2YuHgWl4rGpsc1/KhXF4MDisrYiJZOX7OcbXtcb6g2FwdNBU/EYlyZuuw+O9BOH42wdPo/MsFysBEMt4kOzkEm5J+NapfdRUOPKNlLihkw8rTcPaFI5eUskdgrqsTaiLQpZlNtbeIokvGpZsv0hI0YRi5R7qZCWzAA7KAF1vrfpVaPPmdLE/s8/eSEMCGUE3GlrE7+Fdwb3XOBmQuqhnjiHU5gAov061UllGmW/4yIOO4OGcKWYpIjBo5UIzo3u8R4g6GiTPdSBqbffaqUUUhUSNZQyoUCJEL3QEsc9rG96mjxBUMpvfKCLrGAwDWLAx/W1tY+NR9JVsmX8WKWmAeFcJibDwR4qI8yBcilXOoNgSCpBymw0PhV2FZ8Mc2EncqDrh52Lxt/kc3eM++5Huq2sYy5ra3qRY73OXWhLdmX00jQYftBGVBdWRrDMvtWPUAjRqrcYxayZct9Adx42/ShoQG7EW09edPJB6bCrSQUM73oUq7z/4TSpjsUew8vXryqbDbX/409fLyqCH2R5evXlVjDm3z9evOhGbCEeJ+186ZNIhOw/OoF29etvmPKmTsB016evV6qwRLisKoO2h1/UUxkW4NzodqrTylhpfQevh94quJj1Jv69XFDaKXRc+h5Tobb79OvrzqUAg93ToT76rwz93xIFjfXyb+9TrODpr8NAR7qEPZWxEjA2B86bg5iCRffxFWg4Nh+A6frUZRb3Hnpvapcd2h2SrO2veGhrhcm19aDSdocMjct5CjlsveVgL9e8Rl261JF2jgMfO5wEfMMeY6gsu9rbj30xgPD8SbLjHw87SFYXyhmzO0oJvIkf1EGigdfDqY5MWeU4WZ2gE8aiTOSQjKhkHM3tmJF76XNH14zh7ROjKyyycpGQXBfvaHr9U6+6mT9ocMjNG0iBlNmXIxsfDRbdamayQLQFmx7fQlZpnElpuUc5QOEdghLgd5gliqE9/r41o1xg5fdu8oiEhj0Dm40uOhJBHhe9SYTEpNGChVkvocpGoNtiL3FVj2iwqu6PPEkiNkYSEIb2DaZtxqNdetc8vK6NF6DuA45gk5xDOCs1ryALYsqWUeAzNYAeIqOXFD6eiLOcwYF1L2QIUNo1T67E2a+48elX5OPQNCZlfMmYi6rckqbEqN216+GtNXjUJETDeR8i93vZrE94brop3oX6H8VZU7PYkPi5QuIaRRnDhn1aTmDVE+oiDu30B+Faw2293/ADQmDEx80xggSBM5AFjlJsDe3Ug/Ko17QwCNpSzBVkaMnKT3kJDaAE2uDrtSlt6JDfOAvp5edV2kPjQvC8fgkMYRy3MYqpysASq5z7QGljv1ojU00UqCk65ov5azrQF4pJeVARFGo78eZmtEre1cW9q1aBJLRjy1oNisasMGQiIiSNSytKVc3RUJChTYAAdfGutLpj4G9pd2ObCCO8bxwkSKhORDHoZUUq1ibjvUax2Cw7rJH3QTqQrWYFRobA3BGlCMVjVlhMjJE2qxry5TlALKbs2UFCCAdq7PDFDFCxhiDFmPMDsQCATdpAuZs22tUipJtp7TsXCOFNJGWtGAVULnjz3AiTUEkWF9LDwNQ4uMry8youUFTkGVNJlFwOl7ffVfE4zRQsiqthYDEyqABZRaye78aejgo1yrESRqf2zyEXa9iGAy+vCh9F4y7Z3330zejT5ZNTb31Gupy20zehUkq2J36/Cs0cwkJ22/4qdjfY9PQquu/wAfyqc6GwHSrJY3N7xXaWQeApUCG4Zu6PL8vX3+FTp+fr15V3iWEMMpB9km6nxG/wB361CGHr16HlR0Q9lvN9/4/l+RpkoB3v6/LxHTeoQemvr8ff4in5gfH+/6+B607FREGF7Wt+vrrXJYuv8Ab/6n7jUmQXv69e6mJMpNhf3f2/Q0iv0QxuVNx8R4+Y/MVaBBBYHT7xUUkQOuo/AfDdahBKm+vuP9x+dOyrstW8PXypjG3XpTfpane4PiBcUrIw9sfgfvpN0FGT4jOZMVIrnmmJf2YLJCkQkBFwHuZZLXGa1ql7N4lo8I5hieWRppAi92wYn6zg5cotqw0o/iOFQvbOI2ttmyn8dqtQIqgAMoA0AW1rfhU5jxMvjuHmCPh8ROZhi1LMPrOySs5H8xNVeIYtElZ4J8UDLLeVVgbKgC5SwLQnNbKugPWtqY1Nu6NDcHLcg+NzoD5eNSfEn7/wCwqJco1AF9nsWrxm0sshB1eSNo211A1RbjyFZjjXD54pRIQinEThO5K4GZlIBIyG2i1uwb+Pr3/pVbEZWtcXym63A0PQjwPv3rKM2nZeNoxvFOHcjCZJRGI+Zq1uYwEjWZlLgBWudzsDpUGGwcSyYYR4iF8ko7qMi5kCsAzLfvy6gXG4FbSSMN7QBHgRcfh/emJhkvoigjW+UC3x6flVZ6BwAmATEDFHEmFuXIeTk0zrGuqSm56tmuOgINVI3VcDMXeQIcXIrrHYFw0xUIXb92pJ1bwv41s0NcMMYBGUWN7jKLG+9x1pZicTE4fBgz4WCTMEDu8aiVZMqhNEDR2ZVB1u1x0vW3Y1DBgoo/YjRCd8qgfO3rf3VZjQEjelJ5MaVFrmWiGn96HriFUMxcxsI4u8EDk5lICKCLkkirONcABB8POosSVKkKW5gWPKcqmzR3sbFrdfdXVHSoONpf7KiwRezI0waSVGZ5IsqErslgLC4FqmEb8pVTMI+fIJOVYNlDN7I333trTxxKY25oJQMCbIguAOt5D1sfhUcOIkQLkhe6yPJdiljzCdLZr7HxqlSNnf8AWPx9slsOMXzRbLcPlJ6Zi4y5b71HxmNubKSoFxACf4s0lz77aU2fj2NJ7iRKp9m+psPHU05MWzKyzszMSpHs5VIJNxZR47G+29S5J9A7irdf9tjVTS3v9GnFbXF9b1yJxcC5qQtoSd71KOZjbWuL300p8enXcVze997VNEtza2ttB6600SRcn30q0mD4MMi5vatrSp4k5ov4rCJIMrqCPf0PiPCh/wD6bi+1IPiPzWi9KtDIEf8ApuL7cnzX/bSPZyO980nldbf/AM0XoJx/AGZkRYjmupMxNhGiuGIFjdnNiAALa3J6FUh2x44BEfrueh1XcafZ3FQjszCCTzJNN7sth592s9jMGXwzZ2Qp9NnULy1zd/ESxgZmDC+Y+0AtWfopnixUKoxd+XFbMUCHkhc7lW1QDW2t9BbWigth3/09FtzJL77rcD+nak3Z6LbO4J963Pwy60Bkw8oaVDEGbkRDlMDJlX6Q4fUveUWzMNV0sLDarXAcKIp4IwGAEeIYZk5ftywPZVzEhRe29FILYTbs1Drdn8SbqP8ATSHZiL7T/wDgf9FZTjrQpiMSjSOrKsrFkjKu/MSM5GlzWlUc5Qsdge6PC5NnAyc5SqMxDxlJgw5YgWNRIvtaBiH7tjcup6XBigyZfXs3CdQza7EZP9lPPZ6P7cg+Kj/TQpFDcLw65lW6QkZiwU5WRypKAkBlUjbrVDCzK2HxblEjEkGUxq8ndVDKJJCXi0OWQEAKb5RSxi/geTNKvAYvtufip/013/AY+rv8Sun/AI2of2dwTxy35eHAK2JjMYYDQ37kSki4Gl+tDO0PDQMTNKqDm8kluWkeZI2DqJDJIReRirKQAe4CN7ErCPgZS9NH/gUZ1zv53XUeeWopeARCwMrjw1Uf6az3FcTLHJEYZLhooomCuY8tgzZzmw8l1s4+yR191TjMD8nBx3WUxwZD39WZBGrtZlDWBAGb+I3A0owj4GcvTWDs3EdQ7kdLFfu7tNXs7CQLSPrqLFNR/TqBeqfD8M54aY+XlORgqqMxGp72VwLkG5sL3sLHWg3ZfAtzI4RmgblTmwRxo/JWytIt2CkA3JzbbDSjCPg85empHZ+IfXfwGq7+Hs713/A4v+4+htuuh0sPZ31++gvCsADy2jMdueuZI+6o5Qkjd8rG+dm3t4LvvQfDYLLK8IEl2njBljUEZo5gzP7RyaKq2AsMtztR9OPgZS9Nmez0f23+a/7afFwFFNwz/Mf7ao9sS+Q3WQwhbyctkVmOYWAZjdQOthrcai2tj6NLJhpIpmysVK52y+zbQsEIB99st9dqFCK+BZS9Ons/FcHmSX6d5dfLu60l7OxqbmSTU9SvwA7tZ7hZRyiwyosjGWREROXGjcrkqqLc5CT+0sfa77AU9MHIjxERtFCZYAY5BdmmGbO4YObboCbHMVJ95qkGUvQ43ZuIWvJINb6ldSf5afNwCMixkkF9N1+Xs1mcdgpli/dyI+aFZWZwBLMcVEQ6t3umY5sugZRbSwu9uYO9hizZb5kB77WkC51chEJkACyDLZb59SKKQZy9CcXZeIG4klNveu+32acezMJP7yQkWv3lv7r93ShXDHbuSxLNLH9LmLKoClVIkUd1yptmtvrfWnYxGlmc8lyBJE0kd1zZOVKNQGsdSul6WKDOXoUj7MxA6PJce9dL/wAtJuy8ZN+ZL81/21T4TMExUzEcmMQwrkcDMCXmVO8rkAdLa3uNq09PFCyYGbszGTfmSfNf9tXMHwuOM3AJPi2p/QVdpUUFitSrtKmIVKlSoAVUOL8SWCMyMrEXAstibnQWBIuSbAAakkaVfoP2mwDzRqqgsM4LKGC3Xe4LA2YEAg6UAU07QRSYaSVsO+VGUPEypmDuVuCCbAguGJa2hv1qfg/FYmSUxQBcgDFY2iJa+awGR7A936xFDm4A4w0iRxyZyysqyOjEtdQz5ravkBHePQCoeC9mJSs6TAqJI1RCVjuurF/Zdr37mhH1et9AAzg+PJIwAicOS6kMEzAxqr27rEG+cW1pLx6IyKhjZZc4iyuFDDMhkvoTdbL0pkfBnSSMq65VEmyKgUuoAIVRZtRrfwpsnZ5VaF1GeRZhJJLJYyMMjKTmtpuoCiwA2FAEpxcBWHFCJSZSgVyqhwJLBSSddBbS9ScT43FhzkZJDZC45aFlCg5bEqLJ5tYe/SqTdmmWOKISvJFG8fckEeUIhB+qgLGw6mn9ruCNiECxLEJLFVkdEblgjcZkYmxsbC2o3FAEknaKKMEFHAVnU5QCESIqrudRZAWXbXXbQ1JgeORzJMchyxg5gbHMBmBsNiDlPzqonZwyR2mYq55iSZMpEiSlWceyLZio1sCNfOpOzfBGgE6uq5HPdCnTLd9OltGAoAiw3GsIrx8uNUMjrHnyLHYujyAEmxP7q1vErvVnimLw7ZjJErmOVISXVTZpDHYgn6o5ik+Rqpw/g7Bog8BUpJnzrKGByrJGlw5LWCPsLa07G9mBl7jM7PJG8wkIKy5JkcuwItmCqVFrC2UbKtgCWbtXGpmXlueUHLHNGL8tC5svM5moGhy/drVrjQiMQlkw6ShRc5uX3FtmZi0hChRbXWhPEOAM0s55MjCROWrpOVIjKEFSrNbRnewta1qJ8d4aZoggjDkjJ3pGVFUrYlgp/aDbu9fEUAR4PjCJGVXDvGUk5SxKI7s5QS9zK2S2VixNxsascO4rHNIAim4jDhmFiAzuhS24IaI3HuFUsBwNggDXjlRwyyI7SKxClS2WS+UFXYFffoTYGrHCODmCYkG6cpVzEjMX5ksjkgADUyX08TQAPbj2FU8w4fKxGeNsiXcZwhYFSSmrD28p187XmmwQmkzrAkqMLs4RWJKq4YE6n2hr4g0HPB8WJp8kUAjeQNcqi51WXmZWK3LFl7tyBa5Ou5vYjhchllLRSOpYGMriXXulFzAqXsO/ntbS1qACWK4oomWBoZGLgkHKpQqpQMdW2Uut9PK9Q4njqDCLiTE7q6KRGLFjntlWxOpJIFhc66A05+BKZFk5kudABGS9yiaZk1vmD27xa5OmvdFqw4Cz4CPDO2VljVWt3luoAOxBI8CCNbHpQAyDtTA12yEHKrhTkzszSNCFAze2GUKbkWuAbVaXjsbMqtG4I5hZSoZkaLJcWTNmNpAQVvVHhnZx4jKrCN0aFUjOUjUNIcpVnawBZTcW1Jp+G4OZFWOXDmMcqSN2SRSCZQokPVixK3BPxoAfD2qikMQEcn7Qi2dctjzFTZt7Fgbi+3jT+0vGYYCizQGQMRl/ckA7XtJIpAHVrWAO9Up+yhE8UykPlcOzMFBBzxXyBVAXuR203+NEeK8HZ3EkcjqzMoezADlD2lF1J99vEmgCb/EYokjuoiDqWC90Bcq5mDFTlB94JF+tVsJ2jR41kWKQtI4RFULnY8vmbkhQAt9z099KXsxGQtnkugtGLjKgN8wtlsQwNjcHQC1qHYXszMII4iY1KOr5ruG7qIpyOhVluA6n3H30AaHhmMSUMyqVZWySKwAdWABytYkHRgRYkWar1BOz/Dp8OgjZo3BdmZ7vnszO2pYsXYXRbk7L5CjdACpUqVACpUqVACpUqVACpUqVACpUqVACpUqVACpUqVACpUqVACpUqVACpUqVACpUqVACpUqVACpUqVACpUqVACpUqVACpUqVACpUqVACpUqVACpUqVAH/9k=',
                          }
                        ],
                        'requestId': 'guide-demo',
                        'version': 'V2',
                        'timestamp': 1584062336793
                      };
                      var files = [
                        file
                      ];

                      log('ghghgh form : '+request_json.toString());
                      var response1;
                    try{
                      response1 = await Dio(
                          BaseOptions(
                              headers: {
                                'X-OCR-SECRET':secret_key,
                                'Content-Type':'application/json',
                              }
                          )
                      ).post(
                        api_url,
                        data: request_json,
                      );
                    }catch(e){
                      log('ghghgh err '+e.toString());
                    }



                    },
                  );
                }
              }
            })
          ],
        ),
      ),
    );
  }
}
