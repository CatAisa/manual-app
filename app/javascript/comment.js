function commentTitle() {
  const submits = document.querySelectorAll(".comment-submit-btn");
  submits.forEach(function (submit) {
    submit.addEventListener("click", (e) => {
      e.preventDefault();
      const manualId = submit.getAttribute("manual_id");
      const procedureId = submit.getAttribute("procedure_id");
      const formId = `form${procedureId}`;
      const commentId = `comment${procedureId}`;
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
        const formText = document.getElementById(commentId);
        const HTML = `
          <div class="procedure-comment">
            <div class="pro-comment-header">
              ${user.nickname}
              <span class="comment-time">${comment.created_at}</span>
            </div>
            <div class="pro-comment-text">${comment.content}</div>
          </div>`;
        list.insertAdjacentHTML("beforebegin", HTML);
        formText.value = "";
      };
    });
  });
};

if ( document.URL.match(/manuals/) ){
  if ( !document.URL.match(/new/) && !document.URL.match(/edit/) ){
    window.addEventListener("load", commentTitle);
  };
};