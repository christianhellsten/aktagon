const banner =
  "ICAgICAgICAgICAgIF8gICAgXwogICAgICAgICAgICB8IHwgIHwgfAogICAgICAgIF9fIF98IHwgX3wgfF8gX18gXyAgX18gXyAgX19fICBfIF9fICAgIF9fXyBfX18gIF8gX18gX19fCiAgICAgICAvIF9gIHwgfC8gLyBfXy8gX2AgfS8gX2AgfC8gXyBcfCAnXyBcICAvIF9fLyBfIFx8ICdfIGAgXyBcCiAgICAgIHwgKF98IHwgICA8fCB8fCAoX3wgfSAoX3wgfCAoXykgfCB8IHwgfHwgKF98IChfKSB8IHwgfCB8IHwgfAogICAgICAgXF9fLF98X3xcX1xcX19cX18sX3xcX18sIHxcX19fL3xffCB8XyhfKV9fX1xfX18vfF98IHxffCB8X3wKICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fLyB8CiAgICAgICAgICAgICAgICAgICAgICAgICAgIHxfX18vCg==";

// Unicode-safe decode for browsers
function decodeBase64Unicode(str) {
  // atob() returns a binary string in which each character's code point
  // equals a byte of the decoded data.
  const binStr = atob(str);
  // Percent-encode each byte, then decode via decodeURIComponent
  const pctEncoded = Array.prototype.map
    .call(binStr, (ch) => "%" + ch.charCodeAt(0).toString(16).padStart(2, "0"))
    .join("");
  return decodeURIComponent(pctEncoded);
}

console.debug(decodeBase64Unicode(banner));

function toggleAnimation() {
  document
    .querySelectorAll(".t3d-viewport")
    .forEach((el) => el.classList.toggle("is-3d-exploded"));
}

// Animate
window.addEventListener("load", () => {
  setTimeout(() => {
    toggleAnimation();
  }, 1000);
});

function toggleGrid() {
  document.body.classList.toggle("show-grid");
}

function toggleMobileNav() {
  const mobileNav = document.getElementById("mobile-nav");
  const toggle = document.querySelector(".mobile-nav-toggle");
  const hamburgerLines = toggle.querySelectorAll(".hamburger-line");

  mobileNav.classList.toggle("active");

  // Animate hamburger to X
  if (mobileNav.classList.contains("active")) {
    hamburgerLines[0].style.transform = "rotate(45deg) translate(5px, 5px)";
    hamburgerLines[1].style.opacity = "0";
    hamburgerLines[2].style.transform = "rotate(-45deg) translate(7px, -6px)";
  } else {
    hamburgerLines[0].style.transform = "none";
    hamburgerLines[1].style.opacity = "1";
    hamburgerLines[2].style.transform = "none";
  }
}

