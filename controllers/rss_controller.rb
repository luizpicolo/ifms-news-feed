require "builder"
require "httparty"
require "nokogiri"
require "time"

get "/" do
    response = HTTParty.get("https://ifms.edu.br/noticias")
    body = Nokogiri::HTML(response.body)

    core = body.css('[id="content-core"]')[0]
    itens = core.css('[class="tileItem visualIEFloatFix tile-collective-nitf-content"]')

    @news = []
    
    itens.each do |item|
      title = item.css('[class="tileHeadline"]').text.strip
      link = item.css('[class="tileHeadline"] a').first["href"]
      description = item.css('[class="description"]').text
      image = core.css('[class="tileImage"] img').first["src"]
      date = item.css('[class=summary-view-icon]')[0].text
      hour = item.css('[class=summary-view-icon]')[1].text
      pubDate = Time.parse("#{date.strip} #{hour.strip}").rfc2822
      @news << {title: title, link: link, description: description, image: image, pubDate: pubDate}
    end
    
  builder :rss
end
