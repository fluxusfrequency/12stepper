class Search

  def self.in_big_book(query)
    all = BigBook::Chapter.all
    found = all.select do |chapter|
      chapter.attributes.any?{|attribute, data| data.include?(query)}
    end

    results = []
    found.each do |record|
      i = record.body.index(query) || 0
      j = i + query.length

      results << SearchResult.new(
        search_text: query, 
        chapter_number: record.chapter_number, 
        chapter_title: record.title, 
        snippet: "..." + record.body[i-20..i - 1] + "<span class='search-result'>" + 
          query + "</span>" + record.body[j..j+20] + "..." )
    end

    results
  end

end