import { buffer, util } from "@kit.ArkTS";

export class StrUtil {
  /**
   * 字符串是否为空(undefined、null)
   * @param str 被检测的字符串
   * @returns 是否为空
   */
  static isNull(str: string | undefined | null): boolean {
    return str == undefined || str == null;
  }

  /**
   * 判断字符串是否为非空。true为非空空，否则false
   * @param str
   * @returns
   */
  static isNotNull(str: string | undefined | null) {
    return false == StrUtil.isNull(str);
  }


  /**
   * 字符串是否为空(undefined、null、字符串长度为0)
   * @param str 被检测的字符串
   * @return 是否为空
   */
  static isEmpty(str: string | undefined | null): boolean {
    return str == undefined || str == null || str.length == 0;
  }

  /**
   * 判断字符串是否为非空。true为非空空，否则false
   * @param str
   * @returns
   */
  static isNotEmpty(str: string | undefined | null) {
    return false == StrUtil.isEmpty(str);
  }

  /**
   * Byte flow into understandable strings
   * @param array
   * @returns
   */
  static uint8ArrayToString(array: Uint8Array) {
    let textDecoderOptions: util.TextDecoderOptions = {
      fatal: false,
      ignoreBOM: true
    }
    let decodeToStringOptions: util.DecodeToStringOptions = {
      stream: false
    }
    let textDecoder = util.TextDecoder.create('utf-8', textDecoderOptions);
    let retStr = textDecoder.decodeToString(array, decodeToStringOptions);
    return retStr;
  }

  /**
   * Convert string to byte stream
   * @param str
   * @returns
   */
  static stringToUint8Array(str: string) {
    console.info('Convert string to byte stream:' + new Uint8Array(buffer.from(str, 'utf-8').buffer));
    return new Uint8Array(buffer.from(str, 'utf-8').buffer);
  }

  /**
   * Hexadecimal to Uint8Array
   * @param data
   * @returns
   */
  static hexStrTouint8Array(data: string): Uint8Array {
    return new Uint8Array(buffer.from(data, 'hex').buffer);
  }

  /**
   * Uint8Array to hexadecimal
   * @param data
   * @returns
   */
  static uint8ArrayToHexStr(data: Uint8Array): string {
    let hexString = '';
    let i: number;
    for (i = 0; i < data.length; i++) {
      let char = ('00' + data[i].toString(16)).slice(-2);
      hexString += char;
    }
    return hexString;
  }

}