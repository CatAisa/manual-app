function commentDeleteTitle() {
  commentDelete();
  reviewDelete();
};

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

function reviewDelete() {
  const reviews = document.querySelectorAll(".review");
  reviews.forEach(function(review) {
    const reviewId = review.getAttribute("review_id");
    const deleteId = `review-delete${reviewId}`;
    const deleteBtn = document.getElementById(deleteId);
    deleteBtn.addEventListener("click", () => {
      review.setAttribute("style", "display: none;");
    });
  });
};

if (document.URL.match(/manuals\/\d/) && !document.URL.match(/procedures/)) {
  if (!document.URL.match(/new/) && !document.URL.match(/edit/)) {
    window.addEventListener("load", commentDelete);
    setInterval(commentDeleteTitle, 1000);
  };
};