class ConverseApiController < ApplicationController
  include ApiCaller
  include MatrixGenerator

  before_action :alert_lacking_form_params, only: %i(generate_matrix)

  def select_data
  end

  def generate_matrix
    url, req = authenticate(
      converse_api_params[:protocol],
      converse_api_params[:host],
      converse_api_params[:bot_id],
      converse_api_params[:user_id],
      converse_api_params[:bearer_token]
    )
    @@csv_data = CSV.generate do |csv|
      test_data = CSV.read(converse_api_params[:csv_test_data], headers: true)
      csv << set_header(test_data['Serial_Nums'])
      answers_arr = test_data['Answers']
      test_data.each do |test_datum|
        begin
          res = get_api_response(test_datum['Questions'], url, req)
        rescue SocketError
          flash[:alert] = 'It failed to successfully create a matrix chart. Input correct Host.'
          return
        end
        begin
          csv << set_row(test_datum, answers_arr, res.body)
        rescue NoMethodError
          flash[:alert] = 'It failed to successfully create a matrix chart. Input correct Bot ID, User ID and Bearer Token.'
          return
        end
      end
    end
    @matrix = @@csv_data.split("\n").map { |str| str.split(',') }
  end

  def export_matrix
    send_data(
      @@csv_data,
      filename: "matrix_#{DateTime.current.strftime('%F%T').gsub('-', '').gsub(':', '')}.csv"
    )
  end

  private

  def converse_api_params
    params.permit(
      :protocol,
      :host,
      :bot_id,
      :user_id,
      :bearer_token,
      :csv_test_data
    )
  end

  def alert_lacking_form_params
    unless converse_api_params[:protocol] && \
          converse_api_params[:host] && \
          converse_api_params[:bot_id] && \
          converse_api_params[:user_id] && \
          converse_api_params[:bearer_token] && \
          converse_api_params[:csv_test_data]
      flash[:alert] = 'Fill in values or choose files in each field.'
      render :select_data
      return
    end
  end
end
