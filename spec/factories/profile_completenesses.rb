FactoryGirl.define do
  factory :profile_completeness do
    album_management ""
    site_content ""
    homepage_gallery ""
    video_portfolio ""
    testimonial ""
    contacts ""
    next_task "MyString"
    total_process 1
    completed_process 1
    user nil
  end
end
