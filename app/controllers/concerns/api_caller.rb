module ApiCaller
  def authenticate(protocol, host, bot_id, user_id, bearer_token)
    url = URI.parse("#{protocol}://#{host}/api/v1/bots/#{bot_id}/converse/#{user_id}/secured?include=state,suggestions")
    req = Net::HTTP::Post.new(url)
    req[:authorization] = bearer_token
    return url, req
  end

  def get_api_response(question, url, req)
    req.set_form_data(type: :text, text: question)
    net_http = Net::HTTP.new(url.host, url.port)
    net_http.use_ssl = true if url.to_s.include?('https')
    res = net_http.start { |http| http.request(req) }
  end
end
