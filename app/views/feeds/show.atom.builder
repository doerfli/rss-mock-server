xml.instruct! :xml, :version => "1.0"
xml.feed :xmlns => "http://www.w3.org/2005/Atom" do
  xml.title @feed.title
  xml.subtitle @feed.subtitle
  xml.id @feed.iid
  xml.link(href: feed_url(@feed.iid), rel: 'self')
  xml.link(href: feed_url(@feed.iid))
  xml.updated @feed.items.last.published.xmlschema

  @feed.items.order("published DESC").limit(@num_items).each do |item|
    xml.entry do
      xml.title item.title
      xml.link(href: item.link)
      xml.id item.iid
      xml.published item.published.xmlschema
      xml.updated item.published.xmlschema
      xml.summary item.summary
      xml.content item.content
      
    end
  end
end
