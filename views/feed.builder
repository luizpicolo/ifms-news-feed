xml.instruct! :xml, :version => '1.0'
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "IFMS news Feed"
    xml.description "IFMS News Feed"
    xml.link "https://www.ifms.edu.br"

    @news.each do |feed|
      xml.item do
        xml.title feed[:title]
        xml.link feed[:link]
        xml.description feed[:description]
        xml.pubDate feed[:pubDate]
        xml.guid feed[:link]
      end 
    end 
  end 
end