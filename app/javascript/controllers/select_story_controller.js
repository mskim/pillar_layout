import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [""];

  connect() {}

  select() {
<<<<<<< HEAD
    $("#myTab li:nth-child(5) a").tab("show");
=======
    $("#myTab li:nth-child(5) a").tab("show")
>>>>>>> upstream/master
  }
}
