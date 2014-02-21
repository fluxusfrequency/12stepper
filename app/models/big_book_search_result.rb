class BigBookSearchResult < SearchResult
  attr_reader :chapter_number, :chapter_title

  def initialize(attributes={})
    @chapter_number = attributes[:chapter_number]
    @chapter_title = attributes[:chapter_title]
    super
  end

  def ==(other)
    [:search_text, :chapter_number, :chapter_title, :snippet].all? do |attribute|
      other.send(attribute).eql?(self.send(attribute))
    end
  end

  def to_h
    { :search_text => search_text,
      :chapter_number => chapter_number,
      :chapter_title => chapter_title,
      :snippet => snippet }
  end
end