/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { router } from "@kit.ArkUI";
import { TextMaxLineEllStyle } from "@siri/utils";

@Component
export struct NavigationView {
  @Prop title?: ResourceStr = undefined;
  titleColor?: ResourceStr = $r('app.color.card_foreground')
  @BuilderParam titleView?: CustomBuilder;
  @BuilderParam leftView?: CustomBuilder;
  @BuilderParam rightView?: CustomBuilder;
  @Prop theme: string = "light"
  @State w: number = 50
  clickShare?: () => void
  onBackClick?: Function;

  build() {
    Row() {
      Row() {
        if (this.leftView) {
          this.leftView()
        } else {
          Row() {
            if (this.onBackClick) {
              Image($r('app.media.icon_back'))
                .width($r('app.float.common_length_24'))
                .height($r('app.float.common_length_24'))
                .objectFit(ImageFit.Cover)
                .onClick(() => this.onBackClick?.())
            } else {
              Image($r('app.media.icon_back'))
                .width($r('app.float.common_length_24'))
                .height($r('app.float.common_length_24'))
                .objectFit(ImageFit.Cover)
                .onClick(() => {
                  router.back()
                })
            }
          }
          .justifyContent(FlexAlign.Start)
        }
      }
      .width(this.w)

      Row() {
        if (this.titleView) {
          this.titleView()
        } else {
          Text(this.title)
            .fontSize($r("app.float.common_font_20"))
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.Center)
            .fontColor(this.titleColor)
            .attributeModifier(new TextMaxLineEllStyle(1))
        }
      }
      .layoutWeight(1)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)

      Row() {
        if (this.rightView) {
          Row() {
            this.rightView()
          }
          .onAreaChange((_, newValue) => {
            this.w = newValue.width as number
          })
        } else {
          Row() {
            Image("").width(24).height(24)
          }
          .justifyContent(FlexAlign.End)
          .width(this.w)
          .onClick(() => {
            this.clickShare?.()
          })
        }
      }
    }
    .backgroundColor($r("app.color.card"))
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .width("100%")
    .height($r('app.float.common_length_56'))
    .padding({
      left: $r('app.float.common_space_16'),
      right: $r('app.float.common_space_16'),
    })
  }
}


