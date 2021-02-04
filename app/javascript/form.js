function formTitle() {
  console.log("loadForm");

  const imageSave = document.getElementById("image-save");
  imageSave.addEventListener("click", () => {
    console.log("click");

    const imageForm = document.getElementById("image-form");
    const imageURL = canvas.toDataURL("image/png");

    imageForm.value = imageURL;
    console.log(imageForm.value);
  });
};

if ( document.URL.match(/procedures/) ) {
  window.addEventListener("load", formTitle);
};