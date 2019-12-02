
# Time Stamping PDF

We are generating new pdf and we always want to display the newly created one.
But most web browsers cashe PDF preview, which is not what we want.
We don't wont it to cache.
So, the work around is to generate PDF file with different name each time, a time stamp at the end of new PDF filename.
This prevents PDF from being cached.

We also do not want to keep lots of old pdf files.
And when we merge articles into a page, we need easy way find a latest Page.

So the solution is to keep two PDF files.
    - one with normal name, and one with time stamped name.
    - story.pdf and story#{time_stamp}.pdf
    - delete previous time stamped file the next time new one is created
