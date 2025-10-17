import fs, { ReadOptions, WriteOptions } from "@ohos.file.fs"
import { fileUri } from "@kit.CoreFileKit";
import { BusinessError } from "@kit.BasicServicesKit";
import { Logger } from "./Logger";
import { ResourceUtil } from "./ResourceUtil";

const TAG: string = '[FileUtil]';

/**
 * 文件管理工具
 */
export class FileUtil {
  /**
   * 判断文件是否是普通文件。
   * @param file - 应用沙箱路径或已打开文件描述fd
   * @returns
   */
  static isFile(file: string | number): boolean {
    return fs.statSync(file).isFile();
  }

  /**
   * 判断文件是否是目录。
   * @param file - 应用沙箱路径或已打开文件描述fd
   * @returns
   */
  static isDirectory(file: string | number): boolean {
    return fs.statSync(file).isDirectory();
  }

  /**
   * 生成一个文件沙箱地址
   * @param dirPath
   * @param fileName
   * @param isHaps
   * @returns
   */
  static getFilePath(fileName: string = '', isHaps?: boolean): string {
    let filepath = isHaps ? getContext().filesDir : getContext().getApplicationContext().filesDir
    if (!fs.accessSync(filepath)) {
      fs.mkdirSync(filepath)
    }
    if (fileName) {
      filepath = filepath + '/' + fileName;
    }
    return filepath
  }

  /**
   * 同步 获取文件URI。
   * @param path 应用沙箱路径或URI
   * @returns
   */
  static getUriFromPath(path: string): string {
    return fileUri.getUriFromPath(path);
  }

  /**
   * 获取文件Buffer
   * @param path 文件沙箱路径或URI
   * @returns promise
   */
  static async getFileBuffer(path: string): Promise<ArrayBuffer> {
    try {
      const file = fs.openSync(path, fs.OpenMode.READ_ONLY)
      const stat = fs.statSync(file.fd)
      const buffer = new ArrayBuffer(stat.size)
      fs.readSync(file.fd, buffer)
      fs.closeSync(file)
      return Promise.resolve(buffer)
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `getFileBuffer failed code: ${err.code}, message: ${err.message}`)
      return Promise.reject(error)
    }
  }

  /**
   * 复制文件
   * @param src 文件的应用沙箱路径或URI
   * @param dest 目标文件路径或目标文件的文件描述符
   */
  static copyFileSync(src: string, dest: string): boolean {
    Logger.info(TAG, 'copyFile path src: ' + src);
    Logger.info(TAG, 'copyFile path dest: ' + dest);
    try {
      let srcFile = fs.openSync(src, fs.OpenMode.READ_ONLY);
      let distFile = fs.openSync(dest, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      fs.copyFileSync(srcFile.fd, distFile.fd);
      fs.closeSync(srcFile);
      fs.closeSync(distFile);
      Logger.info(TAG, 'copyFile success');
      return true;
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `copyFile failed code: ${err.code}, message: ${err.message}`);
      return false;
    }
  }

  /**
   * 复制资源文件到目标文件路径
   * @param path rawfile文件路径
   * @param dest
   */
  static copyRawFileSync(path: string, dest: string): boolean {
    try {
      let raw_buf = ResourceUtil.getRawFileContentSync(path)
      let dst = fs.openSync(dest, fs.OpenMode.CREATE | fs.OpenMode.WRITE_ONLY);
      fs.writeSync(dst.fd, raw_buf.buffer)
      fs.closeSync(dst.fd)
      return true
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `copyRawFile failed code: ${err.code}, message: ${err.message}`);
      return false;
    }
  }

  /**
   * 删除目录
   * @param filePath 目标沙箱路径
   */
  static deleteFile(filePath: string): void {
    Logger.info(TAG, 'rmdir deleteFile:' + filePath);
    fs.rmdir(filePath, (err: BusinessError) => {
      if (err) {
        Logger.error(TAG, `deleteFile failed code: ${err.code}, message: ${err.message}`);
      } else {
        Logger.info(TAG, 'deleteFile succeed');
      }
    });
  }

  /**
   * 保存buffer到目标路径
   * @param filePath 目标沙箱路径
   * @param buffer Buffer
   */
  static saveBuffer2File(filePath: string, buffer: ArrayBuffer): void {
    Logger.info(TAG, 'saveBuffer2File filePath:' + filePath);
    try {
      let distFile = fs.openSync(filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      fs.writeSync(distFile.fd, buffer);
      fs.closeSync(distFile.fd)
      Logger.info(TAG, 'saveBuffer2File success');
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `saveBuffer2File failed code: ${err.code}, message: ${err.message}`);
    }
  }
}