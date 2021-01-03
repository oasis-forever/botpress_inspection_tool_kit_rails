require 'rails_helper'

RSpec.describe "ConverseApi", type: :system do
  before do
    visit converse_api_select_data_path
  end

  describe 'Render HTML matrix chart and doanload CSV' do
    it 'enables users to get to converse_api_select_data_path' do
      expect(page).to have_current_path converse_api_select_data_path
    end

    context 'Form items are filled with proper values' do
      before do
        select 'https', from: 'protocol'
        fill_in 'Host', with: ENV['BOTPRESS_HOST']
        fill_in 'Bot ID', with: ENV['BOTPRESS_BOT_ID']
        fill_in 'User ID', with: ENV['BOTPRESS_USER_ID']
        fill_in 'Bearer Token', with: ENV['BOTPRESS_BEARER']
        attach_file 'Choose CSV Test Data', "#{Rails.root}/spec/factories/test_data.csv"
        click_on 'Generate Matrix Chart'
      end

      it 'succeeds in rendering HTML matrix chart' do
        expect(page).to have_current_path converse_api_generate_matrix_path
      end

      it 'succeeds in downloading CSV matrix chart' do
        click_on 'Export CSV'
        expect(download_file_name).to match(/matrix.*csv/)
      end

      it 'returns to root_path when page is reloaded' do
        visit current_path
        expect(page).to have_current_path converse_api_select_data_path
      end
    end

    context 'Form items are filled with random Host' do
      before do
        select 'https', from: 'protocol'
        fill_in 'Host', with: 'foo'
        fill_in 'Bot ID', with: ENV['BOTPRESS_BOT_ID']
        fill_in 'User ID', with: ENV['BOTPRESS_USER_ID']
        fill_in 'Bearer Token', with: ENV['BOTPRESS_BEARER']
        attach_file 'Choose CSV Test Data', "#{Rails.root}/spec/factories/test_data.csv"
        click_on 'Generate Matrix Chart'
      end

      it 'fails in rendering HTML matrix chart and an error message is shown' do
        expect(page).to have_current_path converse_api_generate_matrix_path
        expect(page).to have_selector '.alert-danger', text: 'It failed to successfully create a matrix chart. Input correct Host.'
      end
    end

    context 'Form items are filled with random BotID, UserID and Bearer Token' do
      before do
        select 'https', from: 'protocol'
        fill_in 'Host', with: ENV['BOTPRESS_HOST']
        fill_in 'Bot ID', with: 'foo'
        fill_in 'User ID', with: 'bar'
        fill_in 'Bearer Token', with: 'piyo'
        attach_file 'Choose CSV Test Data', "#{Rails.root}/spec/factories/test_data.csv"
        click_on 'Generate Matrix Chart'
      end

      it 'fails in rendering HTML matrix chart and an error message is shown' do
        expect(page).to have_current_path converse_api_generate_matrix_path
        expect(page).to have_selector '.alert-danger', text: 'It failed to successfully create a matrix chart. Input correct Bot ID, User ID and Bearer Token.'
      end
    end

    context 'CSV file is NOT chosen' do
      it 'succeeds in converting CSV file to JSON file' do
        click_on 'Generate Matrix Chart'
        expect(page).to have_selector '.alert-danger', text: 'Fill in values or choose files in each field.'
      end
    end
  end
end
