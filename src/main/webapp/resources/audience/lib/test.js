const body = document.querySelector('body'),
    sidebar = body.querySelector('nav'),
    toggle = body.querySelector(".toggle"),
    searchBtn = body.querySelector(".card-box"),
    modeSwitch = body.querySelector(".toggle-switch"),
    modeText = body.querySelector(".mode-text");

const viewMode = sidebar.querySelector(".features").querySelector(".fa-th");

let isShow = true;

toggle.addEventListener("click", () => {
    sidebar.classList.toggle("close");
    toggle.classList.remove(`fa-chevron-${isShow ? 'left' : 'right'}`);
    toggle.classList.add(`fa-chevron-${isShow ? 'right' : 'left'}`);
    isShow = !isShow;
})

searchBtn.addEventListener("click", () => {
    sidebar.classList.remove("close");
})

modeSwitch.addEventListener("click", () => {
    body.classList.toggle("dark");

    // if (body.classList.contains("dark")) {
    //     modeText.innerText = "Light mode";
    // } else {
    //     modeText.innerText = "Dark mode";
    // }
});