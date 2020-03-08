# NewsLayout

## tables
  - Sections 
  - Articles => ArtcileTemplates

  - WorkingArticles => WorkingArticles
  - Reorters
    belogns_to :Section

  - Section  
    - name
    - pages: (range
    - lead

    has_many :reporters
