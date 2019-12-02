module Api
  class NewsLayout < Sinatra::Base

    get '/hello' do
      "Welcome from newsGo!"
    end

    # get issue_plan
    get '/api/v1/issue_plan' do
      plan = eval(Issue.last.plan)
      "#{plan.to_json}"
    end

    get '/api/v1/page/:date/:page_number' do
      # "page_number:#{payload[:page_number]}"
      "In refresh_page #{params[:page_number]}"
    end

    # update page content
    post '/api/v1/working_article/:date/:page/:order' do
      puts date  = params[:date]
      puts page  = params[:page].to_i
      puts order = params[:order].to_i
      puts payload = request.body.read


      puts json   = JSON.parse(payload.force_encoding("utf-8"))
      friendly_slog = "#{date}_#{page}_#{order}"
      working_article   = WorkingArticle.friendly.find(friendly_slog)
      puts "working_article:#{working_article}"
      if working_article
        working_article.update_columns(eval(payload))
        working_article.save
        working_article.generate_pdf_with_time_stamp
        working_article.page.generate_pdf_with_time_stamp
        "http:localhost/#{date}/#{page}/#{order}.jpg"
      else
        "not fount!!!: /#{page}/#{order}:#{order}"
      end

    end
  end
end
