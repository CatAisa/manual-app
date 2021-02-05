function canvasTitle() {
  console.log("loadCanvas");

  const canvas = document.getElementById("canvas");
  const ctx = canvas.getContext("2d");
  const image = new Image();

  fileField = document.getElementById("file-field");
  fileField.addEventListener("change", (e) => {
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);

    image.src = blob;
    image.onload = () => {
      const imageHeight = 480 / image.width * image.height;
      ctx.drawImage(image, 0, 0, 480, imageHeight);
    };
  });
};

if (document.URL.match(/procedures/)) {
  window.addEventListener("load", canvasTitle);
};