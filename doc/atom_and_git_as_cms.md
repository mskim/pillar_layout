
# Atom as content creating tool

## Atom can be a best content creating tool for us.

1. Can replace hangul, or word in Mac and Windows
1. It can preview markdown, pdf, and jpg
1. It can be connected to Github and layout server.

## Entire process can be a git workflow.

When new issue is created, create a repo named as date/section_group
Show the git repo path for each section group

Git repo for each team

Git webhook triggered layout as continuos Integration

feedback info from article_info file

1. folder name 2018-04-01-opinion.git

## What we need to develop?

1. update issue so that it creates git bare repo at shared
  - add web-hooks
1. upload initial content from web-site.
1. show the url of the git repo on issue page

1. ArticleTemplate with body_character_count
1. web-hook based workflow set up
1. Rakefile to generate pdf and push back after the PDF generation

## gitignore pdf and jpd files?

I should ignore story.pdf, story.jpg section.pdf, section.jpg, layout.pdf
Output can be viewed from web browser.
Putting back PDF output back to workflow cycle would complicate the workflow

## Article heading

/___
subject_head:
title:
subtitle:
quote:
quote_box_height:
image:
image_caption:
image_box_size:

quote_box:
/___
