require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  scenario "タスク一覧のテスト" do
    Task.create!(title: 'test_task_01', content: 'testtesttest')
    Task.create!(title: 'test_task_02', content: 'samppletest')

    visit "/"

    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samppletest'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in "Title", with: "maybete"
    fill_in "Content", with: "maybetest"
    click_on "Create Task"

    expect(page).to have_content 'maybetest'
  end

  scenario "タスク詳細のテスト" do

  end
end
