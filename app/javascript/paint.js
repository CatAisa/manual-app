function paintTitle() {
  console.log("loadPaint");

  const canvas = document.getElementById("canvas");
  const ctx = canvas.getContext("2d");

  // ペイント初期設定
  let clickFig = 0;
  let cnvColor = "0, 0, 0, 1";
  let cnvBold = 5;

  // 描画イベント
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

  // 描画処理
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
};

if ( document.URL.match(/procedures/) ) {
  window.addEventListener("load", paintTitle);
};