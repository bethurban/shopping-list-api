module RequestSpecHelper
  # Parse JSON to Ruby hash
  def json
    JSON.parse(response.body)
  end

end
