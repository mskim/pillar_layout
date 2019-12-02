module WorkingArticlesHelper
    def story_group_url
        case session[:current_story_group]
        when 'first_group'
            first_group_stories_issue_path
        when 'second_group'
            second_group_stories_issue_path(article.issue)

        when 'third_group'
            third_group_stories_issue_path(article.issue)

        when 'fourth_group'
            fourth_group_stories_issue_path(article.issue)

        when 'fifth_group'
            fifth_group_stories_issue_path(article.issue)

        when 'sixth_group'
            sixth_group_stories_issue_path(article.issue)

        when 'seventh_group'
            seventh_group_stories_issue_path(article.issue)

        when 'eighth_group'
            eighth_group_stories_issue_path(article.issue)

        when 'nineth_group'
            nineth_group_stories_issue_path(article.issue)
        else
            issue_path(article.issue)
        end
    end


    
end