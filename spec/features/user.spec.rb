require 'rails_helper'

RSpec.feature "ユーザーログイン機能", type: :feature do

  background do
    user = FactoryBot.create(:user)
    user_2 = FactoryBot.create(:not_john)
    FactoryBot.create(:task, user_id: user.id)
    FactoryBot.create(:second_task, user_id: user.id)
    FactoryBot.create(:task3, user_id: user.id)
    FactoryBot.create(:task4, user_id: user.id)
    FactoryBot.create(:task5, user_id: user.id)
    FactoryBot.create(:not_johns_task, user_id: user_2.id)

  end

  scenario "非ログイン時・タスク一覧へ移動するとログインページへ遷移するテスト" do
    visit root_path
    expect(page).to have_content "Password"
  end

  scenario "ユーザー作成・同時にマイページに遷移するテスト" do
    visit root_path
    click_on "Sign up"
    fill_in "Name", with: "josse"
    fill_in "Email", with: "josse@dic.jp"
    fill_in "Password", with: "cccccccccc"
    fill_in "Password confirmation", with: "cccccccccc"
    click_on "Create my account"
    expect(page).to have_content "josseのページ"
  end

  scenario "ログイン時ユーザー登録ができないようテスト" do
    visit root_path
    fill_in "Email", with: "john@dic.jp"
    fill_in "Password", with: "aaaaaaaaaa"
    click_button "Log in"

    visit new_user_path
    expect(page).to have_content "タイトル"
  end

  scenario "他ユーザーのマイページにいけないようテスト" do
    visit root_path
    fill_in "Email", with: "john@dic.jp"
    fill_in "Password", with: "aaaaaaaaaa"
    click_button "Log in"

    a = User.find_by(name: "not_john")

    visit "/users/#{a.id}"
    expect(page).to have_content "タイトル"
  end

  scenario "ログイン機能のテスト" do
    visit root_path
    fill_in "Email", with: "john@dic.jp"
    fill_in "Password", with: "aaaaaaaaaa"
    click_button "Log in"
    expect(page).to have_content "johnのページ"
  end
end
