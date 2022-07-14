// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false
import "controllers"
import "trix"
import "@rails/actiontext"

// On scroll change navbar colour

function changeNavColour() {
    var navbar = document.getElementById("full-nav");
    var sticky = navbar.offsetTop;
    // if y coordinate is more than location of navbar+30 pixels, then add sticky class to navbar
    if (window.pageYOffset > (sticky)) {
        navbar.classList.add("sticky")
    } else {
        navbar.classList.remove("sticky");
    }
}

window.addEventListener("scroll", () => {
    changeNavColour();
});
