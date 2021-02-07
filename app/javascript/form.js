function formTitle() {
  const imageSave = document.getElementById("image-save");
  imageSave.addEventListener("click", () => {
    const canvas = document.getElementById("canvas");
    const imageForm = document.getElementById("image-form");
    const imageURL = canvas.toDataURL("image/png");

    imageForm.value = imageURL;

    const savedMessage = document.getElementById("saved-message");
    savedMessage.setAttribute("style", "display: inline-block;");
  });
};

if (document.URL.match(/procedures/)) {
  window.addEventListener("load", formTitle);
};