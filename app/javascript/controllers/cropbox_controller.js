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
    this.cropbox();
  }

  connect() {}

  cropbox() {
    // 이미지
    const img = this.originImgTarget;
    // 실시간 데이터 감시
    const watchCropX = this.watchCropXTarget;
    const watchCropY = this.watchCropYTarget;
    const watchCropW = this.watchCropWTarget;
    const watchCropH = this.watchCropHTarget;
    const getDataColumn = this.getDataColumnTarget.value;
    const getDataRow = this.getDataRowTarget.value;
    const getDataLine = this.getDataLineTarget.value;
    // 계산된 크롭박스 정보
    const computedWidth = getDataColumn * 171.496062992123;
    const computedHeight =
      getDataRow * 97.32283464566807 + getDataLine * 13.903262092238295;
    // 저장된 크롭박스 정보
    const savedDataCropX = parseInt(this.savedDataCropXTarget.innerText);
    const savedDataCropY = parseInt(this.savedDataCropYTarget.innerText);
    const savedDataCropW = parseInt(this.savedDataCropWTarget.innerText);
    const savedDataCropH = parseInt(this.savedDataCropHTarget.innerText);
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
