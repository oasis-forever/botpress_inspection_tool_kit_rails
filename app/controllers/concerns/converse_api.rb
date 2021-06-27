module ConverseApi
  def self.set_request(scheme:, host:, bot_id:, user_id:, access_token:)
    url = URI.parse("#{scheme}://#{host}/api/v1/bots/#{bot_id}/converse/#{user_id}/secured?include=state,suggestions")
    req = Net::HTTP::Post.new(url)
    req[:authorization] = access_token
    return url, req
  end

  def self.get_response(url:, req:, text:)
    req.set_form_data(type: :text, text: text)
    net_http = Net::HTTP.new(url.host, url.port)
    net_http.use_ssl = true if url.to_s.include?('https')
    res = net_http.start { |http| http.request(req) }
  end
end
