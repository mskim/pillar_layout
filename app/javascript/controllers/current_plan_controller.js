import { Controller } from "stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["form", "section_name", "ad_type", "advertiser"];

  all_save() {
    let forms = this.formTargets;
    let section_names = this.section_nameTargets;
    let ad_types = this.ad_typeTargets;
    let advertisers = this.advertiserTargets;

    // setTimeout(() => {
    //   Rails.fire(this.formTarget, "submit");
    // });
    forms.forEach((form) => {
      Rails.fire(form, "submit");
    });

    // let data = new FormData();

    // section_names.forEach((section_name) => {
    //   let id = section_name.closest("tr").getAttribute("data-page-plan-id");
    //   data.append("page_plan[section_name]", section_name.value);
    //   Rails.ajax({
    //     url: "/page_plans/:id/update_section_name".replace(":id", id),
    //     type: "PATCH",
    //     data: data,
    //   });
    // });

    // ad_types.forEach((ad_type) => {
    //   let id = ad_type.closest("tr").getAttribute("data-page-plan-id");
    //   data.append("page_plan[ad_type]", ad_type.value);
    //   Rails.ajax({
    //     url: "/page_plans/:id/update_ad_type".replace(":id", id),
    //     type: "PATCH",
    //     data: data,
    //   });
    // });

    // advertisers.forEach((advertiser) => {
    //   let id = advertiser.closest("tr").getAttribute("data-page-plan-id");
    //   data.append("page_plan[advertiser]", advertiser.value);
    //   Rails.ajax({
    //     url: "/page_plans/:id/update_advertiser".replace(":id", id),
    //     type: "PATCH",
    //     data: data,
    //   });
    // });
  }

  changeBG(e) {
    let tr = e.target.closest("tr");
    let id = tr.getAttribute("data-page-plan-id");

    if (tr.classList.contains("bg-pink")) {
      tr.classList.remove("bg-pink");
      tr.classList.add("bg-white");
    } else {
      tr.classList.remove("bg-white");
      tr.classList.add("bg-pink");
    }

    let data = new FormData();
    data.append("page_plan[color_page]", e.target.checked);
    Rails.ajax({
      url: "/page_plans/:id/update_color".replace(":id", id),
      type: "PATCH",
      data: data,
    });
  }
}
