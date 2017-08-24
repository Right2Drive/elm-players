// Import our stylesheets
import "./style/main.less"

// Import any vendor stylesheets here
import "ace-css/css/ace.css";
import "font-awesome/css/font-awesome.css";

// Require main
const Elm = require("./elm/Main.elm");

window.addEventListener("load", function() {
    // Fetch the Elm div element that will serve as the container for elm
    const elmDiv = document.getElementById("elm");
    
    // Embed the application
    const app = Elm.Main.embed(elmDiv);
})
