class HomeController < ApplicationController

  def index
    if params[:page] && params[:page][:url].present?
      begin
        @doc = Nokogiri::HTML(URI.open(params[:page][:url]).read)
        @summary = @doc.xpath("//*").map(&:name).each_with_object({}) {|n, r| r[n] = (r[n] || 0) + 1 }
        @error = false
      rescue Exception => e
        puts "Couldn't read \"#{ params[:page][:url] }\": #{ e }"
        @error = true
      end
    end
  end

end
