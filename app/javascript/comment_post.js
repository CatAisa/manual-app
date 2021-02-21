function commentPostTitle() {
  const submitCommentAll = document.querySelectorAll(".comment-submit-btn");
  submitCommentAll.forEach((submitComment) => {
    const manualId = submitComment.getAttribute("manual_id");
    const procedureId = submitComment.getAttribute("procedure_id");
    const path = `/manuals/${manualId}/procedures/${procedureId}/comments`
    const type = 'comment'
    commentPostTest(submitComment, procedureId, path, type);
  });
  // commentPost();
  reviewPost();
};

function commentPostTest(submit, procedureId, path, type) {
  submit.addEventListener("click", (e) => {
    e.preventDefault();
    const formId = `${type}-form${procedureId}`;
    const textId = `${type}-text${procedureId}`;
    const formData = new FormData(document.getElementById(formId));
    const XHR = new XMLHttpRequest();
    XHR.open("POST", path, true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
        return null;
      };
      const model = XHR.response.model;
      const user = XHR.response.user;
      const listId = `${type}-list${procedureId}`;
      const list = document.getElementById(listId);
      const modelId = `${model.id}`;
      const formText = document.getElementById(textId);
      const HTML = `
        <div class="${type}" style="" ${type}_id=${model.id}>
          <div class="${type}-header">
            ${user.nickname}
            <span class="${type}-time">${model.created_at}</span>
            <a rel ="nofollow" data-method="delete" href="${path}/${modelId}" id="${type}-delete${model.id}">削除</a>
          </div>
          <div class="${type}-text">${model.content}</div>
        </div>`;
      list.insertAdjacentHTML("beforebegin", HTML);
      formText.value = "";
    };
  });
};

function commentPost() {
  const submits = document.querySelectorAll(".comment-submit-btn");
  submits.forEach(function(submit) {
    submit.addEventListener("click", (e) => {
      e.preventDefault();
      const manualId = submit.getAttribute("manual_id");
      const procedureId = submit.getAttribute("procedure_id");
      const formId = `comment-form${procedureId}`;
      const textId = `comment-text${procedureId}`;
      const formData = new FormData(document.getElementById(formId));
      const XHR = new XMLHttpRequest();
      XHR.open("POST", `/manuals/${manualId}/procedures/${procedureId}/comments`, true);
      XHR.responseType = "json";
      XHR.send(formData);
      XHR.onload = () => {
        if (XHR.status != 200) {
          alert(`Error ${XHR.status}: ${XHR.statusText}`);
          return null;
        };
        const comment = XHR.response.comment;
        const user = XHR.response.user;
        const listId = `list${procedureId}`;
        const list = document.getElementById(listId);
        const commentId = `${comment.id}`;
        const formText = document.getElementById(textId);
        const HTML = `
          <div class="comment" style="" comment_id=${comment.id}>
            <div class="comment-header">
              ${user.nickname}
              <span class="comment-time">${comment.created_at}</span>
              <a rel ="nofollow" data-method="delete" href="/manuals/${manualId}/procedures/${procedureId}/comments/${commentId}" id="comment-delete${comment.id}">削除</a>
            </div>
            <div class="comment-text">${comment.content}</div>
          </div>`;
        list.insertAdjacentHTML("beforebegin", HTML);
        formText.value = "";
      };
    });
  });
};

function reviewPost() {
  const submitReview = document.querySelector(".review-submit-btn");
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

if (document.URL.match(/manuals\/\d/) && !document.URL.match(/procedures/)) {
  if (!document.URL.match(/new/) && !document.URL.match(/edit/)) {
    window.addEventListener("load", commentPostTitle);
  };
};