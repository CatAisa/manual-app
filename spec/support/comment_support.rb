module CommentSupport
  def comment_delete(manual, procedure, comment)
    # コメントに削除ボタンが存在する
    expect(page).to have_link('削除', href: manual_procedure_comment_path(manual, procedure, comment))
    # 削除ボタンをクリックすると、Commentモデルのカウントが1減少する
    sleep 1
    expect {
      find_link('削除', href: manual_procedure_comment_path(manual, procedure, comment)).click
      sleep 1
    }.to change { Comment.count }.by(-1)
    # マニュアル詳細ページから移動しない
    expect(current_path).to eq(manual_path(manual))
    # 先ほど削除したコメントの情報が存在しない
    expect(page).to have_no_content(comment.content)
  end
end