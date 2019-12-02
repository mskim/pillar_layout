# Using friendly_id


gem 'freindly_id'

## update db

rake db:migrate

## change Model

add following to model
extend FriendlyId

### for WorkingArticle

friendly_id :method_to_genete_slug, use: :slugged

### for Issue, and Page

friendly_id :friendly_string, :use => [:slugged]

## change set_working_article, set_page, set_issue
  Model.find(params[id]) =>   Model.friendly.find(params[id]) =>

## update existing records

Model.find_each(&:save)
