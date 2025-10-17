import { image } from "@kit.ImageKit";
import { ResourceUtil } from "./ResourceUtil";
import fs, { ReadOptions, WriteOptions } from "@ohos.file.fs"

export class ImageUtil {
  /**
   * 转media资源转成pixelMap
   * @param resource: media下resource
   * @param options 解码参数
   * @returns
   */
  static async getPixelMapByMedia(resource: Resource, options?: image.DecodingOptions): Promise<image.PixelMap> {
    let buf = await ResourceUtil.getMediaContent(resource)
    return image.createImageSource(buf.buffer).createPixelMap(options)
  }

  /**
   * 将pixelMap转成文件
   * @param pixelmap
   * @param fd
   * @param format
   * @returns
   */
  static packToFileFromPixelMap(pixelmap: PixelMap, fd: number, format = "image/jpeg") {
    let packOpts: image.PackingOption = { format, quality: 98 }
    const imagePackerObj: image.ImagePacker = image.createImagePacker();
    return imagePackerObj.packToFile(pixelmap, fd, packOpts).finally(() => {
      imagePackerObj.release()
    })
  }

  /**
   * 将Picture转成文件
   * @param picture: Picture
   * @param fd
   * @param format
   * @returns
   */
  static packToFileFromPicture(picture: image.Picture, fd: number, format = "image/jpeg") {
    let packOpts: image.PackingOption = { format, quality: 98 }
    const imagePackerObj: image.ImagePacker = image.createImagePacker();
    return imagePackerObj.packToFile(picture, fd, packOpts).finally(() => {
      imagePackerObj.release()
    })
  }

  /**
   * 将ImageSource转成文件
   * @param source: image.ImageSource
   * @param fd
   * @param format
   * @returns
   */
  static packToFileFromImageSource(source: image.ImageSource, fd: number, format = "image/jpeg") {
    let packOpts: image.PackingOption = { format, quality: 98 }
    const imagePackerObj: image.ImagePacker = image.createImagePacker();
    return imagePackerObj.packToFile(source, fd, packOpts).finally(() => {
      imagePackerObj.release()
    })
  }

  /**
   * 保存图片到沙箱路径
   * @param pixelmap PixelMap
   * @param path 沙箱路径
   * @param format 图片格式
   * @returns
   */
  static async savePixelMap(pixelmap: PixelMap, path: string, filename: string,
    format = "image/jpeg"): Promise<string> {
    let filepath = path + '/' + filename
    let file = fs.openSync(filepath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
    await ImageUtil.packToFileFromPixelMap(pixelmap, file.fd, format)
    fs.closeSync(file.fd)
    return filepath;
  }
}