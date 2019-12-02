# How to create section template

We need lots of section templates. They can be categorized by several levels.

  - page_columns
  - number_of_boxes,
  - number_of_articles
  - ad size
  - first_page

  7x15_3/1/base.rb
          /base.svg

  7x15_3/2/base.rb
          /base.svg

  7x15_3/3/base.rb
          /base.svg

  7x15_4/
  7x15_5/
  7x15_6/
  7x15_7/
  7x15_8/
  7x15_9/

We could automate creating above structure with a given data file with layout information, a file named with grid_base_box_count.csv.

7x15_2.csv
7x15_3.csv
7x15_4.csv
7x15_5.csv
7x15_6.csv
7x15_7.csv
7x15_8.csv
7x15_9.csv
7x15_10.csv
7x15_11.csv
7x15_12.csv

6x15_2.csv
6x15_3.csv
6x15_4.csv
6x15_5.csv
6x15_6.csv
6x15_7.csv
6x15_8.csv
6x15_9.csv
6x15_10.csv
6x15_11.csv
6x15_12.csv

1. Those file are created and put into to a folder
1. A Ruby Script is run
  1. creates a folder for each each group.
  1. creates a sub folder for each each item.
  1. creates SVG for each item.
  1. generates variations from the base, such as first_page, ad

Once those are setup, we can further organize them by section samples with profile
