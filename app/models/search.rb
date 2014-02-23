class Search

  def self.in_big_book(query)
    all = BigBook::Chapter.all
    found = all.select do |chapter|
      chapter.attributes.any?{|attribute, data| data.to_s.downcase.include?(query.downcase)}
    end

    results = []
    found.each do |record|
      i = record.body.downcase.index(query.downcase) || 0
      j = i + query.length
      results.unshift(BigBookSearchResult.new(
        search_text: query, 
        chapter_number: record.chapter_number, 
        chapter_title: record.title, 
        snippet: "..." + record.body[i-20..i - 1] + "<span class='search-result'>" + 
          record.body[i,query.length] + "</span>" + record.body[j..j+20] + "..." ))
    end

    results
  end

  def self.for_entries(query, user_id)
    found = Entry.where(user_id: user_id).select do |entry|
      entry.body.include?(query)
    end
    results = []
    found.each do |record|
      i = record.body.downcase.index(query.downcase) || 0
      j = i + query.length
      results.unshift(EntrySearchResult.new(
        search_text: query, 
        title: record.title, 
        step: record.step, 
        snippet: "..." + record.body[i-20..i - 1] + "<span class='search-result'>" + 
          query + "</span>" + record.body[j..j+20] + "..." ))
    end
    results
  end

end