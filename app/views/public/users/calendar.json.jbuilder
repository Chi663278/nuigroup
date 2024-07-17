json.array!(@posts) do |post|
  json.id post.id
  json.title post.caption
  json.start post.created_at.in_time_zone('Tokyo')
  json.end post.created_at.in_time_zone('Tokyo')
  json.img post.image
end