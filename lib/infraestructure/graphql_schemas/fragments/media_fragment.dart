class MediaFragments {
  static String reelFragment = r'''
fragment ReelNodeFragment on ReelTypeOut 
{
  username
  duration
  song{
    ...SongFragment
  }
  imageProfile
  reelId
  caption
  datePublication
  url
  locationReel {
    ...LocationFragment
  }
  tags
  likes
}
''';

  static String storyFragment = r'''
fragment StoryNodeFragment on StoryTypeOut{
  username
  imageProfile
  storyId
  postDate
  locationStory{
    ...LocationFragment
  }
  duration
  mediaUrl
  songMedia{
    ...SongFragment
  }
}
''';
  static String postFragment = r'''
fragment PostNodeFragment on PostTypeOut{
  song{
    ...SongFragment
  }
  imageProfile
  postId
  images
  caption
  datePublication
  likes
  comments{
    nodes{
      ...CommentFragment
    }
  }
  hashtags
}
''';
}

class MediaSubtypeFragment {
  static String linkFragment = r'''
fragment LinkFragment on LinkType {
  link
  title
}
''';
  static String replyFragment = r'''
fragment ReplyFragment on ReplyTypeOut{
  replyId,
  userId,
  text,
  date
}
''';
  static String commentFragment = r'''
fragment CommentFragment on CommentTypeOut {
  userId
  text
  date
  replies {
    nodes {
      ...ReplyFragment
    }
  }
}
''';

  static String songFragment = r'''
fragment SongFragment on SongMediaType{
  title
  artist
  url
  totalDuration
  selection{
    begin
    end
  }
}
''';
  static String locationFragment = r'''
fragment LocationFragment on LocationType{
  latitude
  longitude
}
''';
}
