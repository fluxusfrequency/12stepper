class SearchResult
  attr_reader :search_text, :chapter_number, :chapter_title, :snippet
  def initialize(attributes={})
    @search_text = attributes['search_text']
    @chapter_number = attributes['chapter_number']
    @chapter_title = attributes['chapter_title']
    @snippet = attributes['snippet']
  end

  def ==(other)
    [search_text, chapter_number, chapter_title, snippet].all? do |attr|
      
    end
  end
end