import Baz from "dash_modal/baz.js"
const Baz2 = require('dash_modal/baz.js');

console.log("bar.js");
var bar = () => {
  console.log("bar function");
}
console.log(Baz);
console.log(Baz2.default);
bar()
