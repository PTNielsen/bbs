class CommentMailer < ApplicationMailer
  default from: "admin@bbs.com"

  def comment_made post, current_user
    @post, @current_user = post, current_user
    binding.pry
    mail(
      to: post.author.email,
      subject: "New Comment on #{post.title}"
    )
  end
end