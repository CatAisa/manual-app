function comment() {
  console.log("load");
  const submits = document.querySelectorAll(".comment-submit-btn");
  submits.forEach(function (submit) {
    submit.addEventListener("click", (e) => {
      e.preventDefault();
      console.log("click");
      const manualId = submit.getAttribute("manual_id");
      console.log(manualId);
      const procedureId = submit.getAttribute("procedure_id");
      console.log(procedureId);
      const formId = `form${procedureId}`;
      console.log(formId);
      const commentId = `comment${procedureId}`;
      console.log(commentId);
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
        console.log("onload");
      };
    });
  });
};

if ( document.URL.match(/manuals/) ){
  if ( !document.URL.match(/new/) && !document.URL.match(/edit/) ){
    window.addEventListener("load", comment);
  };
};