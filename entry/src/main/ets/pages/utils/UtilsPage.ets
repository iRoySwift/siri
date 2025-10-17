import { JsonUtil, ResourceUtil, StringUtil } from "@siri/utils"
import { NavigationView } from "../../components/NavigationView";
import { router } from "@kit.ArkUI";

class UtilsDataBean {
  name: string
  desc: string
  url: string

  constructor(name: string, desc: string, url: string,) {
    this.name = name;
    this.desc = desc;
    this.url = url;
  }
}

@Component
export struct UtilsPage {
  @State data: UtilsDataBean[] = []

  aboutToAppear(): void {
    let array = ResourceUtil.getRawFileContentSync("utils.json")
    let str = StringUtil.uint8ArrayToString(array)
    let data = JsonUtil.jsonStrToArray<UtilsDataBean>(str)
    console.log(data.toString())
    this.data = data;
  }

  build() {
    Column() {
      NavigationView({
        leftView: () => {
        },
        title: "工具",
        rightView: () => {
        }
      })
      List() {
        ForEach(this.data, (item: UtilsDataBean) => {
          ListItem() {
            Row() {
              Text(item.name).fontSize(16).fontColor($r("app.color.card_foreground"))
            }
            .width("100%")
            .padding($r("app.float.common_space_16"))
            .justifyContent(FlexAlign.Center)
            .borderRadius($r("app.float.common_radius_6"))
            .backgroundColor($r("app.color.card"))
          }
          .width("100%")
          .padding($r("app.float.common_space_16"))
          .onClick(()=>{
            router.pushUrl({
              url: item.url,
            })
          })
        })
      }
      .layoutWeight(1)
    }
    .width("100%")
    .height("100%")
    .backgroundColor($r("app.color.background"))
  }
}