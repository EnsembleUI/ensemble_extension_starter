/*Abstract:
Script that runs after clicking the extension's toolbar button.
*/
function shareOnEnsemble()
{
    // Use optional permissions to request access to www.ensembleui.com.
    browser.permissions.request({origins: ['https://www.ensembleui.com/']}, (granted) => {
        if (granted) {
            // Share EnsembleExtension's info to ensembleui.com.
        }
    });
}

document.addEventListener("DOMContentLoaded", () => {
    document.getElementById("share").addEventListener("click", shareOnEnsemble);
});
