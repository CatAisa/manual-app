function formTitle() {
  console.log("form");
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

if (document.URL.match(/procedures/) || document.URL.match(/edit/)) {
  window.addEventListener("load", formTitle);
};

if (document.URL.match(/manuals/) && !document.URL.match(/manuals\/\d/)) {
  window.addEventListener("load", formTitle);
};