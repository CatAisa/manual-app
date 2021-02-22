module ReviewSupport
  def review_delete(manual, review)
    # レビューに削除ボタンが存在する
    expect(page).to have_link('削除', href: manual_review_path(manual, review))
    # 削除ボタンをクリックすると、Reviewモデルのカウントが1減少する
    sleep 1
    expect {
      find_link('削除', href: manual_review_path(manual, review)).click
      sleep 1
    }.to change { Review.count }.by(-1)
    # マニュアル詳細ページから移動しない
    expect(current_path).to eq(manual_path(manual))
    # 先ほど削除したレビューの情報が存在しない
    expect(page).to have_no_content(review.content)
  end
end