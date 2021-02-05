function drawingTitle() {
  console.log("loadPaint");

  const canvas = document.getElementById("canvas");
  const ctx = canvas.getContext("2d");

  // Initial setting of drawing
  let clickFig = 0;
  let cnvColor = "0, 0, 0, 1";
  let cnvBold = 5;

  // Drawing event
  canvas.addEventListener("mousedown", () => {
    clickFig = 1;
  });
  canvas.addEventListener("mouseup", () => {
    clickFig = 0;
  });
  canvas.addEventListener("mousemove", (e) => {
    if (!clickFig) {
      return false;
    };
    draw(e.offsetX, e.offsetY);
  });

  // Drawing processing
  function draw(x, y) {
    ctx.strokeStyle = `rgba(${cnvColor})`;
    ctx.lineWidth = cnvBold;

    if (clickFig == 1) {
      clickFig = 2;
      ctx.beginPath();
      ctx.lineCap = "round";
      ctx.moveTo(x, y);
    }else {
      ctx.lineTo(x, y);
    };
    ctx.stroke();
  };

  // Change color
  const fontColor = document.querySelectorAll(".color a");
  fontColor.forEach((f) => {
    f.addEventListener("click", (e) => {
      e.preventDefault();
      cnvColor = f.getAttribute("data-color");
      return false;
    });
  });

  // Change bold
  const fontBold = document.querySelectorAll(".bold a");
  fontBold.forEach((f) => {
    f.addEventListener("click", (e) => {
      e.preventDefault();
      cnvBold = f.getAttribute("data-bold");
      return false;
    });
  });
};

if (document.URL.match(/procedures/)) {
  window.addEventListener("load", drawingTitle);
};