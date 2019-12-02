# NewsLayout

## tables
  - Sections -> PageTemplates
  - Articles => ArtcileTemplates

  - WorkingArticles => WorkingArticles
  - Reorters
    belogns_to :Section

  - Section  
    - name
    - pages: (range
    - lead

    has_many :reporters
