console.log("Hello World!", browser);

document.addEventListener("DOMContentLoaded", () => {
    document.getElementById("appleWebsiteButton").addEventListener("click", openAppleWebsite);
    document.getElementById("printTokenButton").addEventListener("click", printToken);
});

function openAppleWebsite() {
    console.log("Open Apple method called");
    window.open("https://www.apple.com/", "_blank");
}

function printToken() {
    console.log("printToken method called");
    browser.runtime.sendMessage({type: "tokenExchange"});
}
