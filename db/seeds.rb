# frozen_string_literal: true

PROFILE_PICS = Dir['app/assets/images/faker/profile_pics/*']
COVER_PICS = Dir['app/assets/images/faker/covers/*']

def generate_account_attributes(index)
  { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, role: 0, username: "#{Random.hex}#{index}" }
end

password = 'password'

admin_account_attributes = { first_name: 'Admin', last_name: 'Admin', role: 1, username: 'admin' }
admin_user = User.create(email: 'admin@admin.com', password:, account_attributes: admin_account_attributes)
admin_user.account.account_tokens.create(scope: :frontend)

super_admin_account_attributes = { first_name: 'Superadmin', last_name: 'Superadmin', role: 2, username: 'superadmin' }
super_admin_user = User.create(
  email: 'superadmin@superadmin.com',
  password:,
  account_attributes: super_admin_account_attributes
)
super_admin_user.account.account_tokens.create(scope: :frontend)

normal_users = Array.new(20) do |i|
  { email: "user@#{i}.com", password:, account_attributes: generate_account_attributes(i) }
end

User.create(normal_users)

normal_accounts = Account.where(role: :user)
normal_accounts.each do |account|
  profile_pic = PROFILE_PICS.sample
  account.avatar.attach(
    io: File.open(Rails.root.join(profile_pic).to_s),
    filename: profile_pic
  )
end

# Creating Chat Messages

first_account = normal_accounts.first
second_account = normal_accounts.second

n = 10
last_n_accounts = normal_accounts.last(n)
first_n_accounts = normal_accounts.first(n)

chats_accounts = last_n_accounts.map { |account| [first_account, account] }
chats_accounts.each do |accounts|
  chat = Chat.create_chat(accounts)
  chat.messages.create(accounts.map { |account| { account:, content: account.full_name } })
end

4.upto 9 do |i|
  group_chat_accounts = normal_accounts.last(i) + [first_account]
  chat = Chat.create_chat(group_chat_accounts)
  chat.messages.create(group_chat_accounts.map { |account| { account:, content: Faker::Movies::TheRoom.quote } })
end

# Creating AI chats

5.times do |i|
  chat = Chat.create(chat_title: "AI Chat: #{i}", chat_type: :ai_chat, chat_status: 0)
  AccountChatMap.create(chat:, account: first_account)

  [7, 9, 12].sample.times do |j|
    chat.messages.create(role: j.even? ? :user : :assistant, content: Faker::Movies::TheRoom.quote,
                         account: j.even? ? first_account : nil)
  end
end

# Creating account tokens

first_n_accounts.each do |account|
  account.account_tokens.create([{ scope: :frontend }, { scope: :verse }])
end

# Creating subreddits

Subreddit.create(subreddit: 'r/rails', subreddit_url: 'https://www.reddit.com/r/rails')
Subreddit.create(subreddit: 'r/reactjs', subreddit_url: 'https://www.reddit.com/r/reactjs')

# Creating Live chats

chat_seagal = Chat.create(chat_type: 'live_room', chat_title: 'Steven Seagal Amazing Movies', chat_description: 'Hello')
chat_breen = Chat.create(chat_type: 'live_room', chat_title: 'Breen Cadence', chat_description: 'Hello 2')
chat_seagal.photo.attach(
  io: File.open(Rails.root.join(COVER_PICS.first).to_s),
  filename: COVER_PICS.first
)
chat_breen.photo.attach(
  io: File.open(Rails.root.join(COVER_PICS.second).to_s),
  filename: COVER_PICS.second
)

[first_account, second_account].each do |account|
  chat_seagal.messages.create(account:, content: Faker::Movies::TheRoom.quote)
end

last_n_accounts.each { |account| chat_breen.messages.create(account:, content: Faker::Movies::TheRoom.quote) }

posters = normal_accounts.first(3)
account_ids = normal_accounts.pluck(:id)

posters.each_with_index do |poster, index|
  1.upto(index + 2) do |_i|
    post = Post.new(account_id: poster.id, title: Faker::Book.title,
                    body: Faker::Lorem.paragraph(sentence_count: rand(20..29)))

    random_post_images = COVER_PICS.sample(rand(1..5))
    random_post_images.each do |img|
      post.images.attach(io: File.open(Rails.root.join(img).to_s), filename: img)
    end

    post.save

    # Create Likes
    likers = account_ids.sample Array(1..10).sample
    likes_data = likers.map { |l| { account_id: l, likeable_type: 'Post', likeable_id: post.id } }

    post.likes.create(likes_data)

    # Create Comments
    commenters = account_ids.sample Array(1..10).sample
    commenters_data = commenters.map do |c|
      { account_id: c, commentable_type: 'Post', commentable_id: post.id, body: Faker::Movies::TheRoom.quote }
    end

    comments = post.comments.create(commenters_data)

    # Create Replies
    comments.sample(Array(1..10).sample).each do |comment|
      reply = Comment.new(
        account_id: account_ids.sample,
        commentable_type: 'Comment',
        commentable_id: comment.id,
        body: Faker::Movies::TheRoom.quote
      )

      reply.save

      true_false = [true, false]
      should_have_reply = true_false.sample

      next unless should_have_reply

      reply_to_reply = Comment.new(
        account_id: account_ids.sample,
        commentable_type: 'Comment',
        commentable_id: reply.id,
        body: Faker::Movies::TheRoom.quote
      )

      reply_to_reply.save
    end
  end
end

# Generate Tags

books_tag = Tag.create(tag: 'Books', color: 'd5dde8')
education_tag = Tag.create(tag: 'Education', color: 'b2ffab')
economics_tag = Tag.create(tag: 'Economics', color: 'fff9ab')
government_tag = Tag.create(tag: 'Government', color: 'fcb3bb')
history_tag = Tag.create(tag: 'History', color: 'bdfcf6')
international_relations_tag = Tag.create(tag: 'International Relations', color: 'f9bdfc')
pakistan_tag = Tag.create(tag: 'Pakistan', color: 'a8edcf')
pakistan_foreign_policy_tag = Tag.create(tag: 'Pakistan\'s Foreign Policy', color: 'ffdfba')
pakistan_affairs_tag = Tag.create(tag: 'Pakistan\'s Affairs', color: 'cde3ca')
why_nations_fail_tag = Tag.create(tag: 'Why Nations Fail', color: 'b2ecf7')

# Seed some basic machine learning model/s and prediction params

ml_model = MlModel.create(
  title: 'Titanic',
  identifier: 'titanic',
  model_type: 'classification',
  description: 'Titanic Classification to see who has survived or not.',
  explanation: 'Explanation of the Machine Learning Model.',
  account: admin_user.account,
  parameters_with_order: %w[
    PassengerId
    Pclass
    Name
    Sex
    Age
    SibSp
    Parch
    Ticket
    Fare
    Cabin
    Embarked
  ]
)

prediction_params = [{ 'param_type' => 'integer', 'name' => 'PassengerId', 'description' => 'Ok',
                       'possible_values' => nil },
                     { 'param_type' => 'options', 'name' => 'Pclass', 'description' => 'ok',
                       'possible_values' => %w[3 2 1] },
                     { 'param_type' => 'text', 'name' => 'Name', 'description' => 'Name', 'possible_values' => nil },
                     { 'param_type' => 'options', 'name' => 'Sex', 'description' => 'n',
                       'possible_values' => %w[male female] },
                     { 'param_type' => 'float', 'name' => 'Age', 'description' => 'm', 'possible_values' => nil },
                     { 'param_type' => 'integer', 'name' => 'SibSp', 'description' => 'n', 'possible_values' => nil },
                     { 'param_type' => 'integer', 'name' => 'Parch', 'description' => 'm', 'possible_values' => nil },
                     { 'param_type' => 'integer', 'name' => 'Ticket', 'description' => 'm', 'possible_values' => nil },
                     { 'param_type' => 'float', 'name' => 'Fare', 'description' => 'n', 'possible_values' => nil },
                     { 'param_type' => 'string', 'name' => 'Cabin', 'description' => 'mm', 'possible_values' => nil },
                     { 'param_type' => 'options', 'name' => 'Embarked', 'description' => '321',
                       'possible_values' => %w[Q S C] }]
prediction_params = prediction_params.each { |param| param['ml_model_id'] = ml_model.id }

PredictionParam.create(prediction_params)

### Seed Quiz, Questions and QuestionOptions

def seed_quiz(quiz_json_file, tags: [], give_rating: true)
  quiz_data = JSON.parse Rails.root.join("app/assets/quizzes/#{quiz_json_file}.json").read
  quiz = Quiz.create(quiz_data)

  return quiz if tags.blank?

  tags.each { |tag| TagMap.find_or_create_by(taggable: quiz, tag:) }

  return quiz unless give_rating

  random_ratings_ranges = [rand(1..5), rand(3..5), rand(1..3)]
  raters = Account.where(role: :user).sample(5)
  raters.each { |rater| quiz.ratings.create(account: rater, rating: random_ratings_ranges.sample) }

  quiz
end

quiz_one_tags = [
  books_tag, international_relations_tag, education_tag, history_tag, pakistan_tag, pakistan_affairs_tag,
  pakistan_foreign_policy_tag
]
seed_quiz('foreign_policy_beginnings', tags: quiz_one_tags)

quiz_two_tags = [education_tag, government_tag, education_tag, pakistan_tag]
seed_quiz('government_of_pakistan', tags: quiz_two_tags)

quiz_three_tags = [education_tag, history_tag, pakistan_tag]
seed_quiz('pakistan_wikipedia', tags: quiz_three_tags)

quiz_four_tags = [books_tag, economics_tag, education_tag, history_tag, why_nations_fail_tag]
seed_quiz('small_differences_and_critical_junctures_the_weight_of_history', tags: quiz_four_tags)

quiz_five_tags = [
  books_tag, international_relations_tag, education_tag, history_tag, pakistan_tag, pakistan_affairs_tag,
  pakistan_foreign_policy_tag
]
seed_quiz('the_kashmir_question', tags: quiz_five_tags)

quiz_six_tags = [books_tag, economics_tag, education_tag, history_tag, why_nations_fail_tag]
seed_quiz('the_making_of_prosperity_and_poverty', tags: quiz_six_tags)

