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
    fill_in "タスク名", with: "maybete"
    fill_in "タスク詳細", with: "maybetest"
    click_on "登録する"

    expect(page).to have_content 'maybete'
  end

  scenario "タスク詳細のテスト" do
    Task.create!(title: 'test_task_01', content: 'testtesttest')

    visit @task

    expect(page).to have_content 'testtesttest'
  end
end
