import { AppUtil, FileUtil, ImageUtil, Logger, PermissionUtil, PhotoUtil, ToastUtil } from '@siri/utils'
import { BusinessError } from '@kit.BasicServicesKit'
import { NavigationView } from '../../components/NavigationView'
import { photoAccessHelper } from '@kit.MediaLibraryKit'
import { Permissions } from '@kit.AbilityKit'
import { image } from '@kit.ImageKit'

const PERMISSIONS: Array<Permissions> = [
  'ohos.permission.WRITE_IMAGEVIDEO'
];

@Entry
@Component
struct PhotoUtilPage {
  @State userGrant: boolean = false
  @State photoInfo: string = ''
  @State pixelMap?: image.PixelMap = undefined

  async aboutToAppear() {
  }

  /**
   * 二次授权
   * @param permissions
   * @returns
   */
  async requestPermissionOnSetting(): Promise<void> {
    if (!await PermissionUtil.checkPermissions(PERMISSIONS)) {
      if (!await PermissionUtil.requestPermissionOnSetting(PERMISSIONS)) {
        ToastUtil.showToast({
          message:"请在隐私和安全里面，打开图片和视频权限",
          duration: 2000
        })
        return;
      } else {
        this.userGrant = true
      }
    }
  }

  save() {
    PhotoUtil.createAsset(photoAccessHelper.PhotoType.IMAGE,'jpg',{
      title: 'test'
    }).then((res)=>{
      let flag = FileUtil.copyRawFileSync('test.png',res)
      if(flag) {
        ToastUtil.showToast({message: "保存成功"})
      } else {
        ToastUtil.showToast({message: "保存失败"})
      }
    }).catch((error:BusinessError)=>{
      Logger.error(`调用出错：code： ${error.code}, message: ${error.message}`)
    })
  }

  async saveButton() {
    let pixelMap = await ImageUtil.getPixelMapByMedia($r("app.media.startIcon"))
    let path = FileUtil.getUriFromPath(FileUtil.getFilePath(''))
    let filepath = await ImageUtil.savePixelMap(pixelMap,path,'test.png')
    PhotoUtil.applyChanges(filepath)
  }

  async getPhotoInfo() {
    PhotoUtil.select().then((res)=>{
      PhotoUtil.getPhotoAsset(res[0])
        .then((photoAsset)=>{
          try {
            let name = photoAsset?.get(photoAccessHelper.PhotoKeys.DISPLAY_NAME);
            let type = photoAsset?.get(photoAccessHelper.PhotoKeys.PHOTO_TYPE);
            let title = photoAsset?.get(photoAccessHelper.PhotoKeys.TITLE.toString());
            let size = photoAsset?.get(photoAccessHelper.PhotoKeys.SIZE.toString());
            let with1 = photoAsset?.get(photoAccessHelper.PhotoKeys.WIDTH.toString());
            let height = photoAsset?.get(photoAccessHelper.PhotoKeys.HEIGHT.toString());
            let date = photoAsset?.get(photoAccessHelper.PhotoKeys.DATE_TAKEN.toString());
            let orientation = photoAsset?.get(photoAccessHelper.PhotoKeys.ORIENTATION.toString());
            this.photoInfo = `图片信息：\n文件名：${name}\n文件类型：${type}\n文件大小：${size}\n图片宽度：${with1}\n图片高度：${height}\n拍摄日期：${date}\n文件标题：${title}\n图片文件的方向：${orientation}`
          } catch (err) {
            Logger.error("读取图片信息失败：" + JSON.stringify(err));
          }
          photoAsset?.getThumbnail((err, pixelMap) => {
            if (err) {
              Logger.error("缩略图-异常：" + JSON.stringify(err));
              return;
            }
            this.pixelMap = pixelMap;
          })
        })
    })
  }

  build() {
    Column() {
      NavigationView({
        leftView: () => {
        },
        title: "相册工具",
        rightView: () => {
        }
      })
      List({space: 16}) {
        ListItem() {
          Button("默认-图片选择")
            .width("100%")
            .onClick(()=>{
              PhotoUtil.select().then((res)=>{
                this.photoInfo = '选择的图片' + res.photoUris.join(',')
                Logger.info("调用成功：photoUris：", res.photoUris.toString())
              }).catch((error:BusinessError)=>{
                Logger.error(`调用出错：code： ${error.code}, message: ${error.message}`)
              })
            })
        }
        ListItem() {
          Button("单选-图片选择")
            .width("100%")
            .onClick(()=>{
              let option = new photoAccessHelper.PhotoSelectOptions();
              option.maxSelectNumber = 1;
              PhotoUtil.select(option).then((res)=>{
                Logger.info("调用成功：photoUris：", res.photoUris.toString())
              }).catch((error:BusinessError)=>{
                Logger.error(`调用出错：code： ${error.code}, message: ${error.message}`)
              })
            })
        }
        ListItem() {
          Button("保存图片")
            .width("100%")
            .onClick(async ()=>{
              this.userGrant = await PermissionUtil.requestPermissionsFromUser(PERMISSIONS)
              await this.requestPermissionOnSetting()
              if(this.userGrant) {
                this.save()
              } else {
                AppUtil.toAppSetting()
              }
            })
        }
        ListItem() {
          Row() {
            SaveButton({
              icon: SaveIconStyle.FULL_FILLED,
              text: SaveDescription.SAVE,
              buttonType: ButtonType.Capsule
            })
              .width("100%")
              .onClick(async ()=>{
                this.saveButton()
              })
          }
        }
        ListItem() {
          Button("获取图片信息")
            .width("100%")
            .onClick(async ()=>{
              this.getPhotoInfo()
            })
        }
        if(this.photoInfo){
          ListItem() {
            Row() {
              Text(this.photoInfo)
            }
            .width("100%")
            .padding($r("app.float.common_space_16"))
            .borderWidth(1)
            .borderRadius($r("app.float.common_radius_6"))
            .borderStyle(BorderStyle.Dashed)
          }
        }
        if(this.pixelMap) {
          ListItem() {
            Row() {
              Image(this.pixelMap)
            }
            .width("100%")
            .padding($r("app.float.common_space_16"))
            .borderWidth(1)
            .borderRadius($r("app.float.common_radius_6"))
            .borderStyle(BorderStyle.Dashed)
          }
        }
      }
      .padding($r("app.float.common_space_16"))
    }
    .width("100%")
    .height("100%")
    .backgroundColor($r("app.color.background"))
  }
}