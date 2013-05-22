class AnswerNotification < ActionMailer::Base
  default from: "no-reply@recruiting.gentoo.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.answer.accept.subject
  #
  def accept(mentor, user, answer)
    @mentor = mentor
    @user = user
    @answer_url = candidate_answer_url(candidate_id:user.id, id: answer.id)

    mail to: user.email, subject: "You answer for #{answer.question.title} is accepted."
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.answer.reject.subject
  #
  def reject(mentor, user, answer)
    @user = user
    @mentor = mentor
    @question = answer.question.title
    @answer_url = candidate_answer_url(candidate_id:user.id, id: answer.id)

    mail to: user.email, subject: "You answer for #{@question} is rejected."
  end

  def update(user, answer)
    @user = user
    @answer_url = candidate_answer_url(candidate_id:user.id, id: answer.id)
    @question = answer.question.title

    mail to: user.mentors.map(&:email), subject: "#{user.name} update his answer for question #{@question}."
  end

  def new(user, answer)
    @greeting = "Hi"

    mail to: user.mentors.map(&:email), subject: "#{user.name} answered question #{answer.question.title}."
  end
end
