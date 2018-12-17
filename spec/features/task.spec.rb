require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do

  background do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:task3)
    FactoryBot.create(:task4)
    FactoryBot.create(:task5)
  end
  
  scenario "タスク一覧のテスト" do
    visit "/"

    expect(page).to have_content 'コンテント１'
    expect(page).to have_content 'コンテント２'
    expect(page).to have_content 'コンテント３'
    expect(page).to have_content 'コンテント４'
    expect(page).to have_content 'コンテント５'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in "タスク名", with: "maybete"
    fill_in "タスク詳細", with: "maybetest"
    select "2020", from: "task_deadline_1i"
    click_on "登録する"

    expect(page).to have_content 'maybete'
    expect(page).to have_content '未着手'
    expect(page).to have_content 'low'
  end

  scenario "タスク詳細のテスト" do
    visit @task

    expect(page).to have_content 'コンテント１'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit "/"
    expect(all(:css, '.task_content')[0]).to have_content 'コンテント５'
    expect(all(:css, '.task_content')[1]).to have_content 'コンテント４'
    expect(all(:css, '.task_content')[2]).to have_content 'コンテント３'
    expect(all(:css, '.task_content')[3]).to have_content 'コンテント２'
    expect(all(:css, '.task_content')[4]).to have_content 'コンテント１'
  end

  scenario "終了期日降順ボタンが正常機能しているかのテスト" do
    visit root_path
    find("option[value='期日降順']").select_option
    click_on "Search"
    expect(all(:css, '.task_content')[0]).to have_content 'コンテント２'
    expect(all(:css, '.task_content')[1]).to have_content 'コンテント１'
    expect(all(:css, '.task_content')[2]).to have_content 'コンテント３'
    expect(all(:css, '.task_content')[3]).to have_content 'コンテント４'
    expect(all(:css, '.task_content')[4]).to have_content 'コンテント５'
  end

  scenario "タイトル検索が正常に機能しているかテスト" do
    visit root_path
    fill_in "task[search]", with: "タイトル２"
    click_on "Search"
    expect(all(:css, '.task_content')[0]).to have_content 'コンテント２'
  end

  scenario "ステータス絞り込みが正常に機能しているかテスト" do
    visit root_path
    find("option[value='着手中']").select_option
    click_on "Search"
    expect(all(:css, '.task_content')[0]).to have_content 'コンテント５'
    expect(all(:css, '.task_content')[1]).to have_content 'コンテント１'
  end

  scenario "優先度絞り込みが正常に機能しているかテスト" do
    visit root_path
    select 'high', from: "task[priority]"
    click_on "Search"
    expect(all(:css, '.task_content')[0]).to have_content 'コンテント３'
    expect(all(:css, '.task_content')[1]).to have_content 'コンテント１'
  end

  scenario "優先度順ソートが正常に機能しているかテスト" do
    visit root_path
    select '優先度順', from: "task[priority_s]"
    click_on "Search"
    expect(all(:css, '.task_content')[0]).to have_content 'コンテント３'
    expect(all(:css, '.task_content')[1]).to have_content 'コンテント１'
    expect(all(:css, '.task_content')[2]).to have_content 'コンテント４'
    expect(all(:css, '.task_content')[3]).to have_content 'コンテント２'
    expect(all(:css, '.task_content')[4]).to have_content 'コンテント５'
  end
end
