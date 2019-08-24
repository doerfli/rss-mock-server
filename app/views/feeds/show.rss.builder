xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @feed.title
    xml.description @feed.subtitle
    xml.link feed_url(@feed.iid)

    @feed.items.order("published DESC").limit(@num_items).each do |item|
      xml.item do
        xml.title item.title
        xml.description item.summary
        xml.pubDate item.published.to_s(:rfc822)
        xml.link item.link
        xml.guid item.iid
        xml.encoded item.content
      end
    end
  end
end
