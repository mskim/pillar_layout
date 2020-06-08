import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [""];

  connect() {}

  select() {
    $("#myTab li:nth-child(5) a").tab("show")
  }
}
