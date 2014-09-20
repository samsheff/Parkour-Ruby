require 'bundler'
Bundler.require

raise "No URL specified!" if ARGV.length == 0

Spidr.start_at(ARGV[0]) do |spider|

  spider.every_page do |page|
    Tire.index 'pages' do
      puts "Indexing Page at URL: #{page.url}"

      store page: page.body, title: page.title, 
        url: page.url rescue puts "Error saving page"
      
      refresh
    end
  end
end

