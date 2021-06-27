class QaInspectorsController < ApplicationController
  extend ConverseApi
  extend Format
  extend Chart

  def select
    @qa_inspector = QaInspectors.new
  end

  def chart
    @qa_inspector = QaInspectors.new(
      scheme: params[:scheme],
      host: params[:host],
      bot_id: params[:bot_id],
      user_id: params[:user_id],
      access_token: params[:access_token].chomp,
      test_data: params[:test_data]
    )
    if @qa_inspector.save
      url, req = ConverseApi.set_request(
        scheme: @qa_inspector.scheme,
        host: @qa_inspector.host,
        bot_id: @qa_inspector.bot_id,
        user_id: @qa_inspector.user_id,
        access_token: @qa_inspector.access_token
      )
      @@csv_data = CSV.generate do |csv|
        test_data = CSV.read(@qa_inspector.test_data, headers: true)
        csv << Chart.set_header(test_data['Serial_Nums'])
        answers_arr = test_data['Answers']
        test_data.each do |test_datum|
          begin
            res = ConverseApi.get_response(url: url, req: req, text: test_datum['Questions'])
          rescue SocketError
            flash[:alert] = 'Host is not apporopriate'
            return
          end
          begin
            csv << Chart.set_row(test_datum, answers_arr, res.body)
          rescue NoMethodError
            flash[:alert] = 'Bot ID, User ID or AccessToken is not apporopriate'
            return
          end
        end
      end
      @matrix = @@csv_data.split("\n").map { |str| str.split(',') }
    else
      render :select
    end
  end

  def export
    send_data(@@csv_data, filename: Format.matrix_filename)
  end
end
