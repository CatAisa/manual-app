function commentDeleteTitle() {
  commentDelete('comment')
  commentDelete('review')
};

function commentDelete(type) {
  const models = document.querySelectorAll(`.${type}`);
  models.forEach(function(model) {
    const modelId = model.getAttribute(`${type}_id`);
    const deleteId = `${type}-delete${modelId}`;
    const deleteBtn = document.getElementById(deleteId);
    deleteBtn.addEventListener("click", () => {
      model.setAttribute("style", "display: none;");
    });
  });
};

if (document.URL.match(/manuals\/\d/) && !document.URL.match(/procedures/)) {
  if (!document.URL.match(/new/) && !document.URL.match(/edit/)) {
    window.addEventListener("load", commentDeleteTitle);
    setInterval(commentDeleteTitle, 1000);
  };
};