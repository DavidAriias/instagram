class PostMutations{
  static String createPost = r'''
mutation($input: CreatePostInput!){
    createPost(input: $input){
        postEventType{
            statusCode,
            message
        }
    }
}
''';
}