function canvasTitle() {
  console.log("load");

  const canvas = document.getElementById("canvas");
  const ctx = canvas.getContext("2d");
  const image = new Image();
  
  image.src = "/images//test_image.jpg";
  image.onload = () => {
    ctx.drawImage(image, 0, 0, 500, 500/image.width*image.height);
  }
};

if ( document.URL.match(/new/) ) {
  window.addEventListener("load", canvasTitle);
};