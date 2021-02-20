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

if (document.URL.match(/manuals\/\d/) && !document.URL.match(/procedures/)) {
  if (!document.URL.match(/new/) && !document.URL.match(/edit/)) {
    window.addEventListener("load", commentPost);
  };
};