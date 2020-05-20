import { Controller } from "stimulus";
import Cropper from "cropperjs";

export default class extends Controller {
  static targets = [
    "originImg",
    "watchCropX",
    "watchCropY",
    "watchCropW",
    "watchCropH",
    "getDataColumn",
    "getDataRow",
    "getDataLine",
    "savedDataCropX",
    "savedDataCropY",
    "savedDataCropW",
    "savedDataCropH",
  ];

  initialize() {
    Cropper.noConflict();
    this.cropbox();
  }

  connect() {}

  cropbox() {
    // 이미지 타겟 설정
    const img = this.originImgTarget;
    // 초기 설정
    const lengthPerColumn = 171.496062992123;
    const lengthPerRow = 97.32283464566807;
    const lengthPerLine = 13.903262092238295;
    // 실시간 데이터 감시
    const watchCropX = this.watchCropXTarget;
    const watchCropY = this.watchCropYTarget;
    const watchCropW = this.watchCropWTarget;
    const watchCropH = this.watchCropHTarget;
    // 저장된 data 속성 정보
    const getDataArticleKind = this.data.get("article-kind");
    const getDataArticleColumn = parseInt(this.data.get("article-column"));
    const getDataArticleRow = parseInt(this.data.get("article-row"));
    const getDataArticleLine = parseInt(this.data.get("article-line"));
    const getDataColumn = parseInt(this.data.get("column"));
    const getDataRow = parseInt(this.data.get("row"));
    const getDataLine = parseInt(this.data.get("extra-height-in-lines"));
    // 저장된 DB의 크롭박스 정보
    const savedDataCropX = parseInt(this.savedDataCropXTarget.innerText);
    const savedDataCropY = parseInt(this.savedDataCropYTarget.innerText);
    const savedDataCropW = parseInt(this.savedDataCropWTarget.innerText);
    const savedDataCropH = parseInt(this.savedDataCropHTarget.innerText);
    // 계산된 크롭박스 정보
    if (getDataArticleKind == "사진") {
      var computedWidth = getDataArticleColumn * lengthPerColumn;
      var computedHeight =
        getDataArticleRow * lengthPerRow + getDataArticleLine * lengthPerLine;
    } else {
      var computedWidth = getDataColumn * lengthPerColumn;
      var computedHeight =
        getDataRow * lengthPerRow + getDataLine * lengthPerLine;
    }
    // 크롭 기능
    new Cropper(img, {
      viewMode: 2,
      dragMode: "move",
      aspectRatio: computedWidth / computedHeight,
      autoCropArea: 1,
      restore: false,
      guides: true,
      center: false,
      highlight: true,
      cropBoxMovable: true,
      cropBoxResizable: true,
      toggleDragModeOnDblclick: false,
      modal: true,
      data: {
        x: savedDataCropX,
        y: savedDataCropY,
        width: savedDataCropW,
        height: savedDataCropH,
      },
      crop(event) {
        (watchCropX.value = Math.round(event.detail.x)),
          (watchCropY.value = Math.round(event.detail.y)),
          (watchCropW.value = Math.round(event.detail.width)),
          (watchCropH.value = Math.round(event.detail.height));
      },
    });
  }
}
