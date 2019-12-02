# Import Export Data

There was an interesting article about this
https://blog.eq8.eu/til/exporting-importing-migrating-large-amount-of-data-in-ruby-on-rails.html


## Our solution

After reading the article above, I thought we shoud also have some solution to import/export.
We alread have a exported data as folder, with all the data we need to reconstruct the Issue.
We can re-create the Issue, Page, Article, Image, Graphic, AdBox those files.

1. seed all other tables except Issue, Page, Article, Image, Graphic, AdBox.
1. Or clear the database for Issue, Page, Article, Image, Graphic, AdBox.
1. collect/copy all issue folders under publication
1. run rake style:rebulid_db task 