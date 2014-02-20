class EntrySearchResult < SearchResult
  attr_reader :title, :step

  def initialize(attributes={})
    @title = attributes[:title]
    @step = attributes[:step]
  end

  def ==(other)
    [:search_text, :snippet, :title, :step].all? do |attribute|
      other.send(attribute).eql?(self.send(attribute))
    end
  end

  def to_h
    { :search_text => search_text,
      :title => title,
      :step => step,
      :snippet => snippet }
  end
end