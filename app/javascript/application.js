// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false
import "controllers"
import "trix"


// On scroll change navbar colour

function changeNavColour() {
    var navbar = document.getElementById("full-nav");
    var dropdown1 = document.getElementById("dropdown-menu1");
    var dropdown2 = document.getElementById("dropdown-menu2");
    var dropdown3 = document.getElementById("dropdown-menu3");
    var sticky = navbar.offsetTop;
    // if y coordinate is more than location of navbar+30 pixels, then add sticky class to navbar
    if (window.pageYOffset > (sticky)) {
        navbar.classList.add("sticky");
        dropdown1.classList.add("sticky");
        dropdown2.classList.add("sticky");
        dropdown3.classList.add("sticky");
    } else {
        navbar.classList.remove("sticky");
        dropdown1.classList.remove("sticky");
        dropdown2.classList.remove("sticky");
        dropdown3.classList.remove("sticky");
    }
}

window.addEventListener("scroll", () => {
    changeNavColour();
});
