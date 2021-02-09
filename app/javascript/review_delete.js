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

if (document.URL.match(/manuals/)) {
  if (!document.URL.match(/new/) && !document.URL.match(/edit/)){
    window.addEventListener("load", reviewDelete);
    setInterval(reviewDelete, 1000);
  };
};