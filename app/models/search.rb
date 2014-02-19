class Search

  def self.in_big_book(text)

    SearchResult.new(
      search_text: text, 
      chapter_number: 1, 
      chapter_title: "BILL'S STORY", 
      snippet: "WAR FEVER ran high in the New England town to which we new, young")
  end
  
end