require 'rails_helper'

RSpec.describe "QaInspectors", type: :system do
  before do
    visit qa_inspectors_select_path
  end

  context 'Meet required parameters' do
    describe 'Render HTML matrix chart and doanload CSV' do
      before do
        select 'https', from: 'Scheme'
        fill_in 'Host', with: ENV['BOTPRESS_HOST']
        fill_in 'Bot', with: ENV['BOTPRESS_BOT_ID']
        fill_in 'User', with: ENV['BOTPRESS_USER_ID']
        fill_in 'Access token', with: ENV['BOTPRESS_ACCESS_TOKEN']
        attach_file 'Test data', "#{Rails.root}/spec/factories/test_data.csv"
        click_on 'Get Chart'
      end

      it 'succeeds in rendering HTML matrix chart' do
        expect(page).to have_current_path qa_inspectors_chart_path
      end

      it 'succeeds in downloading CSV matrix chart' do
        click_on 'Export'
        expect(download_file_name).to match(/matrix.*csv/)
      end

      it 'returns to root_path when page is reloaded' do
        visit current_path
        expect(page).to have_current_path qa_inspectors_select_path
      end
    end
  end

  context 'Not meet required parameters' do
    describe 'Validations' do
      context 'No param is filled' do
        before do
          click_on 'Get Chart'
        end

        it 'validation error messages show up' do
          expect(page).to have_current_path qa_inspectors_chart_path
          expect(page).to have_selector '.alert-danger', text: "Host can't be blank"
          expect(page).to have_selector '.alert-danger', text: "Bot can't be blank"
          expect(page).to have_selector '.alert-danger', text: "User can't be blank"
          expect(page).to have_selector '.alert-danger', text: "Access token can't be blank"
          expect(page).to have_selector '.alert-danger', text: "Test data can't be blank"
        end
      end

      context 'Only host is filled' do
        before do
          fill_in 'Host', with: ENV['BOTPRESS_HOST']
          click_on 'Get Chart'
        end

        it 'validation error messages show up' do
          expect(page).to have_current_path qa_inspectors_chart_path
          expect(page).to have_selector '.alert-danger', text: "Bot can't be blank"
          expect(page).to have_selector '.alert-danger', text: "User can't be blank"
          expect(page).to have_selector '.alert-danger', text: "Access token can't be blank"
          expect(page).to have_selector '.alert-danger', text: "Test data can't be blank"
        end
      end

      context 'Host and Bot ID are filled' do
        before do
          fill_in 'Host', with: ENV['BOTPRESS_HOST']
          fill_in 'Bot', with: ENV['BOTPRESS_BOT_ID']
          click_on 'Get Chart'
        end

        it 'validation error messages show up' do
          expect(page).to have_current_path qa_inspectors_chart_path
          expect(page).to have_selector '.alert-danger', text: "User can't be blank"
          expect(page).to have_selector '.alert-danger', text: "Access token can't be blank"
          expect(page).to have_selector '.alert-danger', text: "Test data can't be blank"
        end
      end

      context 'Host, BotID and UserID are filled' do
        before do
          fill_in 'Host', with: ENV['BOTPRESS_HOST']
          fill_in 'Bot', with: ENV['BOTPRESS_BOT_ID']
          fill_in 'User', with: ENV['BOTPRESS_USER_ID']
          click_on 'Get Chart'
        end

        it 'validation error messages show up' do
          expect(page).to have_current_path qa_inspectors_chart_path
          expect(page).to have_selector '.alert-danger', text: "Access token can't be blank"
          expect(page).to have_selector '.alert-danger', text: "Test data can't be blank"
        end
      end

      context 'Host, BotID, UserID and AccessToken are filled' do
        before do
          fill_in 'Host', with: ENV['BOTPRESS_HOST']
          fill_in 'Bot', with: ENV['BOTPRESS_BOT_ID']
          fill_in 'User', with: ENV['BOTPRESS_USER_ID']
          fill_in 'User', with: ENV['BOTPRESS_ACCESS_TOKEN']
          click_on 'Get Chart'
        end

        it 'validation error messages show up' do
          expect(page).to have_current_path qa_inspectors_chart_path
          expect(page).to have_selector '.alert-danger', text: "Test data can't be blank"
        end
      end
    end

    describe 'Exception Handling' do
      context 'Form items are filled with random Host' do
        before do
          select 'https', from: 'Scheme'
          fill_in 'Host', with: 'foo'
          fill_in 'Bot', with: ENV['BOTPRESS_BOT_ID']
          fill_in 'User', with: ENV['BOTPRESS_USER_ID']
          fill_in 'Access token', with: ENV['BOTPRESS_ACCESS_TOKEN']
          attach_file 'Test data', "#{Rails.root}/spec/factories/test_data.csv"
          click_on 'Get Chart'
        end

        it 'fails in rendering HTML matrix chart and an error message is shown' do
          expect(page).to have_current_path qa_inspectors_chart_path
          expect(page).to have_selector '.alert-danger', text: 'Host is not apporopriate'
        end
      end

      context 'Form items are filled with random BotID, UserID and AccessToken' do
        before do
          select 'https', from: 'Scheme'
          fill_in 'Host', with: ENV['BOTPRESS_HOST']
          fill_in 'Bot', with: 'foo'
          fill_in 'User', with: 'bar'
          fill_in 'Access token', with: 'piyo'
          attach_file 'Test data', "#{Rails.root}/spec/factories/test_data.csv"
          click_on 'Get Chart'
        end

        it 'fails in rendering HTML matrix chart and an error message is shown' do
          expect(page).to have_current_path qa_inspectors_chart_path
          expect(page).to have_selector '.alert-danger', text: 'Bot ID, User ID or AccessToken is not apporopriate'
        end
      end
    end
  end
end
