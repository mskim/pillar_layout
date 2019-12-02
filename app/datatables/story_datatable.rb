class StoryDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      group: { source: "Story.group"},
      reporter: { source: "Story.reporter"},
      title: { source: "Story.title"},
    }
  end

  def data

    records.map do |record|
      {
        # example:
        # id: record.id,
        group: record.group,
        reporter: record.reporter,
        title: record.title,
      }
    end
  end

  def get_raw_records
    # insert query here
    Story.all
  end

end
