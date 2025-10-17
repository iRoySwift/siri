import { AppUtil } from "./AppUtil";
import { promptAction } from "@kit.ArkUI";

export class ToastUtil {
    /**
     * 显示即时反馈并通过Promise返回其id
     * @param options
     * @returns
     * @since 18
     */
    static openToast(options: promptAction.ShowToastOptions): Promise<number> {
        return AppUtil.getUIContext().getPromptAction().openToast(options)
    }

    /**
     * 关闭即时反馈。
     * @param toastId
     * @since 18
     */
    static closeToast(toastId: number): void {
        AppUtil.getUIContext().getPromptAction().closeToast(toastId)
    }

    /**
     * 创建并显示即时反馈
     * @param options
     * @returns
     * @since 11
     */
    static showToast(options: promptAction.ShowToastOptions) {
        let uiContext = AppUtil.getUIContext();
        if(uiContext) {
            return uiContext.getPromptAction().showToast(options)
        } else {
            return promptAction.showToast(options)
        }
    }
}