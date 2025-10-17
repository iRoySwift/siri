import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { dataSharePredicates } from '@kit.ArkData';
import fs from '@ohos.file.fs';

const MAX_SELECT_NUMBER: number = 9;

/**
 * 相册管理工具
 */
export class PhotoUtil {
  /**
   * 媒体文件选择
   * @argument option.MIMEType:photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE 媒体文件类型
   * @argument option.maxSelectNumber:9 选择媒体文件数量的最大值
   * @argument option.isPhotoTakingSupported: true 是否支持拍照
   * @argument option.isSearchSupported: true 是否支持搜索
   * @argument option.isPreviewForSingleSelectionSupported: true 是否需要进大图预览
   * @argument option.isEditSupported: true 是否支持编辑照片
   * @argument option.isOriginalSupported: true 是否显示选择原图按钮
   * @returns Promise<photoAccessHelper.PhotoSelectResult>
   * @since 12
   */
  static async select(option?: photoAccessHelper.PhotoSelectOptions | undefined): Promise<photoAccessHelper.PhotoSelectResult> {
    if (!option) {
      option = new photoAccessHelper.PhotoSelectOptions();
      option.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
      option.maxSelectNumber = MAX_SELECT_NUMBER;
      option.isPhotoTakingSupported = true;
      option.isSearchSupported = true;
      option.isPreviewForSingleSelectionSupported = true;
      option.isEditSupported = true;
      option.isOriginalSupported = true;
    }

    let photoPicker = new photoAccessHelper.PhotoViewPicker();
    let photoSelectResult: photoAccessHelper.PhotoSelectResult = await photoPicker.select(option)
    return photoSelectResult;
  }


  /**
   * 创建图片或视频资源 路径
   * 指定文件类型、后缀和创建选项，创建图片或视频资源
   * 在未申请相册管理模块权限'ohos.permission.WRITE_IMAGEVIDEO'时，可以使用安全控件或授权弹窗的方式创建媒体资源
   * @param photoType：photoAccessHelper.PhotoTyp
   * @param extension：jpg
   * @param options?: photoAccessHelper.CreateOptions
   * @returns 创建资源的uri。
   */
  static async createAsset(photoType: photoAccessHelper.PhotoType, extension: string,
    options?: photoAccessHelper.CreateOptions): Promise<string> {
    let phAccessHelper = photoAccessHelper.getPhotoAccessHelper(getContext());
    let uri = await phAccessHelper.createAsset(photoType, extension, options);
    await phAccessHelper.release()
    return uri;
  }

  /**
   * 保存沙箱路径图片到相册
   * 在未申请相册管理模块权限'ohos.permission.WRITE_IMAGEVIDEO'时，可以使用安全控件或授权弹窗的方式创建媒体资源
   * @param fileUri：沙箱路径
   * @returns 资源信息
   */
  static async applyChanges(fileUri: string):  Promise<photoAccessHelper.PhotoAsset> {
    let phAccessHelper = photoAccessHelper.getPhotoAccessHelper(getContext());
    let assetChangeRequest: photoAccessHelper.MediaAssetChangeRequest =
      photoAccessHelper.MediaAssetChangeRequest.createImageAssetRequest(getContext(), fileUri);
    await phAccessHelper.applyChanges(assetChangeRequest);
    let photoAsset = assetChangeRequest.getAsset()
    await phAccessHelper.release()
    return photoAsset;
  }

  /**
   * 获取图片信息
   * @param uri 文件uri
   * @return Promise<Record<string, PixelMap | string | ArrayBuffer>>
   * @since 12
   */
  public static async getPhotoAsset(uri: string): Promise<photoAccessHelper.PhotoAsset> {
    let phAccessHelper = photoAccessHelper.getPhotoAccessHelper(getContext());
    // 根据 uri获取图片/视频资源
    let predicates: dataSharePredicates.DataSharePredicates = new dataSharePredicates.DataSharePredicates();
    predicates.equalTo('uri', uri);
    let fetchResult: photoAccessHelper.FetchResult<photoAccessHelper.PhotoAsset> = await phAccessHelper.getAssets({
      fetchColumns: [
        photoAccessHelper.PhotoKeys.PHOTO_TYPE,
        photoAccessHelper.PhotoKeys.DISPLAY_NAME,
        photoAccessHelper.PhotoKeys.SIZE,
        photoAccessHelper.PhotoKeys.DURATION,
        photoAccessHelper.PhotoKeys.WIDTH,
        photoAccessHelper.PhotoKeys.HEIGHT,
        photoAccessHelper.PhotoKeys.DATE_TAKEN,
        photoAccessHelper.PhotoKeys.ORIENTATION,
        photoAccessHelper.PhotoKeys.FAVORITE,
        photoAccessHelper.PhotoKeys.TITLE,
        photoAccessHelper.PhotoKeys.DATE_ADDED_MS,
        photoAccessHelper.PhotoKeys.DATE_MODIFIED_MS,
      ],
      predicates
    })
    let photoAsset: photoAccessHelper.PhotoAsset = await fetchResult.getFirstObject();
    await phAccessHelper.release();
    return photoAsset;
  }



}