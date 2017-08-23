// Import our stylesheets
import "./style/main.less"

// Import any vendor stylesheets here
// --> HERE <--

// Require main
const Elm = require("./Main.elm");

window.addEventListener("load", function() {
    // Fetch the Elm div element that will serve as the container for elm
    const elmDiv = document.getElementById("elm");
    
    // Embed the application
    const app = Elm.Main.embed(elmDiv);
})
