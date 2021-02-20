module ProcedureSupport
  def input_procedure_true(title, text)
    fill_in 'procedure_title', with: title
    fill_in 'procedure_description', with: text
  end

  def check_procedure(title, description)
    expect(page).to have_content(title)
    expect(page).to have_selector('img')
    expect(page).to have_content(description)
  end

  def check_no_procedure(title, description)
    expect(page).to have_no_content(title)
    expect(page).to have_no_content(description)
  end
end