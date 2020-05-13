// import Cropper from "cropperjs";

// const image = document.getElementById("cropbox");
// var $dataX = $("#dataX");
// var $dataY = $("#dataY");
// var $dataW = $("#dataW");
// var $dataH = $("#dataH");
// var $getColumnNumber = $("#image_column").val();
// var $getRowNumber = $("#image_row").val();
// var $getLineNumber = $("#image_extra_height_in_lines").val();
// var $setWidth = $getColumnNumber * 171.496062992123;
// var $setHeight =
//   $getRowNumber * 97.32283464566807 + $getLineNumber * 13.903262092238295;
// var $getDataCropX = parseInt($("#getDataCropX")[0].innerText);
// var $getDataCropY = parseInt($("#getDataCropY")[0].innerText);
// var $getDataCropW = parseInt($("#getDataCropW")[0].innerText);
// var $getDataCropH = parseInt($("#getDataCropH")[0].innerText);

// const cropper = new Cropper(image, {
//   viewMode: 2,
//   dragMode: "move",
//   aspectRatio: $setWidth / $setHeight,
//   autoCropArea: 1,
//   restore: false,
//   guides: true,
//   center: false,
//   highlight: true,
//   cropBoxMovable: true,
//   cropBoxResizable: true,
//   toggleDragModeOnDblclick: false,
//   modal: true,
//   data: {
//     x: $getDataCropX,
//     y: $getDataCropY,
//     width: $getDataCropW,
//     height: $getDataCropH,
//   },
//   crop(event) {
//     $dataX.val(Math.round(event.detail.x));
//     $dataY.val(Math.round(event.detail.y));
//     $dataW.val(Math.round(event.detail.width));
//     $dataH.val(Math.round(event.detail.height));
//   },
// });
