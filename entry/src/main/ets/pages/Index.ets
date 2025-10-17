import { UtilsPage } from './utils/UtilsPage';

@Entry
@Component
struct Index {
  @State text: string = '文本';
  @State barMode: BarMode = BarMode.Fixed;
  @State fontColor: string = '#182431';
  @State selectedFontColor: string = '#007DFF';
  @State currentIndex: number = 0;
  @State selectedIndex: number = 0;
  private controller: TabsController = new TabsController();

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.Start, index: this.currentIndex, controller: this.controller }) {
        TabContent() {
          UtilsPage()
        }.tabBar(this.tabBuilder(0, '工具'))

        TabContent() {
          Column().width('100%').height('100%').backgroundColor('#007DFF')
        }.tabBar(this.tabBuilder(1, '组件'))
      }
      .height('100%')
      .barMode(BarMode.Fixed)
      .barPosition(BarPosition.End)
      .barBackgroundColor($r("app.color.card"))
      .onChange((index: number) => {
        // currentIndex控制TabContent显示页签
        this.currentIndex = index;
        this.selectedIndex = index;
      })
      .onAnimationStart((index: number, targetIndex: number, event: TabsAnimationEvent) => {
        if (index === targetIndex) {
          return;
        }
        this.selectedIndex = targetIndex;
      })
    }
    .width('100%')
    .height("100%")
    .backgroundColor($r("app.color.background"))
  }

  @Builder tabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.selectedIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(16)
        .fontWeight(this.selectedIndex === index ? 500 : 400)
        .lineHeight(22)
        .margin({ top: 17, bottom: 7 })
    }.width('100%')
  }
}