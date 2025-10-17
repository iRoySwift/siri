/**
 * 鸿蒙资源管理工具
 */
export class ResourceUtil {
  /**
   * 获取当前应用的资源管理对象
   * @returns
   */
  static getResourceManager() {
    return getContext().resourceManager;
  }

  /**
   * 获取指定资源ID对应的字符串
   * @param resId 资源ID值
   * @returns
   */
  static getStringSync(resId: number): string {
    return ResourceUtil.getResourceManager().getStringSync(resId)
  }

  /**
   * 获取指定资源名称对应的默认或指定的屏幕密度媒体文件内容
   * @param resName – - 资源名称
   * @param density – - 资源获取需要的屏幕密度，0或缺省表示默认屏幕密度。
   * @returns Uint8Array
   */
  static getMediaByNameSync(resName: string,density?: number): Uint8Array {
    return ResourceUtil.getResourceManager().getMediaByNameSync(resName, density)
  }

  /**
   * 获取media下文件
   * @param resource – - Indicates the resource object.
   * @returns Promise<Uint8Array>
   */
  static getMediaByName(resName: string): Promise<Uint8Array> {
    return ResourceUtil.getResourceManager().getMediaByName(resName)
  }

  /**
   * 获取指定资源ID对应的默认或指定的屏幕密度媒体文件内容
   * @param resId – - 资源ID值
   * @param density – - 资源获取需要的屏幕密度，0或缺省表示默认屏幕密度。
   * @returns <Uint8Array>
   */
  static getMediaContentSync(resId: number, density?: number): Uint8Array {
    return ResourceUtil.getResourceManager().getMediaContentSync(resId, density)
  }

  /**
   * 获取media下文件
   * @param resource – - Indicates the resource object.
   * @returns Promise<Uint8Array>
   */
  static getMediaContent(resource: Resource): Promise<Uint8Array> {
    return ResourceUtil.getResourceManager().getMediaContent(resource)
  }

  /**
   * 获取resources/rawfile目录下对应的rawfile文件内容，使用异步形式返回
   * @param path rawfile文件路径
   * @returns Promise<Uint8Array>
   */
  static getRawFileContent(path: string): Promise<Uint8Array> {
    return ResourceUtil.getResourceManager().getRawFileContent(path)
  }

  /**
   * 获取resources/rawfile目录下对应的rawfile文件内容，使用同步形式返回
   * @param name rawfile文件路径
   * @returns Uint8Array
   */
  static getRawFileContentSync(path: string): Uint8Array {
    return ResourceUtil.getResourceManager().getRawFileContentSync(path)
  }
}