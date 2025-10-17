import { customScan, generateBarcode, scanBarcode, scanCore } from "@kit.ScanKit";
import { image } from "@kit.ImageKit";
import { AsyncCallback, BusinessError } from "@kit.BasicServicesKit";
import { Logger } from "./Logger";


const TAG: string = '[ImageUtil]';

export class ScanUtil {
  /**
   * 通过文本生成码图，使用Promise异步回调返回生成的码图。
   * @param content
   * @param options
   * @returns
   */
  static async createBarcode(content: string, options: generateBarcode.CreateOptions): Promise<image.PixelMap> {
    try {
      let data = await generateBarcode.createBarcode(content, options)
      return Promise.resolve(data)
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `createBarcode failed code: ${err.code}, message: ${err.message}`)
      return Promise.reject(error)
    }
  }

  /**
   * 默认界面扫码
   * @returns
   */
  static async startScanForResult(): Promise<scanBarcode.ScanResult> {
    let options: scanBarcode.ScanOptions = {
      scanTypes: [scanCore.ScanType.ALL],
      enableMultiMode: true,
      enableAlbum: true
    };
    try {
      let data = await scanBarcode.startScanForResult(getContext(), options)
      return Promise.resolve(data)
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `startScanForResult failed code: ${err.code}, message: ${err.message}`)
      return Promise.reject(error)
    }
  }

  static async csInit(options: scanBarcode.ScanOptions): Promise<void> {
    try {
      customScan.init(options);
      return Promise.resolve()
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `csInit failed code: ${err.code}, message: ${err.message}`)
      return Promise.reject(error)
    }
  }

  static async csStart(viewControl: customScan.ViewControl): Promise<Array<scanBarcode.ScanResult>> {
    try {
      let data = await customScan.start(viewControl)
      return Promise.resolve(data)
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `csStart failed code: ${err.code}, message: ${err.message}`)
      return Promise.reject(error)
    }
  }

  static async csRescan(): Promise<void> {
    try {
      customScan.rescan()
      return Promise.resolve()
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `csStart failed code: ${err.code}, message: ${err.message}`)
      return Promise.reject(error)
    }
  }

  static async csStop(): Promise<void> {
    try {
      await customScan.stop();
      return Promise.resolve()
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `csStop failed code: ${err.code}, message: ${err.message}`)
      return Promise.reject(error)
    }
  }

  static async csRelease(): Promise<void> {
    try {
      await customScan.release()
      return Promise.resolve()
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `csRelease failed code: ${err.code}, message: ${err.message}`)
      return Promise.reject(error)
    }
  }

  static async csOnLightingFlash(callback?: AsyncCallback<boolean, void>): Promise<void> {
    try {
      customScan.on('lightingFlash', callback);
      return Promise.resolve()
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `csOnLightingFlash failed code: ${err.code}, message: ${err.message}`)
      return Promise.reject(error)
    }
  }

  static async csOffLightingFlash(): Promise<void> {
    try {
      customScan.off('lightingFlash');
      return Promise.resolve()
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `csOffLightingFlash failed code: ${err.code}, message: ${err.message}`)
      return Promise.reject(error)
    }
  }

  static async csGetFlashLightStatus(): Promise<boolean> {
    try {
      let data = customScan.getFlashLightStatus()
      return Promise.resolve(data)
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `csGetFlashLightStatus failed code: ${err.code}, message: ${err.message}`)
      return Promise.reject(error)
    }
  }

  static async csCloseFlashLight(): Promise<void> {
    try {
      customScan.closeFlashLight()
      return Promise.resolve()
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `csCloseFlashLight failed code: ${err.code}, message: ${err.message}`)
      return Promise.reject(error)
    }
  }

  static async csOpenFlashLight(): Promise<void> {
    try {
      customScan.openFlashLight()
      return Promise.resolve()
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `csOpenFlashLight failed code: ${err.code}, message: ${err.message}`)
      return Promise.reject(error)
    }
  }

  static async csSetFocusPoint(point: scanBarcode.Point): Promise<void> {
    try {
      customScan.setFocusPoint(point)
      return Promise.resolve()
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `csSetFocusPoint failed code: ${err.code}, message: ${err.message}`)
      return Promise.reject(error)
    }
  }

  static async csResetFocus(): Promise<void> {
    try {
      customScan.resetFocus()
      return Promise.resolve()
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `csResetFocus failed code: ${err.code}, message: ${err.message}`)
      return Promise.reject(error)
    }
  }

  static async csGetZoom(): Promise<number> {
    try {
      let data = customScan.getZoom()
      return Promise.resolve(data)
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `csGetZoom failed code: ${err.code}, message: ${err.message}`)
      return Promise.reject(error)
    }
  }

  static async csSetZoom(zoomValue: number): Promise<void> {
    try {
      customScan.setZoom(zoomValue)
      return Promise.resolve()
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      Logger.error(TAG, `csSetZoom failed code: ${err.code}, message: ${err.message}`)
      return Promise.reject(error)
    }
  }
}