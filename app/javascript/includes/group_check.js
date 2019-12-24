$(function() {
  var check_caption_type = $(".check_caption_type");
  var set_group_image_form = $("#set_group_image_form");

  check_caption_type.on("change", function() {
    var checked_value = $(".check_caption_type :checked").val();
    if (checked_value == "그룹설정") {
      alert("그룹설정 선택했습니다!");
    } else if (checked_value == "그룹분리") {
      alert("그룹분리 선택했습니다!");
    } else {
      alert("에러: 실패하였습니다!");
    }
  });
});
