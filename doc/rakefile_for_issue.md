# Rakefile for issue

We should have issue based project.
Issue should have git and Rakefile within a project.

story_files = **/*/story.md
story_pdf   = story_files.ext, pdf
section_pdf = ##/section.pdf

file  section_pdf => story_files

rule do |t|

end

file  section_pdf => story_pdf do
end

rule do |t|

end


task :update_repo do 

end
