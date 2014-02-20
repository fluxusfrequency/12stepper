class SearchResult
  attr_reader :search_text, :snippet

  def self.model_name
  end

  def initialize(attributes={})
    @search_text = attributes[:search_text]
    @snippet = attributes[:snippet]
  end
end