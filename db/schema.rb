# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_20_200507) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "ad_bookings", force: :cascade do |t|
    t.bigint "publication_id"
    t.date "date"
    t.text "ad_list"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id"], name: "index_ad_bookings_on_publication_id"
  end

  create_table "ad_boxes", id: :serial, force: :cascade do |t|
    t.integer "grid_x"
    t.integer "grid_y"
    t.integer "column"
    t.integer "row"
    t.integer "order"
    t.string "ad_type"
    t.string "advertiser"
    t.boolean "inactive"
    t.string "ad_image"
    t.integer "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "color"
    t.string "path"
    t.date "date"
    t.integer "page_heading_margin_in_lines"
    t.integer "page_number"
    t.float "grid_width"
    t.float "grid_height"
    t.float "gutter"
    t.index ["page_id"], name: "index_ad_boxes_on_page_id"
  end

  create_table "ad_images", id: :serial, force: :cascade do |t|
    t.string "ad_type"
    t.integer "column"
    t.integer "row"
    t.string "ad_image"
    t.string "advertiser"
    t.integer "ad_box_id"
    t.integer "issue_id"
    t.boolean "used_in_layout"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "color"
  end

  create_table "ad_plans", force: :cascade do |t|
    t.date "date"
    t.integer "page_number"
    t.string "ad_type"
    t.string "advertiser"
    t.boolean "color_page"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "ad_booking_id"
    t.index ["ad_booking_id"], name: "index_ad_plans_on_ad_booking_id"
  end

  create_table "ads", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "column"
    t.integer "row"
    t.integer "page_columns"
    t.integer "publication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "annotation_checks", force: :cascade do |t|
    t.decimal "x"
    t.decimal "y"
    t.decimal "width"
    t.decimal "height"
    t.string "color"
    t.bigint "annotation_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["annotation_id"], name: "index_annotation_checks_on_annotation_id"
    t.index ["user_id"], name: "index_annotation_checks_on_user_id"
  end

  create_table "annotation_circles", force: :cascade do |t|
    t.decimal "x"
    t.decimal "y"
    t.decimal "width"
    t.decimal "height"
    t.string "color"
    t.bigint "annotation_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["annotation_id"], name: "index_annotation_circles_on_annotation_id"
    t.index ["user_id"], name: "index_annotation_circles_on_user_id"
  end

  create_table "annotation_comments", force: :cascade do |t|
    t.bigint "annotation_id", null: false
    t.bigint "user_id"
    t.text "comment"
    t.string "shape"
    t.string "color"
    t.integer "x"
    t.integer "y"
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "selected"
    t.index ["annotation_id"], name: "index_annotation_comments_on_annotation_id"
    t.index ["user_id"], name: "index_annotation_comments_on_user_id"
  end

  create_table "annotation_removes", force: :cascade do |t|
    t.decimal "x"
    t.decimal "y"
    t.decimal "width"
    t.decimal "height"
    t.string "color"
    t.bigint "annotation_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["annotation_id"], name: "index_annotation_removes_on_annotation_id"
    t.index ["user_id"], name: "index_annotation_removes_on_user_id"
  end

  create_table "annotation_underlines", force: :cascade do |t|
    t.decimal "x"
    t.decimal "y"
    t.decimal "width"
    t.decimal "height"
    t.string "color"
    t.bigint "annotation_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["annotation_id"], name: "index_annotation_underlines_on_annotation_id"
    t.index ["user_id"], name: "index_annotation_underlines_on_user_id"
  end

  create_table "annotations", force: :cascade do |t|
    t.bigint "working_article_id", null: false
    t.integer "version"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["working_article_id"], name: "index_annotations_on_working_article_id"
  end

  create_table "announcements", force: :cascade do |t|
    t.string "name"
    t.string "kind"
    t.string "title"
    t.string "subtitle"
    t.integer "page_column"
    t.integer "column"
    t.integer "lines"
    t.integer "page"
    t.string "color"
    t.text "script"
    t.bigint "publication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id"], name: "index_announcements_on_publication_id"
  end

  create_table "article_kinds", force: :cascade do |t|
    t.bigint "publication_id", null: false
    t.string "name"
    t.text "line_draw_sides"
    t.text "input_fields"
    t.integer "bottoms_space_in_lines"
    t.text "layout_erb"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["publication_id"], name: "index_article_kinds_on_publication_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "combo_ads", force: :cascade do |t|
    t.string "base_ad"
    t.integer "column"
    t.integer "row"
    t.text "layout"
    t.string "profile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string "name"
    t.string "text"
    t.string "image"
    t.float "x_value"
    t.float "y_value"
    t.float "width"
    t.float "height"
    t.bigint "proof_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proof_id"], name: "index_comments_on_proof_id"
  end

  create_table "expert_writers", force: :cascade do |t|
    t.string "name"
    t.string "work"
    t.string "position"
    t.string "email"
    t.string "category_code"
    t.string "expert_image"
    t.string "expert_jpg_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "graphic_requests", force: :cascade do |t|
    t.date "date"
    t.bigint "user_id"
    t.string "designer"
    t.text "request"
    t.text "data"
    t.integer "status", default: 0
    t.integer "page_column"
    t.integer "column"
    t.integer "row"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_graphic_requests_on_user_id"
  end

  create_table "graphics", force: :cascade do |t|
    t.integer "grid_x"
    t.integer "grid_y"
    t.integer "column"
    t.integer "row"
    t.integer "extra_height_in_lines"
    t.string "graphic"
    t.string "caption"
    t.string "source"
    t.string "position"
    t.integer "page_number"
    t.integer "story_number"
    t.bigint "working_article_id"
    t.integer "issue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "x_grid"
    t.integer "y_in_lines"
    t.integer "height_in_lines"
    t.boolean "draw_frame", default: false
    t.boolean "detail_mode"
    t.integer "zoom_level"
    t.integer "zoom_direction"
    t.integer "move_level"
    t.string "sub_grid_size"
    t.string "fit_type"
    t.string "title"
    t.text "description"
    t.string "reporter_graphic_path"
    t.integer "order"
    t.index ["working_article_id"], name: "index_graphics_on_working_article_id"
  end

  create_table "group_images", force: :cascade do |t|
    t.string "title"
    t.string "caption"
    t.string "source"
    t.string "direction"
    t.integer "position"
    t.bigint "working_article_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "column"
    t.integer "row"
    t.integer "extended_line_count"
    t.index ["working_article_id"], name: "index_group_images_on_working_article_id"
  end

  create_table "heading_ad_images", force: :cascade do |t|
    t.string "heading_ad_image"
    t.float "x"
    t.float "y"
    t.float "width"
    t.float "height"
    t.float "x_in_unit"
    t.float "y_in_unit"
    t.float "width_in_unit"
    t.float "height_in_unit"
    t.bigint "page_heading_id"
    t.string "advertiser"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.index ["page_heading_id"], name: "index_heading_ad_images_on_page_heading_id"
  end

  create_table "heading_bg_images", force: :cascade do |t|
    t.string "name"
    t.string "paper_size"
    t.string "heading_bg_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holidays", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", id: :serial, force: :cascade do |t|
    t.integer "column"
    t.integer "row"
    t.integer "extra_height_in_lines", default: 0
    t.string "image"
    t.string "caption_title"
    t.string "caption"
    t.string "source"
    t.integer "position"
    t.integer "page_number"
    t.integer "story_number"
    t.boolean "landscape"
    t.boolean "used_in_layout"
    t.integer "working_article_id"
    t.integer "issue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "extra_line"
    t.integer "x_grid"
    t.integer "y_in_lines"
    t.integer "height_in_lines"
    t.boolean "draw_frame", default: true
    t.integer "zoom_level", default: 1
    t.integer "zoom_direction", default: 5
    t.integer "move_level"
    t.integer "auto_size"
    t.string "fit_type"
    t.string "image_kind"
    t.boolean "not_related"
    t.string "reporter_image_path"
    t.integer "crop_x"
    t.integer "crop_y"
    t.integer "crop_w"
    t.integer "crop_h"
    t.integer "left_line", default: 0
    t.integer "top_line", default: 0
    t.integer "right_line", default: 0
    t.integer "bottom_line", default: 0
    t.integer "order"
  end

  create_table "issues", id: :serial, force: :cascade do |t|
    t.date "date"
    t.string "number"
    t.text "plan"
    t.integer "publication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "page_count"
    t.string "excel_file"
    t.index ["publication_id"], name: "index_issues_on_publication_id"
    t.index ["slug"], name: "index_issues_on_slug", unique: true
  end

  create_table "member_images", force: :cascade do |t|
    t.string "title"
    t.string "caption"
    t.string "source"
    t.integer "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "member_img"
    t.integer "group_image_id"
  end

  create_table "opinion_writers", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.string "work"
    t.string "position"
    t.string "email"
    t.string "cell"
    t.string "opinion_image"
    t.bigint "publication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_code"
    t.string "opinion_jpg_image"
    t.index ["publication_id"], name: "index_opinion_writers_on_publication_id"
  end

  create_table "page_heading_kinds", force: :cascade do |t|
    t.bigint "publication_id"
    t.string "page_type"
    t.text "layout_erb"
    t.integer "height_in_lines"
    t.string "bg_image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["publication_id"], name: "index_page_heading_kinds_on_publication_id"
  end

  create_table "page_headings", id: :serial, force: :cascade do |t|
    t.integer "page_number"
    t.string "section_name"
    t.string "date"
    t.text "layout"
    t.integer "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "page_layouts", force: :cascade do |t|
    t.float "doc_width"
    t.float "doc_height"
    t.string "ad_type"
    t.integer "page_type"
    t.integer "column"
    t.integer "row"
    t.integer "pillar_count"
    t.float "grid_width"
    t.float "grid_height"
    t.float "gutter"
    t.float "margin"
    t.text "layout"
    t.text "layout_with_pillar_path"
    t.text "pillars"
    t.integer "like"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "page_plans", id: :serial, force: :cascade do |t|
    t.integer "page_number"
    t.string "section_name"
    t.integer "selected_template_id"
    t.integer "column"
    t.integer "row"
    t.integer "story_count"
    t.string "profile"
    t.string "ad_type"
    t.string "advertiser"
    t.boolean "color_page"
    t.boolean "dirty"
    t.integer "issue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "deadline"
    t.string "display_name"
    t.index ["issue_id"], name: "index_page_plans_on_issue_id"
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.integer "page_number"
    t.string "section_name"
    t.integer "column"
    t.integer "row"
    t.string "ad_type"
    t.integer "story_count"
    t.boolean "color_page"
    t.string "profile"
    t.integer "issue_id"
    t.integer "page_plan_id"
    t.integer "template_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "clone_name"
    t.string "slug"
    t.text "layout"
    t.integer "publication_id"
    t.string "path"
    t.date "date"
    t.float "grid_width"
    t.float "grid_height"
    t.float "lines_per_grid"
    t.float "width"
    t.float "height"
    t.float "left_margin"
    t.float "top_margin"
    t.float "right_margin"
    t.float "bottom_margin"
    t.float "gutter"
    t.float "article_line_thickness"
    t.integer "page_heading_margin_in_lines"
    t.string "tag"
    t.string "display_name"
    t.boolean "draw_divider"
    t.string "edition", default: "A"
    t.index ["issue_id"], name: "index_pages_on_issue_id"
    t.index ["page_plan_id"], name: "index_pages_on_page_plan_id"
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "pillars", force: :cascade do |t|
    t.string "direction"
    t.integer "grid_x"
    t.integer "grid_y"
    t.integer "column"
    t.integer "row"
    t.integer "order"
    t.integer "box_count"
    t.text "layout_with_pillar_path"
    t.string "profile"
    t.bigint "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "has_drop_article"
    t.index ["page_id"], name: "index_pillars_on_page_id"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.text "body"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "profile_image"
    t.string "work"
    t.string "position"
    t.string "email"
    t.bigint "publication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.integer "category_code"
    t.string "profile_jpg_image"
    t.index ["publication_id"], name: "index_profiles_on_publication_id"
  end

  create_table "proofs", force: :cascade do |t|
    t.bigint "working_article_id"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["working_article_id"], name: "index_proofs_on_working_article_id"
  end

  create_table "publications", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "unit"
    t.string "paper_size"
    t.float "width_in_unit"
    t.float "height_in_unit"
    t.float "left_margin_in_unit"
    t.float "top_margin_in_unit"
    t.float "right_margin_in_unit"
    t.float "bottom_margin_in_unit"
    t.float "gutter_in_unit"
    t.float "width"
    t.float "height"
    t.float "left_margin"
    t.float "top_margin"
    t.float "right_margin"
    t.float "bottom_margin"
    t.float "gutter"
    t.integer "lines_per_grid"
    t.integer "page_count"
    t.text "section_names"
    t.text "page_columns"
    t.integer "row"
    t.integer "front_page_heading_height"
    t.integer "inner_page_heading_height"
    t.integer "article_bottom_spaces_in_lines"
    t.text "article_line_draw_sides"
    t.float "article_line_thickness"
    t.boolean "draw_divider"
    t.string "cms_server_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "variable_page_count"
  end

  create_table "qrcodes", force: :cascade do |t|
    t.decimal "x"
    t.decimal "y"
    t.decimal "width"
    t.decimal "height"
    t.string "qr_text"
    t.string "qrcode_file"
    t.string "qrcode_type"
    t.bigint "web_page_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["web_page_id"], name: "index_qrcodes_on_web_page_id"
  end

  create_table "reporter_graphics", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.string "caption"
    t.string "source"
    t.string "wire_pictures"
    t.string "section_name"
    t.boolean "used_in_layout"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "column"
    t.integer "row"
    t.integer "extra_height"
    t.string "status"
    t.string "designer"
    t.text "request"
    t.text "data"
    t.index ["user_id"], name: "index_reporter_graphics_on_user_id"
  end

  create_table "reporter_groups", force: :cascade do |t|
    t.string "section"
    t.string "page_range"
    t.string "leader"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_code"
  end

  create_table "reporter_images", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.string "caption"
    t.string "source"
    t.string "reporter_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "wire_pictures"
    t.string "section_name"
    t.boolean "used_in_layout"
    t.string "kind"
    t.index ["user_id"], name: "index_reporter_images_on_user_id"
  end

  create_table "reporters", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "title"
    t.string "cell"
    t.bigint "reporter_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reporter_group_id"], name: "index_reporters_on_reporter_group_id"
  end

  create_table "section_headings", force: :cascade do |t|
    t.integer "page_number"
    t.string "section_name"
    t.string "date"
    t.text "layout"
    t.integer "publication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spread_ad_boxes", force: :cascade do |t|
    t.string "ad_type"
    t.string "advertiser"
    t.integer "row"
    t.float "width"
    t.float "height"
    t.bigint "spread_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["spread_id"], name: "index_spread_ad_boxes_on_spread_id"
  end

  create_table "spreads", force: :cascade do |t|
    t.bigint "issue_id"
    t.integer "left_page_id"
    t.integer "right_page_id"
    t.integer "ad_box_id"
    t.boolean "color_page"
    t.float "width"
    t.float "height"
    t.float "left_margin"
    t.float "top_margin"
    t.float "right_margin"
    t.float "bottom_margin"
    t.float "page_gutter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ad_type"
    t.index ["issue_id"], name: "index_spreads_on_issue_id"
  end

  create_table "stories", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "working_article_id"
    t.date "date"
    t.string "reporter"
    t.string "group"
    t.string "title"
    t.string "subtitle"
    t.string "quote"
    t.string "body"
    t.integer "char_count"
    t.string "status"
    t.boolean "for_front_page"
    t.boolean "summitted"
    t.boolean "selected"
    t.boolean "published"
    t.time "summitted_at"
    t.string "path"
    t.integer "order"
    t.string "image_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "summitted_section"
    t.string "category_code"
    t.float "price"
    t.text "backup"
    t.string "subject_head"
    t.string "kind"
    t.string "by_line"
    t.string "category_name"
    t.string "story_type", default: "0"
    t.boolean "selected_for_web"
    t.integer "page_number"
    t.string "pillar_order"
    t.text "image_info"
    t.text "graphic_info"
    t.index ["user_id"], name: "index_stories_on_user_id"
    t.index ["working_article_id"], name: "index_stories_on_working_article_id"
  end

  create_table "story_categories", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "story_subcategories", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.bigint "story_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["story_category_id"], name: "index_story_subcategories_on_story_category_id"
  end

  create_table "stroke_styles", force: :cascade do |t|
    t.string "klass"
    t.string "name"
    t.text "stroke"
    t.bigint "publication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id"], name: "index_stroke_styles_on_publication_id"
  end

  create_table "table_styles", force: :cascade do |t|
    t.string "name"
    t.integer "column"
    t.integer "row"
    t.integer "heading_level"
    t.integer "category_level"
    t.text "layout"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tables", force: :cascade do |t|
    t.integer "column"
    t.integer "row"
    t.integer "extended_line_count"
    t.text "body"
    t.string "title"
    t.string "source"
    t.bigint "working_article_id", null: false
    t.integer "table_style_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["working_article_id"], name: "index_tables_on_working_article_id"
  end

  create_table "text_styles", id: :serial, force: :cascade do |t|
    t.string "korean_name"
    t.string "english"
    t.string "category"
    t.string "font_family"
    t.string "font"
    t.float "font_size"
    t.float "italic"
    t.string "text_color"
    t.string "alignment"
    t.float "tracking"
    t.float "space_width"
    t.float "scale"
    t.float "text_line_spacing"
    t.integer "space_before_in_lines"
    t.integer "space_after_in_lines"
    t.integer "text_height_in_lines"
    t.text "box_attributes"
    t.string "markup"
    t.text "graphic_attributes"
    t.integer "publication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "first_line_indent"
    t.index ["publication_id"], name: "index_text_styles_on_publication_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "role", default: 0
    t.string "cell"
    t.string "title"
    t.string "group"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.decimal "x"
    t.decimal "y"
    t.decimal "width"
    t.decimal "height"
    t.string "player_type"
    t.string "source_video_url"
    t.bigint "web_page_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["web_page_id"], name: "index_videos_on_web_page_id"
  end

  create_table "web_pages", force: :cascade do |t|
    t.string "current_tool"
    t.decimal "width"
    t.decimal "height"
    t.integer "page_number"
    t.boolean "toc"
    t.text "text_content"
    t.integer "text_position"
    t.bigint "issue_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["issue_id"], name: "index_web_pages_on_issue_id"
  end

  create_table "wire_stories", force: :cascade do |t|
    t.date "send_date"
    t.string "content_id"
    t.string "category_code"
    t.string "category_name"
    t.string "region_code"
    t.string "region_name"
    t.string "credit"
    t.string "source"
    t.string "title"
    t.text "body"
    t.bigint "issue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_id"], name: "index_wire_stories_on_issue_id"
  end

  create_table "working_articles", id: :serial, force: :cascade do |t|
    t.integer "grid_x"
    t.integer "grid_y"
    t.integer "column"
    t.integer "row"
    t.integer "order"
    t.string "kind"
    t.string "profile"
    t.text "title"
    t.string "title_head"
    t.text "subtitle"
    t.string "subtitle_head"
    t.text "body"
    t.string "reporter"
    t.string "email"
    t.string "image"
    t.text "quote"
    t.string "subject_head"
    t.boolean "on_left_edge"
    t.boolean "on_right_edge"
    t.boolean "is_front_page"
    t.boolean "top_story"
    t.boolean "top_position"
    t.boolean "inactive"
    t.integer "extended_line_count"
    t.integer "article_id"
    t.integer "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quote_box_size"
    t.integer "category_code"
    t.string "slug"
    t.string "publication_name"
    t.string "path"
    t.date "date"
    t.integer "page_number"
    t.integer "page_heading_margin_in_lines"
    t.float "grid_width"
    t.float "grid_height"
    t.float "gutter"
    t.boolean "has_profile_image"
    t.string "announcement_text"
    t.integer "announcement_column"
    t.string "announcement_color"
    t.integer "boxed_subtitle_type"
    t.string "boxed_subtitle_text"
    t.string "subtitle_type"
    t.text "overlap"
    t.boolean "embedded"
    t.integer "heading_columns"
    t.integer "quote_position"
    t.integer "quote_x_grid"
    t.integer "quote_v_extra_space"
    t.string "quote_alignment"
    t.string "quote_line_type"
    t.integer "quote_box_column"
    t.integer "quote_box_type"
    t.boolean "quote_box_show"
    t.integer "y_in_lines"
    t.string "by_line"
    t.float "price"
    t.integer "left_line", default: 0
    t.integer "top_line", default: 0
    t.integer "right_line", default: 0
    t.integer "bottom_line", default: 0
    t.string "category_name"
    t.string "subcategory_code"
    t.string "pillar_order"
    t.bigint "pillar_id"
    t.string "frame_sides"
    t.string "frame_color"
    t.float "frame_thickness"
    t.string "profile_image_position"
    t.string "ancestry"
    t.string "frame_bg_color"
    t.boolean "locked"
    t.string "attached_type"
    t.string "attached_position"
    t.integer "drop_floor", default: 0
    t.index ["article_id"], name: "index_working_articles_on_article_id"
    t.index ["page_id"], name: "index_working_articles_on_page_id"
    t.index ["pillar_id"], name: "index_working_articles_on_pillar_id"
    t.index ["slug"], name: "index_working_articles_on_slug", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "ad_bookings", "publications"
  add_foreign_key "ad_plans", "ad_bookings"
  add_foreign_key "annotation_checks", "annotations"
  add_foreign_key "annotation_checks", "users"
  add_foreign_key "annotation_circles", "annotations"
  add_foreign_key "annotation_circles", "users"
  add_foreign_key "annotation_comments", "annotations"
  add_foreign_key "annotation_removes", "annotations"
  add_foreign_key "annotation_removes", "users"
  add_foreign_key "annotation_underlines", "annotations"
  add_foreign_key "annotation_underlines", "users"
  add_foreign_key "annotations", "working_articles"
  add_foreign_key "announcements", "publications"
  add_foreign_key "article_kinds", "publications"
  add_foreign_key "comments", "proofs"
  add_foreign_key "graphic_requests", "users"
  add_foreign_key "graphics", "working_articles"
  add_foreign_key "group_images", "working_articles"
  add_foreign_key "heading_ad_images", "page_headings"
  add_foreign_key "issues", "publications"
  add_foreign_key "opinion_writers", "publications"
  add_foreign_key "page_plans", "issues"
  add_foreign_key "profiles", "publications"
  add_foreign_key "proofs", "working_articles"
  add_foreign_key "qrcodes", "web_pages"
  add_foreign_key "reporter_graphics", "users"
  add_foreign_key "reporter_images", "users"
  add_foreign_key "spread_ad_boxes", "spreads"
  add_foreign_key "spreads", "issues"
  add_foreign_key "stories", "users"
  add_foreign_key "stories", "working_articles"
  add_foreign_key "story_subcategories", "story_categories"
  add_foreign_key "stroke_styles", "publications"
  add_foreign_key "tables", "working_articles"
  add_foreign_key "text_styles", "publications"
  add_foreign_key "videos", "web_pages"
  add_foreign_key "web_pages", "issues"
  add_foreign_key "wire_stories", "issues"
  add_foreign_key "working_articles", "pillars"
end
