# Sections = [ '1면', '정치', '자치행정', '국제통일', '금융', '산업', '정책', '기획', '오피니언']

# TODO
# i. create CLI NewsArticle
# i. create github repo from CLI
# 1. setup Gibhub action
# 1. setup Gibhub pages with repos

module IssueGithubWorkflow
  extend ActiveSupport::Concern
    def rakefile_path
      path + "/Rakefile"
    end

    def rake_content
      <<~EOF

      source_files = Rake::FileList.new("**/*.md") do |fl|
        # fl.exclude("~*")
        # fl.exclude(/^scratch\//)
        # fl.exclude do |f|
        #   `git ls-files #{f}`.empty?
        # end
      end
      task :default => :pdf
      task :pdf => source_files.ext(".pdf")

      rule ".pdf" => ".md" do |t|
        # sh "kramdown #{t.source} >> #{t.name} "
        sh "news_article #{t.source}"
      end

      page_pdfs = Rake::FileList.new("**/section.pdf")

      rake :page_pdf => page_pdfs 

      rule "section.pdf" => "story.pdf" do |t|
        sh "news_page #{t.source}"
      end

      EOF
    end

    def save_rakefile
      File.open(rakefile_path, 'w'){|f| f.write rake_content}
    end

    def create_github_page_html
      create_github_index_html
      pages.each do |page|
        page.github_page_html
      end
    end

    def create_github_page_index_html

    end

    def repo_folder
      folder = path + "/repo"
      FileUtils.mkdir_p(folder) unless File.exist?(folder)
      folder
    end

    def create_issue_reporepo_folder
      repo = repo_folder
      save_issue_readme(repo)
      pages.each do |page|
        page.save_page_repo(repo)
      end
      system("cd #{repo} && git init")
      system("cd #{repo} && git add .")
      system("cd #{repo} && git commit -m'initial commit'")
      system "cd #{repo} && hub create #{date_to_s}" 
      system "cd #{repo} && git push -u origin master"
    end

    def save_issue_readme(repo_path)
      read_me=<<~EOF
      ### Content for #{Publication.name}:Issue: #{date.to_s}

      ![](pages.first.pdf_path})

      EOF
      read_me_path = repo_path + '/README.md'
      File.open(read_me_path, 'w'){|f| f.write read_me} unless File.exist?(read_me)
    end

    # def save_page_readme(page)
    #   read_me=<<~EOF
    #   ### Content for Page: #{date.to_s}/#{page.page_number}

    #   ![](section.pdf})

    #   EOF
    #   read_me_path = page.path + '/README.md'
    #   File.open(read_me_path, 'w'){|f| f.write read_me} unless File.exist?(read_me)
    # end

    # def create_page_repo(page)
    #     save_page_readme(page)
    #     system("cd #{page.path} && git init")
    #     system("cd #{page.path} && git add .")
    #     system("cd #{page.path} && git commit -m'initial commit'")
    #     system "cd #{page.path} && hub create #{date_to_s}/#{page_number}" 
    #     system "cd #{page.path} && git push -u origin master"
    #     # add README.md file with jpg or PDF image
    # end

    def push_page_content(page_number)
        page = pages[page_number]
        system("cd #{page.path} && git push")
    end

    def pull_page_content(page_number)
        page = pages[page_number]
        system("cd #{page.path} && git pull")
    end

end