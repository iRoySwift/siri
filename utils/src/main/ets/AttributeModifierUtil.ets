/**
 * 文本展示最大行数
 */
export class TextMaxLineEllStyle implements AttributeModifier<TextAttribute> {
  maxLines: number = 1
  constructor(maxLines: number) {
    this.maxLines = maxLines
  }
  applyNormalAttribute(instance: TextAttribute): void {
    instance.maxLines(this.maxLines)
    instance.ellipsisMode(EllipsisMode.END)
    instance.textOverflow({
      overflow: TextOverflow.Ellipsis
    })
  }
}