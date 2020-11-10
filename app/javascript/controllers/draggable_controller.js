import { Controller } from "stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = [
    "background",
    "comment",
    "commentIcon",
    "closeIcon",
    "mask",
    "avatar",
  ];

  initialize() {
    this.makeDraggable();
  }

  makeDraggable() {
    let svg = this.backgroundTarget;
    let comment_icons = this.commentIconTargets;
    let close_icons = this.closeIconTargets;
    // mask & avatar 같은 그룹
    let masks = this.maskTargets;
    let avatars = this.avatarTargets;
    let current_user_id = this.current_user_id;

    svg.addEventListener("mousedown", startDrag);
    svg.addEventListener("mousemove", drag);
    svg.addEventListener("mouseup", endDrag);
    svg.addEventListener("mouseleave", endDrag);

    var selectedElement, offset, transform;

    close_icons.forEach((icon) => {
      if (icon.getAttribute("data-user-id") != current_user_id) {
        icon.classList.add("none-display");
      }
    });

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
        } else if (selectedElement.hasAttribute("data-remove-marker-id")) {
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
        } else if (selectedElement.hasAttribute("data-underline-id")) {
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
        // 선택된 요소의 변수
        if (
          selectedElement.hasAttribute("x") ||
          selectedElement.hasAttribute("y")
        ) {
          var selectedElementX = parseFloat(selectedElement.getAttribute("x"));
          var selectedElementY = parseFloat(selectedElement.getAttribute("y"));
        } else if (
          selectedElement.hasAttribute("cx") ||
          selectedElement.hasAttribute("cy")
        ) {
          var selectedElementCX = parseFloat(
            selectedElement.getAttribute("cx")
          );
          var selectedElementCY = parseFloat(
            selectedElement.getAttribute("cy")
          );
        }
        let selectedElementW = parseFloat(
          selectedElement.getAttribute("width")
        );
        let selectedElementH = parseFloat(
          selectedElement.getAttribute("height")
        );

        if (
          selectedElement.hasAttribute("data-comment-id") &&
          selectedElement.getAttribute("data-user-id") == current_user_id
        ) {
          // 선택된 요소를 드래그해서 위치변환
          selectedElement.setAttributeNS(null, "x", coord.x - offset.x);
          selectedElement.setAttributeNS(null, "y", coord.y - offset.y);
        } else if (
          selectedElement.hasAttribute("data-circle-id") &&
          selectedElement.getAttribute("data-user-id") == current_user_id
        ) {
          selectedElement.setAttributeNS(null, "cx", coord.x - offset.x);
          selectedElement.setAttributeNS(null, "cy", coord.y - offset.y);
        } else if (
          selectedElement.hasAttribute("data-check-id") &&
          selectedElement.getAttribute("data-user-id") == current_user_id
        ) {
          transform.setTranslate(coord.x - offset.x, coord.y - offset.y);
          selectedElement.setAttribute(
            "transform",
            "translate(" +
              (coord.x - offset.x) +
              ", " +
              (coord.y - offset.y) +
              ")"
          );
        } else if (
          selectedElement.hasAttribute("data-underline-id") &&
          selectedElement.getAttribute("data-user-id") == current_user_id
        ) {
          transform.setTranslate(coord.x - offset.x, coord.y - offset.y);
          selectedElement.setAttribute(
            "transform",
            "translate(" +
              (coord.x - offset.x) +
              ", " +
              (coord.y - offset.y) +
              ")"
          );
        } else if (
          selectedElement.hasAttribute("data-remove-marker-id") &&
          selectedElement.getAttribute("data-user-id") == current_user_id
        ) {
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

        // 연필 아이콘
        comment_icons.forEach((icon) => {
          if (
            icon.hasAttribute("data-comment-id") &&
            icon.getAttribute("data-comment-id") ==
              selectedElement.getAttribute("data-comment-id")
          ) {
            let iconX = selectedElementX + selectedElementW / 2 - 5;
            let iconY = selectedElementY + selectedElementH / 2 - 5;
            icon.setAttribute(
              "transform",
              "translate(" + iconX + ", " + iconY + ")"
            );
          }
        });

        // 마스크 & 아바타
        masks.forEach((mask) => {
          if (
            mask.hasAttribute("data-comment-id") &&
            mask.getAttribute("data-comment-id") ==
              selectedElement.getAttribute("data-comment-id")
          ) {
            mask.setAttribute("cx", selectedElementX + 55);
            mask.setAttribute("cy", selectedElementY - 5);
          } else if (
            mask.hasAttribute("data-check-id") &&
            mask.getAttribute("data-check-id") ==
              selectedElement.getAttribute("data-check-id")
          ) {
            let new_value = selectedElement
              .getAttribute("transform")
              .replace("translate(", "")
              .replace(")", "")
              .split(", ");
            let new_x = parseFloat(new_value[0]);
            let new_y = parseFloat(new_value[1]);
            mask.setAttribute("cx", new_x + 25);
            mask.setAttribute("cy", new_y - 10);
          } else if (
            mask.hasAttribute("data-circle-id") &&
            mask.getAttribute("data-circle-id") ==
              selectedElement.getAttribute("data-circle-id")
          ) {
            mask.setAttribute("cx", selectedElementCX + 25);
            mask.setAttribute("cy", selectedElementCY - 25);
          }
        });
        avatars.forEach((avatar) => {
          if (
            avatar.hasAttribute("data-comment-id") &&
            avatar.getAttribute("data-comment-id") ==
              selectedElement.getAttribute("data-comment-id")
          ) {
            avatar.setAttribute("x", selectedElementX + 45);
            avatar.setAttribute("y", selectedElementY - 15);
          } else if (
            avatar.hasAttribute("data-check-id") &&
            avatar.getAttribute("data-check-id") ==
              selectedElement.getAttribute("data-check-id")
          ) {
            let new_value = selectedElement
              .getAttribute("transform")
              .replace("translate(", "")
              .replace(")", "")
              .split(", ");
            let new_x = parseFloat(new_value[0]);
            let new_y = parseFloat(new_value[1]);
            avatar.setAttribute("x", new_x + 15);
            avatar.setAttribute("y", new_y - 20);
          } else if (
            avatar.hasAttribute("data-circle-id") &&
            avatar.getAttribute("data-circle-id") ==
              selectedElement.getAttribute("data-circle-id")
          ) {
            avatar.setAttribute("x", selectedElementCX + 15);
            avatar.setAttribute("y", selectedElementCY - 35);
          }
        });

        // 닫기 아이콘
        close_icons.forEach((icon) => {
          if (
            icon.hasAttribute("data-comment-id") &&
            icon.getAttribute("data-comment-id") ==
              selectedElement.getAttribute("data-comment-id")
          ) {
            let iconX = selectedElementX - 4;
            let iconY = selectedElementY - 4;
            icon.setAttribute(
              "transform",
              "translate(" + iconX + ", " + iconY + ")"
            );
          } else if (
            icon.hasAttribute("data-check-id") &&
            icon.getAttribute("data-check-id") ==
              selectedElement.getAttribute("data-check-id")
          ) {
            transform.setTranslate(coord.x - offset.x, coord.y - offset.y);
            selectedElement.setAttribute(
              "transform",
              "translate(" +
                (coord.x - offset.x) +
                ", " +
                (coord.y - offset.y) +
                ")"
            );
            icon.setAttribute(
              "transform",
              "translate(" +
                (coord.x - offset.x - 4) +
                ", " +
                (coord.y - offset.y - 4) +
                ")"
            );
          } else if (
            icon.hasAttribute("data-circle-id") &&
            icon.getAttribute("data-circle-id") ==
              selectedElement.getAttribute("data-circle-id")
          ) {
            let iconX = selectedElementCX - 24;
            let iconY = selectedElementCY - 24;
            icon.setAttribute(
              "transform",
              "translate(" + iconX + ", " + iconY + ")"
            );
          } else if (
            icon.hasAttribute("data-underline-id") &&
            icon.getAttribute("data-underline-id") ==
              selectedElement.getAttribute("data-underline-id")
          ) {
            transform.setTranslate(coord.x - offset.x, coord.y - offset.y);
            icon.setAttribute(
              "transform",
              "translate(" +
                (coord.x - offset.x - 8) +
                ", " +
                (coord.y - offset.y - 8) +
                ")"
            );
          } else if (
            icon.hasAttribute("data-remove-marker-id") &&
            icon.getAttribute("data-remove-marker-id") ==
              selectedElement.getAttribute("data-remove-marker-id")
          ) {
            transform.setTranslate(coord.x - offset.x, coord.y - offset.y);
            selectedElement.setAttribute(
              "transform",
              "translate(" +
                (coord.x - offset.x) +
                ", " +
                (coord.y - offset.y) +
                ")"
            );
            icon.setAttribute(
              "transform",
              "translate(" +
                (coord.x - offset.x - 5) +
                ", " +
                (coord.y - offset.y - 5) +
                ")"
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
          var formdata = new FormData();

          formdata.append("annotation_check[x]", new_x);
          formdata.append("annotation_check[y]", new_y);
        } else if (selectedElement.hasAttribute("data-underline-id")) {
          let new_value = selectedElement
            .getAttribute("transform")
            .replace("translate(", "")
            .replace(")", "")
            .split(" ");

          let new_x = parseFloat(new_value[0]);
          let new_y = parseFloat(new_value[1]);
          console.log(new_value);
          var formdata = new FormData();

          formdata.append("annotation_underline[x]", new_x);
          formdata.append("annotation_underline[y]", new_y);
        } else if (selectedElement.hasAttribute("data-remove-marker-id")) {
          let new_value = selectedElement
            .getAttribute("transform")
            .replace("translate(", "")
            .replace(")", "")
            .split(", ");
          let new_x = parseFloat(new_value[0]);
          let new_y = parseFloat(new_value[1]);

          var formdata = new FormData();

          formdata.append("annotation_remove[x]", new_x);
          formdata.append("annotation_remove[y]", new_y);
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

  get current_user_id() {
    return parseInt(this.data.get("current-user-id"));
  }
}
