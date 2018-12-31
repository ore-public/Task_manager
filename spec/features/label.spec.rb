# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'タスク管理機能', type: :feature do
  background do
    user = FactoryBot.create(:user)
    user_2 = FactoryBot.create(:not_john)
    task = FactoryBot.create(:task, user_id: user.id)
    FactoryBot.create(:second_task, user_id: user.id)
    FactoryBot.create(:task3, user_id: user.id)
    FactoryBot.create(:task4, user_id: user.id)
    FactoryBot.create(:task5, user_id: user.id)
    FactoryBot.create(:not_johns_task, user_id: user_2.id)
    label = FactoryBot.create(:label)
    FactoryBot.create(:task_label_relation, task_id: task.id, label_id: label.id)

    visit root_path
    fill_in 'Email', with: 'john@dic.jp'
    fill_in 'Password', with: 'aaaaaaaaaa'
    click_button 'Log in'

    expect(page).to have_content 'johnのページ'
  end

  scenario 'ラベルがタスクに紐づけられて表示されるかテスト' do
    visit root_path
    expect(page).to have_content 'MyString'
  end

  scenario 'ラベル新規作成のテスト' do
    visit new_task_path
    fill_in 'タスク名', with: 'maybete'
    fill_in 'タスク詳細', with: 'maybetest'
    select '2020', from: 'task_deadline_1i'
    fill_in 'Label', with: 'ラベルだよ'
    click_on '登録する'

    expect(page).to have_content 'maybete'
    expect(page).to have_content '未着手'
    expect(page).to have_content 'low'
    expect(page).to have_content 'ラベルだよ'
  end

  scenario 'ラベルを追加するテスト' do
    visit root_path
    task = Task.find_by(title: 'タイトル１')
    click_link '編集', href: edit_task_path(task)
    fill_in 'Label', with: 'ラベルじゃん'
    click_on '更新する'

    expect(page).to have_content 'ラベルじゃん'
  end

  scenario 'ラベルを削除するテスト' do
    visit root_path
    task = Task.find_by(title: 'タイトル１')
    click_link '編集', href: edit_task_path(task)
    click_on 'MyString'
    expect(page).to have_content '現在のラベル'
  end

  scenario 'ラベルを検索するテスト' do
    visit root_path
    task = Task.find_by(title: 'タイトル１')
    click_link '編集', href: edit_task_path(task)
    fill_in 'Label', with: 'ラベルじゃん'
    click_on '更新する'

    visit root_path
    find("option[value='ラベルじゃん']").select_option
    click_on 'Search'
    click_link '編集'

    expect(page).to have_content 'ラベルじゃん'
  end
end
