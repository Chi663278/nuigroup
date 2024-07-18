json.array!(@posts) do |post|
  json.id post.id
  json.title post.caption
  json.start post.created_at.in_time_zone('Tokyo')
  json.end post.created_at.in_time_zone('Tokyo')
  json.img Rails.application.routes.url_helpers.rails_representation_url(post.get_post_image(50, 50).image.variant({}), only_path: true)
end