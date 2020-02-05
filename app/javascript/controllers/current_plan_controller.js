import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [];

  all_save(event) {
    event.presentDefault();
    console.log("클릭");
  }
}
