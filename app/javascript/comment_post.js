function commentPostTitle() {
  const submitCommentAll = document.querySelectorAll(".comment-submit-btn");
  submitCommentAll.forEach((submitComment) => {
    const manualId = submitComment.getAttribute("manual_id");
    const procedureId = submitComment.getAttribute("procedure_id");
    const path = `/manuals/${manualId}/procedures/${procedureId}/comments`;
    const type = 'comment';
    commentPost(submitComment, procedureId, path, type);
  });

  const submitReview = document.querySelector(".review-submit-btn");
  const manualId = submitReview.getAttribute("manual_id");
  const procedureId = '';
  const path = `/manuals/${manualId}/reviews`;
  const type = 'review';
  commentPost(submitReview, procedureId, path, type);
};

function commentPost(submit, procedureId, path, type) {
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

if (document.URL.match(/manuals\/\d/) && !document.URL.match(/procedures/)) {
  if (!document.URL.match(/new/) && !document.URL.match(/edit/)) {
    window.addEventListener("load", commentPostTitle);
  };
};