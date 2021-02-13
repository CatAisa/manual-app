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

if (document.URL.match(/manuals/)) {
  if (document.URL.match(/procedures/) || document.URL.match(/edit/)) {
    window.addEventListener("load", formTitle);
  } else if (!document.URL.match(/manuals\/\d/)) {
    window.addEventListener("load", formTitle);
  };
};