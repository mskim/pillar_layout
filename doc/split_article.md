# Split Article

## How to split article?

We need to create layout:text field in WorkingArticle table,
so that we can store story_frame info.

## sibling articles

Sibling Articles are an articles that are to the bottom of current article
that fall under the current article rect. It could be more than one.
It is used when we extended_line_count.

## Twin Article

Sibling Articles created when an article is split.
We can have two type of twins, horizontal twins when we split it vertically,
and vertical twins when we spit it horizontally.

## H_Twin article

H_Twin Article is an article that is to the right side of current article with
same y and height after vertical split. It can only be one.

## V_Twin article

V_Twin Article is an article that is to the bottom of current article with
same x and width after horizontal split. It can only be one.
