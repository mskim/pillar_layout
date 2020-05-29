import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["editStoryTab"];

  connect() {}

  select() {
    this.editStoryTabTarget.click();
  }

  event() {
    console.log("이벤트 발동!");
  }
}
