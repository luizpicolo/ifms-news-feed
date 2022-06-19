require 'builder'
require 'httparty'
require 'nokogiri'
require 'time'

get '/feed' do
    core = content.css('[id="content-core"]')[0]
    itens = core.css('[class="tileItem visualIEFloatFix tile-collective-nitf-content"]')

    @news = []
    
    itens.each do |item|
      @news << {
        title: item.css('[class="tileHeadline"]').text.strip, 
        link: item.css('[class="tileHeadline"] a').first["href"], 
        description: item.css('[class="description"]').text, 
        image: core.css('[class="tileImage"] img').first["src"], 
        pubDate: format_date(date_or_time(item, 0), date_or_time(item, 1))
      }
    end
    
  builder :feed
end

def content
  Nokogiri::HTML(HTTParty.get('https://ifms.edu.br/noticias').body)
end

def date_or_time(item, position)
  item.css('[class=summary-view-icon]')[position].text
end

def format_date(date, hour)
  Time.parse("#{date.strip} #{hour.strip}").rfc2822
end
