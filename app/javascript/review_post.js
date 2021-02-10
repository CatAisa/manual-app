function reviewPost() {
  const submitReview = document.getElementById("review-submit-btn");
  submitReview.addEventListener("click", (e) => {
    e.preventDefault();
    const manualId = submitReview.getAttribute("manual_id");
    const formData = new FormData(document.getElementById("review-form"));
    const XHR = new XMLHttpRequest();
    XHR.open("POST", `/manuals/${manualId}/reviews`, true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
        return null;
      };
      const review = XHR.response.review;
      const user = XHR.response.user;
      const list = document.getElementById("review-list");
      const reviewId = `${review.id}`;
      const formText = document.getElementById("review-text");
      const HTML = `
        <div class="review" style="" review_id=${review.id}>
          <div class="review-header">
            ${user.nickname}
            <span class="review-time">${review.created_at}</span>
            <a rel ="nofollow" data-method="delete" href="/manuals/${manualId}/reviews/${reviewId}" id="review-delete${review.id}">削除</a>
          </div>
          <div class="review-text">${review.content}</div>
        </div>`;
      list.insertAdjacentHTML("beforebegin", HTML);
      formText.value = "";
    };
  });
};

if (document.URL.match(/manuals/)) {
  if (!document.URL.match(/new/) && !document.URL.match(/edit/)){
    window.addEventListener("load", reviewPost);
  };
};