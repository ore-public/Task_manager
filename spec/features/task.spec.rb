require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do

  background do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end


  scenario "タスク一覧のテスト" do
    visit "/"

    expect(page).to have_content 'コンテント１'
    expect(page).to have_content 'コンテント２'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in "タスク名", with: "maybete"
    fill_in "タスク詳細", with: "maybetest"
    click_on "登録する"

    expect(page).to have_content 'maybete'
  end

  scenario "タスク詳細のテスト" do
    visit @task

    expect(page).to have_content 'コンテント１'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit "/"
    expect(all(:css, '.task_content')[0]).to have_content 'コンテント２'
    expect(all(:css, '.task_content')[1]).to have_content 'コンテント１'
  end
end
