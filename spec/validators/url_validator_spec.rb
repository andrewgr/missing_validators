require 'spec_helper'

describe UrlValidator do
  context "url has valid format" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :url, :name
        validates :url, url: true
      end
    end

    subject { klass.new }

    it { should ensure_valid_url_format_of(:url) }
    it { should_not ensure_valid_url_format_of(:name) }

    it { should allow_value("http://example.com").for(:url) }
    it { should allow_value("http://FooBar.cOm").for(:url) }
    it { should allow_value("http://foo.bar.baz.com").for(:url) }
    it { should allow_value("http://123.com").for(:url) }
    it { should allow_value("http://www.example.ru").for(:url) }
    it { should allow_value("http://user-example.co.uk").for(:url) }
    it { should allow_value("https://example.com").for(:url) }
    it { should allow_value("http://example.org/").for(:url) }
    it { should allow_value("https://example.net/index.html").for(:url) }
    it { should allow_value("http://example.net/login.php").for(:url) }
    it { should allow_value("https://example.travel/").for(:url) }
    it { should allow_value("http://example.aero").for(:url) }
    it { should allow_value("http://example.aero?foo=bar").for(:url) }

    it { should_not allow_value("example").for(:url) }
    it { should_not allow_value("http://user_examplecom").for(:url) }
    it { should_not allow_value("http://user_example.com").for(:url) }
    it { should_not allow_value("http://user_example.a").for(:url) }
  end

  describe "url must be in a specific domain" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :url1, :url2
        validates :url1, url: { domain: :org }
        validates :url2, url: { domain: [:org, 'edu', 'Com.Au'] }
      end
    end

    subject { klass.new }

    it { should allow_value("http://example.org").for(:url1) }
    it { should_not allow_value("http://example.com").for(:url1) }

    it { should allow_value("http://example.org").for(:url2) }
    it { should allow_value("http://example.edu").for(:url2) }
    it { should allow_value("http://example.com.au").for(:url2) }
    it { should allow_value("http://example.Com.Au").for(:url2) }
    it { should_not allow_value("http://example.com").for(:url2) }
  end

  describe "url must be domain root" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :url1, :url2
        validates :url1, url: { root: true }
        validates :url2, url: { root: false }
      end
    end

    subject { klass.new }

    it { should allow_value("http://example.org").for(:url1) }
    it { should allow_value("http://example.org/").for(:url1) }
    it { should_not allow_value("http://example.com/test").for(:url1) }
    it { should_not allow_value("http://example.com/#fragment").for(:url1) }
    it { should_not allow_value("http://example.com/?key=value").for(:url1) }


    it { should allow_value("http://example.org").for(:url2) }
    it { should allow_value("http://example.org/lorem").for(:url2) }
  end

  describe "url must have a specific scheme" do
    let(:klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :url1, :url2
        validates :url1, url: { scheme: 'http' }
        validates :url2, url: { scheme: ['HTTP', :https] }
      end
    end

    subject { klass.new }

    it { should allow_value("http://example.org").for(:url1) }
    it { should_not allow_value("https://example.org").for(:url1) }

    it { should allow_value("http://example.org").for(:url2) }
    it { should allow_value("https://example.org").for(:url2) }
    it { should allow_value("HTTPS://example.org").for(:url2) }
    it { should_not allow_value("ftp://example.org").for(:url2) }
  end
end
