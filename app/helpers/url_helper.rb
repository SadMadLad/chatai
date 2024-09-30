module UrlHelper
  def build_query_url(base_url:, query_hash:)
    url = URI(base_url)
    url.query = URI.encode_www_form(query_hash)

    url.to_s
  end
end
