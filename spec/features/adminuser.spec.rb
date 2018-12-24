require 'rails_helper'

RSpec.feature "ユーザ管理画面機能", type: :feature do

  background do
    user = FactoryBot.create(:user)
    user_2 = FactoryBot.create(:not_john)
    FactoryBot.create(:task, user_id: user.id)
    FactoryBot.create(:second_task, user_id: user.id)
    FactoryBot.create(:task3, user_id: user.id)
    FactoryBot.create(:task4, user_id: user.id)
    FactoryBot.create(:task5, user_id: user.id)
    FactoryBot.create(:not_johns_task, user_id: user_2.id)
    visit root_path
    fill_in "Email", with: "john@dic.jp"
    fill_in "Password", with: "aaaaaaaaaa"
    click_button "Log in"
  end

  scenario "管理者画面にユーザーが一覧で表示されているかテスト" do
    visit admin_users_path

    expect(page).to have_content "john"
    expect(page).to have_content "タスク数：5"
    expect(page).to have_content "not_john"
  end

  scenario "管理画面からユーザーを新規作成する" do
    visit admin_users_path
    click_on "新規作成"
    fill_in "Name", with: "josse"
    fill_in "Email", with: "josse@dic.jp"
    fill_in "Password", with: "cccccccccc"
    click_on "Add new user"

    expect(page).to have_content "ユーザーjosseを追加しました"
  end

  scenario "管理画面からユーザーの詳細画面を確認する" do
    visit admin_users_path
    find(".john-show").click
    expect(page).to have_content "john@dic.jp"
    expect(page).to have_content "タイトル１"
  end

  scenario "管理画面からユーザー情報を編集する" do
    visit admin_users_path
    find(".john-edit").click
    fill_in "Name", with: "jojonh"
    fill_in "Email", with: "jojonh@dic.jp"
    fill_in "Password", with: "dddddddddd"
    click_on "Edit user"

    expect(page).to have_content "jojonh"
  end

  scenario "管理画面からユーザー情報を削除する" do
    visit admin_users_path
    find(".not_john-destroy").click
    expect(page).to have_content "not_johnを削除しました"
  end
end
