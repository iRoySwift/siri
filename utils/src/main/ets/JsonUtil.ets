export class JsonUtil {
  /**
   * 判断是否是json字符串
   */
  static isJsonStr(str: string): boolean {
    try {
      JSON.parse(str)
      return true;
    } catch (e) {
      return false;
    }
  }

  /**
   * json字符串转对象
   * @param str
   * @returns
   */
  static jsonStrToBean<T>(str: string): T | null {
    try {
      return JSON.parse(str) as T
    } catch (e) {
      return null
    }
  }

  /**
   * json字符串转数组
   * @param str
   * @returns
   */
  static jsonStrToArray<T>(str: string): Array<T> {
    try {
      return JSON.parse(str) as Array<T>
    } catch (e) {
      return []
    }
  }

  /**
   * 对象转json字符串
   * @param str
   * @returns
   */
  static beanToJsonStr<T>(data: object | null | undefined): string {
    try {
      if(!data) return ''
      return JSON.stringify(data) as string
    } catch (e) {
      return ''
    }
  }
}