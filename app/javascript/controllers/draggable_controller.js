import { Controller } from "stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["background", "comment", "commentIcon"];

  initialize() {
    this.makeDraggable();
    console.log(this.commentPencilTargets);
  }

  makeDraggable() {
    let svg = this.backgroundTarget;
    let comment_icons = this.commentIconTargets;

    svg.addEventListener("mousedown", startDrag);
    svg.addEventListener("mousemove", drag);
    svg.addEventListener("mouseup", endDrag);
    svg.addEventListener("mouseleave", endDrag);

    var selectedElement, offset, transform;

    function getMousePosition(evt) {
      var CTM = svg.getScreenCTM();
      return {
        x: (evt.clientX - CTM.e) / CTM.a,
        y: (evt.clientY - CTM.f) / CTM.d,
      };
    }

    function startDrag(evt) {
      if (evt.target.classList.contains("draggable")) {
        selectedElement = evt.target;
        offset = getMousePosition(evt);

        var transforms = selectedElement.transform.baseVal;

        if (selectedElement.hasAttribute("data-comment-id")) {
          offset.x -= parseFloat(selectedElement.getAttributeNS(null, "x"));
          offset.y -= parseFloat(selectedElement.getAttributeNS(null, "y"));
        } else if (selectedElement.hasAttribute("data-circle-id")) {
          offset.x -= parseFloat(selectedElement.getAttributeNS(null, "cx"));
          offset.y -= parseFloat(selectedElement.getAttributeNS(null, "cy"));
        } else if (selectedElement.hasAttribute("data-check-id")) {
          if (
            transforms.length === 0 ||
            transforms.getItem(0).type !== SVGTransform.SVG_TRANSFORM_TRANSLATE
          ) {
            // Create an transform that translates by (0, 0)
            var translate = svg.createSVGTransform();
            translate.setTranslate(0, 0);
            // Add the translation to the front of the transforms list
            selectedElement.transform.baseVal.insertItemBefore(translate, 0);
          }
          // Get initial translation amount
          transform = transforms.getItem(0);
          offset.x -= transform.matrix.e;
          offset.y -= transform.matrix.f;
        }
      }
    }

    function drag(evt) {
      if (selectedElement) {
        evt.preventDefault();
        var coord = getMousePosition(evt);

        if (selectedElement.hasAttribute("data-comment-id")) {
          // 선택된 요소를 드래그해서 위치변환
          selectedElement.setAttributeNS(null, "x", coord.x - offset.x);
          selectedElement.setAttributeNS(null, "y", coord.y - offset.y);
          // 선택된 요소를 이동시키면 그 안에 아이콘도 같이 따라오는 기능
        } else if (selectedElement.hasAttribute("data-circle-id")) {
          selectedElement.setAttributeNS(null, "cx", coord.x - offset.x);
          selectedElement.setAttributeNS(null, "cy", coord.y - offset.y);
        } else if (selectedElement.hasAttribute("data-check-id")) {
          transform.setTranslate(coord.x - offset.x, coord.y - offset.y);
          selectedElement.setAttribute(
            "transform",
            "translate(" +
              (coord.x - offset.x) +
              ", " +
              (coord.y - offset.y) +
              ")"
          );
        }

        comment_icons.forEach((icon) => {
          if (
            icon.hasAttribute("data-comment-id") &&
            icon.getAttribute("data-comment-id") ==
              selectedElement.getAttribute("data-comment-id")
          ) {
            let selectedElementX = parseFloat(
              selectedElement.getAttribute("x")
            );
            let selectedElementY = parseFloat(
              selectedElement.getAttribute("y")
            );
            let selectedElementW = parseFloat(
              selectedElement.getAttribute("width")
            );
            let selectedElementH = parseFloat(
              selectedElement.getAttribute("height")
            );
            let iconX = selectedElementX + selectedElementW / 2 - 5;
            let iconY = selectedElementY + selectedElementH / 2 - 5;
            icon.setAttribute(
              "transform",
              "translate(" + iconX + ", " + iconY + ")"
            );
          }
        });
      }
    }

    function endDrag(evt) {
      if (selectedElement) {
        // Ajax 업데이트
        let move_draggable_url = selectedElement.getAttribute(
          "data-move-draggable-url"
        );
        if (selectedElement.hasAttribute("data-comment-id")) {
          let new_x = parseFloat(selectedElement.getAttribute("x"));
          let new_y = parseFloat(selectedElement.getAttribute("y"));
          var formdata = new FormData();

          formdata.append("annotation_comment[x]", new_x);
          formdata.append("annotation_comment[y]", new_y);
        } else if (selectedElement.hasAttribute("data-circle-id")) {
          let new_x = parseFloat(selectedElement.getAttribute("cx"));
          let new_y = parseFloat(selectedElement.getAttribute("cy"));
          var formdata = new FormData();

          formdata.append("annotation_circle[x]", new_x);
          formdata.append("annotation_circle[y]", new_y);
        } else if (selectedElement.hasAttribute("data-check-id")) {
          let new_value = selectedElement
            .getAttribute("transform")
            .replace("translate(", "")
            .replace(")", "")
            .split(", ");
          let new_x = parseFloat(new_value[0]);
          let new_y = parseFloat(new_value[1]);
          console.log(new_x, new_y);
          var formdata = new FormData();

          formdata.append("annotation_check[x]", new_x);
          formdata.append("annotation_check[y]", new_y);
        }
        Rails.ajax({
          url: move_draggable_url,
          type: "PATCH",
          data: formdata,
        });

        // 완전 해제
        selectedElement = null;
      }
    }
  }
}
