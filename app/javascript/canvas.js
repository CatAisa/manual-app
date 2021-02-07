function canvasTitle() {
  let clickFig = 0;
  let crw = 0;
  let crv = 0;
  let rw = 300;
  let rv = 300;

  // Input image
  const cnvCrop = document.getElementById("crop-canvas");
  const ctxCrop = cnvCrop.getContext("2d");
  const imgCrop = new Image();

  // Red border
  const cnvRed = document.getElementById("crop-area");
  const ctxRed = cnvRed.getContext("2d");
  const imgRed = new Image();

  // Output image
  const canvas = document.getElementById("canvas");
  const ctx = canvas.getContext("2d");
  const image = new Image();

  // Canvas size
  const cw = cnvCrop.width;
  const cv = cnvCrop.height;
  const ow = canvas.width;
  const ov = canvas.height;

  const fileField = document.getElementById("file-field");
  fileField.addEventListener("change", (e) => {
    ctxCrop.clearRect(0, 0, cw, cv);
    ctx.clearRect(0, 0, ow, ov);
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