function canvasTitle() {
  console.log("canvas");
  let clickFig = 0;
  let crw = 0;
  let crv = 0;
  let rw = 300;
  let rv = 300;
  let blob = ""

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
    if (file != undefined) {
      blob = window.URL.createObjectURL(file);
    };
    cropper(blob);
  });

  function cropper(blob) {
    image.src = blob;
    image.onload = () => {
      const iw = image.width;
      const iv = image.height;
      const apCrop = cw / iw;
      const ap = ow / iw;
      ctxCrop.drawImage(image, 0, 0, cw, apCrop*iv);
      ctx.drawImage(image, 0, 0, ow, ap*iv);

      cnvRed.addEventListener("mousedown", (e) => {
        clickFig = 1;
        crw = e.offsetX;
        crv = e.offsetY;
        drawRed(crw, crv);
        drawCanvas(crw, crv);
      });
      cnvRed.addEventListener("mouseup", () => {
        clickFig = 0;
      });
      cnvRed.addEventListener("mousemove", (e) => {
        if (!clickFig == 1) {
          return false;
        };
        crw = e.offsetX;
        crv = e.offsetY;
        drawRed(crw, crv);
        drawCanvas(crw, crv);
      });

      function drawRed(crw, crv) {
        imgRed.src = blob;
        if (clickFig == 1) {
          ctxRed.clearRect(0, 0, cw, cv);
          imgRed.onload = () => {
            ctxRed.strokeStyle = "rgba(200, 0, 0, 0.8)";
            ctxRed.strokeRect(crw-rw/2, crv-rv/2, rw, rv);
          };
        };
      };

      function drawCanvas(crw, crv) {
        ctx.clearRect(0, 0, ow, ov);
        image.src = blob;
        image.onload = () => {
          ctx.drawImage(image, (crw-rw/2)/apCrop, (crv-rv/2)/apCrop, rw/apCrop, rv/apCrop, 0, 0, ow, ov);
        };
      };
    };
  };

  // Change crop size
  const cropSize = document.querySelectorAll(".crop-size");
  cropSize.forEach((f) => {
    f.addEventListener("click", (e) => {
      e.preventDefault();
      rw = f.getAttribute("data-size");
      rv = f.getAttribute("data-size");
    });
  });
};

if (document.URL.match(/manuals/)) {
  if (document.URL.match(/procedures/) || document.URL.match(/edit/)) {
    window.addEventListener("load", canvasTitle);
  } else if (!document.URL.match(/manuals\/\d/)) {
    window.addEventListener("load", canvasTitle);
  };
};