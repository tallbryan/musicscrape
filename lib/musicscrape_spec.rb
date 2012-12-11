require "#{File.dirname(__FILE__)}/musicscrape"

describe Scrape do
  before do
    @scrape = Scrape.new(:web)
    
  end
  
  it "Should load the stranger music page" do
    @scrape.load_page.should include  '<title>Seattle Music' 
  end
  
  it "Should open a local file" do
    @scrape.open_local.should_not eq nil
  end
  
  it "Should get rid of everything except the recommended events" do
    @scrape =Scrape.new(:local)
    @pruned_test_file = open("#{File.dirname(__FILE__)}/pruned.txt", &:read)
    @pruned_page = @scrape.remove_excess(@scrape.load_page)
    @pruned_page[0..52].should eq "<h2 class=\"sitesection\">Recommended Music Events</h2>"
    @pruned_page[-10..-1].should eq "<li class="
  end
  
  it "Should pick out the first event on my cached html file" do
    @scrape =Scrape.new(:local)
    @pruned_page = @scrape.remove_excess(@scrape.load_page)
    @scrape.get_events(@pruned_page)[0].should == {:title=>"The Racer Sessions",:venue=>"Cafe Racer",:date => "Every Sun",:details =>"21+",}
  end
  
  it "Should run and create a valid Hash full of data on the live website and show it to me" do
    @scrape = Scrape.new(:web)
    @pruned_page = @scrape.remove_excess(@scrape.load_page)
    @result = @scrape.get_events(@pruned_page)
    @result.size.should_not eq nil
    puts @result
    puts @result[1][:details]
  end
  
end
