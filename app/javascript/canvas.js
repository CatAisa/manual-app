function canvasTitle() {
  console.log("load");

  fileField = document.getElementById("file-field");
  fileField.addEventListener("change", (e) => {
    console.log(e);

    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);

    const canvas = document.getElementById("canvas");
    const ctx = canvas.getContext("2d");
    const image = new Image();

    image.src = blob;
    image.onload = () => {
      const imageHeight = 480 / image.width * image.height;
      ctx.drawImage(image, 0, 0, 480, imageHeight);
    };
  });
};

if ( document.URL.match(/new/) ) {
  window.addEventListener("load", canvasTitle);
};