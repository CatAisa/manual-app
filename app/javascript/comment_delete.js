function commentDelete() {
  const comments = document.querySelectorAll(".comment");
  comments.forEach(function(comment) {
    const commentId = comment.getAttribute("comment_id");
    const deleteId = `comment-delete${commentId}`;
    const deleteBtn = document.getElementById(deleteId);
    deleteBtn.addEventListener("click", () => {
      comment.setAttribute("style", "display: none;");
    });
  });
};

if (document.URL.match(/manuals\/\d/) && !document.URL.match(/procedures/)) {
  if (!document.URL.match(/new/) && !document.URL.match(/edit/)) {
    window.addEventListener("load", commentDelete);
    setInterval(commentDelete, 1000);
  };
};